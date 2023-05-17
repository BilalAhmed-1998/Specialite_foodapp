import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../classes/allClasses.dart';
import '../dummyData.dart';
import '../services/paymentService.dart';
import 'loadingScreen.dart';

class checkout_chooseExisting extends StatefulWidget {
  static const routeName = '/checkout_chooseExisting';
  int amount;
  Order order;
  List cards;
  checkout_chooseExisting({this.amount, this.cards, this.order});
  @override
  _checkout_chooseExisting createState() => _checkout_chooseExisting();
}

class _checkout_chooseExisting extends State<checkout_chooseExisting> {
  TextEditingController cvvController=TextEditingController();
  showAlertDialog(BuildContext context, CardDetails _card) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        CardDetails current=CardDetails(
          cvc: cvvController.text,
          expirationMonth: _card.expirationMonth,
          expirationYear: _card.expirationYear,
          number: _card.number,
        );
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return loadingScreen();
            });
        dynamic response = await StripeService.payWithNewCard(
            amount: (widget.amount.round()).toString(),
            currency: 'JPY',
            card: current);
        print(response.success);
        if(response.success){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('取引が完了しました'),
              duration: Duration(seconds: 2),
            ),
          );

          await dbMain.updateOrders(widget.order);
          Provider.of<Checkout>(context, listen: false).orderSummary.clear();

          if (refCheckoutInfo[0]){
            await dbMain.decrementBonus(refCheckoutInfo[1], context);
          }
          Navigator.popUntil(context, (route) => false);
          Navigator.pushNamed(context, homeScreen.routeName);
        }else{
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('取引に失敗しました'),
              duration: Duration(seconds: 2),
            ),
          );
        }


      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment confirmation"),
      content: Container(
        child: TextField(
          controller: cvvController,
          obscureText: true,
          maxLength: 4,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'CVV',
          ),

        ),
      ),

      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool check =true;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              AppLocalizations.of(context).chooseExisting,
              style: TextStyle(
                color: const Color(0xff121212),
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height:height-190.h,
              padding: EdgeInsets.only(left:10.sp,right: 10.sp,top: 10.sp),
              child: ListView.builder(
                itemCount: widget.cards.length,
                itemBuilder: (context, index) {
                  return InkWell(

                    onTap: (){
                      setState(() {
                        for (int i =0 ; i<widget.cards.length; i++){
                          if(i!=index) {
                            widget.cards[i]["selected"] = false;
                          }
                        }

                        widget.cards[index]['selected']=true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.cards[index]['selected']==true?Colors.blue :Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CreditCardWidget(


                        onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                        cardNumber: widget.cards[index]['number'],
                        expiryDate: widget.cards[index]['expirationMonth']+'/'+ widget.cards[index]['expirationYear'],
                        cardHolderName: 'NIL',//widget.cards[index]['cardHolderName'],
                        cvvCode: '123',
                        showBackView: false, //true when you want to show cvv(back) view
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                      ),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              child: Container(
                //width:width,
                height: 56.h,
                margin: EdgeInsets.only(left:22.sp,right:22.sp,bottom: 25.h,top: 5.h),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).done,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: !check
                      ? Color(0xfffdb601).withOpacity(0.3)
                      : Color(0xfffdb601),
                ),
              ),
              onTap: !check
                  ? null
                  : () {
                if (true) {
                  print('valid!');
                  for(int i = 0 ; i< widget.cards.length; i++){
                    try{
                      if(widget.cards[i]["selected"]){
                        CardDetails _card = CardDetails(
                          number: widget.cards[i]['number'],
                          expirationMonth: int.parse(widget.cards[i]['expirationMonth']),
                          expirationYear: int.parse(widget.cards[i]['expirationYear']),
                          cvc: '',
                        );
                        print(_card);
                        showAlertDialog(context, _card);
                      }
                    }catch(e){
                      print("choose a card");
                    }
                  }
                } else {
                  print('invalid!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
