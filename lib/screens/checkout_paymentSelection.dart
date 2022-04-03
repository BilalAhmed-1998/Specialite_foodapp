import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:specialite_foodapp/screens/checkout_addNewCard.dart';
import 'package:specialite_foodapp/screens/checkout_chooseExisting.dart';

import '../services/paymentService.dart';

class checkout_paymentSelection extends StatefulWidget {
  static const routeName = '/checkout_paymentSelection';
  double amount;
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
              'Payment',
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

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => checkout_chooseExisting(
                      amount: widget.amount,
                    ),
                  ),
                );
                // CardDetails _card=CardDetails(
                //   number: '4242424242424242',
                //     expirationMonth: 12,
                //     expirationYear: 23,
                //     cvc: '123'
                // );
                // print(_card.expirationMonth);
                // var reponse= await StripeService.payWithNewCard(
                //     amount: '200',
                //     currency: 'usd',
                //     card: _card
                // );

              },
              child: payment_cards(Icons.credit_card_outlined, "Pay with Existing Card",20.h)
          ),
          InkWell(
              onTap: (){
                //pay with new card

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => checkout_addNewCard(
                      amount: widget.amount,
                    ),
                  ),
                );
                //Navigator.pushNamed(context, checkout_addNewCard.routeName);
              },
              child: payment_cards(Icons.add, "Pay with New Card",0)
          ),

        ],
      ),
    );
  }
}