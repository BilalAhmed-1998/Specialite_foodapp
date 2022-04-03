import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';

class checkout_chooseExisting extends StatefulWidget {
  static const routeName = '/checkout_chooseExisting';
  double amount;
  checkout_chooseExisting({this.amount});
  @override
  _checkout_chooseExisting createState() => _checkout_chooseExisting();
}

class _checkout_chooseExisting extends State<checkout_chooseExisting> {
  List cards = [
    // {
    //   'cardNumber': '4242424242424242',
    //   'expiryDate': '04/24',
    //   'cardHolderName': 'Shaheer Ali',
    //   'cvvCode': '123',
    //   'showBackView': false,
    //   'selected':true
    // },
    // {
    //   'cardNumber': '3566002020360505',
    //   'expiryDate': '04/24',
    //   'cardHolderName': 'Ghufran Ahmad',
    //   'cvvCode': '123',
    //   'showBackView': false,
    //   'selected':false,
    // },
    // {
    //   'cardNumber': '4242424242424242',
    //   'expiryDate': '04/24',
    //   'cardHolderName': 'Ghufran Ahmad',
    //   'cvvCode': '123',
    //   'showBackView': false,
    //   'selected':false,
    // }
  ];
  payViaExistingCard(BuildContext context, card){

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
              'Choose Existing Card',
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
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return InkWell(

                    onTap: (){
                      setState(() {
                        for (int i =0 ; i<cards.length; i++){
                          if(i!=index) {
                            cards[i]["selected"] = false;
                          }
                        }
                        cards[index]['selected']=true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: cards[index]['selected']==true?Colors.blue :Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CreditCardWidget(


                        onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                        cardNumber: cards[index]['cardNumber'],
                        expiryDate: cards[index]['expiryDate'],
                        cardHolderName: cards[index]['cardHolderName'],
                        //labelCardHolder: cards[index]['cardHolderName'],
                        cvvCode: cards[index]['cvvCode'],
                        showBackView: cards[index][
                        'showBackView'], //true when you want to show cvv(back) view
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
                margin: EdgeInsets.only(left:22.sp,right:22.sp,bottom: 25.h),
                child: Center(
                  child: Text(
                    'Done',
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
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, homeScreen.routeName);
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
