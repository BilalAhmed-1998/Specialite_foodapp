import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/checkout_addNewCard.dart';
import 'package:specialite_foodapp/screens/checkout_chooseExisting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../classes/allClasses.dart';
import '../services/paymentService.dart';
import 'loadingScreen.dart';

class checkout_paymentSelection extends StatefulWidget {
  static const routeName = '/checkout_paymentSelection';
  int amount;
  checkout_paymentSelection({this.amount});

  @override
  _checkout_paymentSelectionState createState() => _checkout_paymentSelectionState();
}

class _checkout_paymentSelectionState extends State<checkout_paymentSelection> {
  Container payment_cards(IconData ic, String text, double topMargin){
    return Container(
      height: 50.h,
      width: 342.w,
      margin: EdgeInsets.fromLTRB(24.w, topMargin, 24.w, 16.h),
      padding: EdgeInsets.only(left:12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(ic,color: const Color(0xffFDB601),size:24.sp),
          SizedBox(width:8.w),
          Text(
              text,
              style: TextStyle(
                fontFamily: 'poppin',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff555555),
              )

          ),
        ],
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0A0A0A).withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 12.sp,
            offset: const Offset(0,4),

          )],
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    StripeService.init();
  }
  @override
  Widget build(BuildContext context) {
    List cardList=[];
    return Scaffold(
      backgroundColor: const Color(0xffF0F3FD),
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
              AppLocalizations.of(context).payment,
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
      body: Column(

        children: [
          InkWell(
              onTap: ()async{
                //pay with existing
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return loadingScreen();
                    });
                if(cardList.isEmpty){
                  cardList=await dbMain.getCards();
                }
                Navigator.pop(context);
                print(widget.amount);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => checkout_chooseExisting(
                      amount: widget.amount,
                      cards: cardList,
                      order: Order(
                        orderId: DateTime.now().toString() + FirebaseAuth.instance.currentUser.uid,
                        resturauntId: mainCheckout.restUid,
                          customerId: FirebaseAuth.instance.currentUser.uid,
                          dateTime: Timestamp.now(),
                          dineIn: mainCheckout.dineIn,
                          subtotal: widget.amount,
                          seats: mainCheckout.dineIn?mainCheckout.seatsLeft:0,
                          status: 'onGoing',
                          orderSummary: mainCheckout.orderSummary,

                      ),
                    ),
                  ),
                );

              },
              child: payment_cards(Icons.credit_card_outlined, AppLocalizations.of(context).payExistingCard,20.h)
          ),
          InkWell(
              onTap: (){
                //pay with new card

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => checkout_addNewCard(
                      amount: widget.amount,
                      order: Order(
                        orderId: DateTime.now().toString() + FirebaseAuth.instance.currentUser.uid,
                        resturauntId: mainCheckout.restUid,
                        customerId: FirebaseAuth.instance.currentUser.uid,
                        dateTime: Timestamp.now(),
                        dineIn: mainCheckout.dineIn,
                        subtotal: mainCheckout.subtotal,
                        seats: mainCheckout.seatsLeft,
                        status: 'onGoing',
                        orderSummary: mainCheckout.orderSummary,
                      ),
                    ),
                  ),
                );
                //Navigator.pushNamed(context, checkout_addNewCard.routeName);
              },
              child: payment_cards(Icons.add, AppLocalizations.of(context).payAddCard,0)
          ),

        ],
      ),
    );
  }
}
