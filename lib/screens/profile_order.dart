import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/checkoutScreen2.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import '../classes/OtpInput.dart';
import '../classes/allClasses.dart';

class profile_order extends StatefulWidget {
  static const routeName = '/profile_order';
  @override
  _profile_orderState createState() => _profile_orderState();
}

class _profile_orderState extends State<profile_order> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,

        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, profile_homepage.routeName);
              },
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              'Orders',
              style: TextStyle(
                color: const Color(0xff121212),
                fontSize: 18.sp,
                fontFamily: 'regular',
                fontWeight: FontWeight.w500,

              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0.h),
          child: Column(
        //    mainAxisAlignment: ,
            children: [
              ///On Going Order///
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 51.h,
                width: 342.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfffdb601)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff8a959e).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0,8),

                    )],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,

                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined,
                    size: 24.sp,
                    color: Color(0xfffdb601),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),

                    Text(
                      'Ongoing Order',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff121212),
                      ),

                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              (mainCheckout.subtotal!=0)?
              InkWell(
                onTap: (){

                  Navigator.pushNamed(context, checkoutScreen2.routeName);
                },
                child: Container(
                  //  margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
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
                            ///date///
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text(
                                    mainCheckout.dateTime,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),

                                  Row(
                                      children:[
                                        (mainCheckout.dineIn)?
                                        Text("4 seats",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Color(0xff555555),
                                          ),):Container(),
                                        SizedBox(width: 12.w,),
                                        Container(
                                          height: 20.h,
                                          width: 52.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.5),
                                            color: Color(0xfffdb601).withOpacity(.2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              mainCheckout.dineIn?"Dine In":"Take Away",
                                              style: TextStyle(
                                                color: Color(0xffff5252),
                                                fontSize: 8.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ] ),

                                ]),
                            SizedBox(
                              height: 20.h,
                            ),
                            for (var selectedItemNo = 0;
                            selectedItemNo < mainCheckout.orderSummary.length;
                            selectedItemNo++)
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // color: Colors.amber,
                                      width: 140.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    // Row(
                                    //   children: [
                                    //     ClipRRect(
                                    //       borderRadius: BorderRadius.circular(100),
                                    //       child: InkWell(
                                    //         onTap: () {
                                    //           if (mainCheckout
                                    //               .orderSummary[selectedItemNo].quantity >
                                    //               1) {
                                    //             mainCheckout.decrementItemQuantity(selectedItemNo);
                                    //           }
                                    //         },
                                    //         child: Container(
                                    //             alignment: Alignment.center,
                                    //             width: 20.w,
                                    //             height: 20.h,
                                    //             color: Color(0xffd6d6d6),
                                    //             child: Icon(
                                    //               Icons.remove,
                                    //               color: Colors.black,
                                    //               size: 15.sp,
                                    //             )),
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 12.w,
                                    //     ),
                                    //     Consumer<Checkout>(
                                    //         builder: (context, orderSummary, child) => Text(
                                    //           "${(orderSummary.orderSummary.isNotEmpty) ? orderSummary.orderSummary[selectedItemNo].quantity : "1"}",
                                    //           style: TextStyle(fontWeight: FontWeight.bold),
                                    //         )),
                                    //     SizedBox(
                                    //       width: 12.w,
                                    //     ),
                                    //     ClipRRect(
                                    //       borderRadius: BorderRadius.circular(100),
                                    //       child: InkWell(
                                    //         onTap: () {
                                    //           mainCheckout.incrementItemQuantity(selectedItemNo);
                                    //         },
                                    //         child: Container(
                                    //             alignment: Alignment.center,
                                    //             width: 20.w,
                                    //             height: 20.h,
                                    //             color: Color(0xfffdb601),
                                    //             child: Icon(
                                    //               Icons.add,
                                    //               color: Colors.black,
                                    //               size: 15.sp,
                                    //             )),
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 20.w,
                                    //     ),
                                    //   ],
                                    // ),
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
              ):
                  Container(),
              (mainCheckout.subtotal!=0)?
              SizedBox(height: 50.h,):
              Container(),

              ///ORDER HISTORY///
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 51.h,
                width: 342.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff8a959e).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0,8),

                    )],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,

                ),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage("assets/images/pro14.png"),
                      color: Color(0xFFFDB601),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Order history',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff121212),
                      ),

                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              for(var i=0;i<orderHistory.length;i++)
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
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
                          ///date///
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Text(
                                  orderHistory[i].dateTime,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade800,
                                  ),
                                ),

                                Row(
                                    children:[
                                      (orderHistory[i].dineIn)?
                                      Text(orderHistory[i].seats.toString() + " seats",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff555555),
                                        ),):Container(),
                                      SizedBox(width: 12.w,),
                                      Container(
                                        height: 20.h,
                                        width: 52.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16.5),
                                          color: Color(0xfffdb601).withOpacity(.2),
                                        ),
                                        child: Center(
                                          child: Text(
                                            orderHistory[i].dineIn?"Dine In":"Take Away",
                                            style: TextStyle(
                                              color: Color(0xffff5252),
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ] ),

                              ]),
                          SizedBox(
                            height: 20.h,
                          ),
                          for (var selectedItemNo = 0;
                          selectedItemNo < orderHistory[i].orderSummary.length;
                          selectedItemNo++)
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    width: 140.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 8.w,),
                                        Text(
                                          orderHistory[i].orderSummary[selectedItemNo].title
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
                                  // Row(
                                  //   children: [
                                  //     ClipRRect(
                                  //       borderRadius: BorderRadius.circular(100),
                                  //       child: InkWell(
                                  //         onTap: () {
                                  //           if (mainCheckout
                                  //               .orderSummary[selectedItemNo].quantity >
                                  //               1) {
                                  //             mainCheckout.decrementItemQuantity(selectedItemNo);
                                  //           }
                                  //         },
                                  //         child: Container(
                                  //             alignment: Alignment.center,
                                  //             width: 20.w,
                                  //             height: 20.h,
                                  //             color: Color(0xffd6d6d6),
                                  //             child: Icon(
                                  //               Icons.remove,
                                  //               color: Colors.black,
                                  //               size: 15.sp,
                                  //             )),
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 12.w,
                                  //     ),
                                  //     Consumer<Checkout>(
                                  //         builder: (context, orderSummary, child) => Text(
                                  //           "${(orderSummary.orderSummary.isNotEmpty) ? orderSummary.orderSummary[selectedItemNo].quantity : "1"}",
                                  //           style: TextStyle(fontWeight: FontWeight.bold),
                                  //         )),
                                  //     SizedBox(
                                  //       width: 12.w,
                                  //     ),
                                  //     ClipRRect(
                                  //       borderRadius: BorderRadius.circular(100),
                                  //       child: InkWell(
                                  //         onTap: () {
                                  //           mainCheckout.incrementItemQuantity(selectedItemNo);
                                  //         },
                                  //         child: Container(
                                  //             alignment: Alignment.center,
                                  //             width: 20.w,
                                  //             height: 20.h,
                                  //             color: Color(0xfffdb601),
                                  //             child: Icon(
                                  //               Icons.add,
                                  //               color: Colors.black,
                                  //               size: 15.sp,
                                  //             )),
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 20.w,
                                  //     ),
                                  //   ],
                                  // ),
                                  Container(
                                    //color: Colors.amber,
                                    alignment: Alignment.centerRight,
                                    width: 70,
                                    child:
                                          Text(
                                        "¥ " + (orderHistory[i].orderSummary[selectedItemNo].price *
                                                orderHistory[i].orderSummary[selectedItemNo].quantity)
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey.shade700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                  )
                                ]),
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
                                Text(
                              "¥ " + (orderHistory[i].subtotal+(tax*orderHistory[i].subtotal/100)+(serviceFee*orderHistory[i].subtotal/100)).truncate().toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
