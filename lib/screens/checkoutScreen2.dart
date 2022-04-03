import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/screens/checkout_paymentSelection.dart';

import '../classes/allClasses.dart';
import '../dummyData.dart';



class checkoutScreen2 extends StatefulWidget {
  //const checkoutScreen2({Key? key}) : super(key: key);
  static const routeName = '/checkoutScreen2';


  @override
  _checkoutScreen2State createState() => _checkoutScreen2State();
}

class _checkoutScreen2State extends State<checkoutScreen2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    mainCheckout = Provider.of<Checkout>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffF0F3FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            //Provider.of<Checkout>(context, listen: false).orderSummary.clear();
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff303030),
            size: 22.sp,
          ),
        ),
        title: Text(
          "Order Details",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin:EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/paper.png"),
                              color: Color(0xFFfdb601),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "Order Summary",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontFamily: "regular",
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Text(
                          mainCheckout.dateTime,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        for (var selectedItemNo = 0;
                        selectedItemNo < mainCheckout.orderSummary.length;
                        selectedItemNo++)
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Container(
                              // color: Colors.amber,
                              width: 140.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    width: 24.w,
                                    height: 24.w,
                                    child: Image.asset(
                                      mainCheckout.orderSummary[selectedItemNo].image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    mainCheckout.orderSummary[selectedItemNo].title
                                        .split(' ')
                                        .first,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              //color: Colors.amber,
                              alignment: Alignment.centerRight,
                              width: 70,
                              child:
                              Consumer<Checkout>(
                                builder: (context, orderSummary, child) => Text(
                                  "¥ " +
                                      (mainCheckout.orderSummary[selectedItemNo].price *
                                          orderSummary
                                              .orderSummary[selectedItemNo].quantity)
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ]),
                        Divider(
                          height: 30.h,
                          thickness: 1,
                        ),
                        ///subtotal///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Consumer<Checkout>(
                              builder: (context, orderSummary, child) => Text(
                                "¥ " + orderSummary.subtotal.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xff555555),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          ],
                        ),
                        Divider(
                          height: 35.h,
                          thickness: 1,
                        ),
                        ///service fee///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service Fee",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "¥ 20.0",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff555555),
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                        SizedBox(height: 8.h,),
                        ///Tax fee///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "¥ 20.0",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff555555),
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),

                      ],
                    ),

                  ),
                  ///total cost///
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfffdb601),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                    width: 342.w,
                    height: 37.h,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<Checkout>(
                          builder: (context, orderSummary, child) => Text(
                            "¥ " + orderSummary.subtotal.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),

            ),
            SizedBox(height: 120.h,),
            Container(
              child: Image.asset("assets/images/pro15.png",
              height: 234.h,
              width: 234.w,
              fit: BoxFit.fill,),
            ),

          ],
        ),
      ),

    );
  }
}
