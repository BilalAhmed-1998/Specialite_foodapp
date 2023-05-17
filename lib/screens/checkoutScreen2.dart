import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../classes/allClasses.dart';
import '../dummyData.dart';

class checkoutScreen2 extends StatefulWidget {
  static const routeName = '/checkoutScreen2';
  double tax;
  Order order;

  checkoutScreen2({this.order}) {
    tax = order.dineIn ? dineInTax : takeOutTax;
  }

  @override
  _checkoutScreen2State createState() => _checkoutScreen2State();
}

class _checkoutScreen2State extends State<checkoutScreen2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    margin: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
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
                              AppLocalizations.of(context).orderSummary,
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
                          "  " +
                              DateFormat('yyyy年 MMMM dEE', 'ja')
                                  .format(widget.order.dateTime.toDate()) +
                              "（木）" +
                              widget.order.orderSummary.first.time +
                              ":00",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        for (var selectedItemNo = 0;
                            selectedItemNo < widget.order.orderSummary.length;
                            selectedItemNo++)
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  width: 140.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        widget
                                                .order
                                                .orderSummary[selectedItemNo]
                                                .quantity
                                                .toString() +
                                            ' x ' +
                                            widget
                                                .order
                                                .orderSummary[selectedItemNo]
                                                .title
                                                .split(' ')
                                                .last,
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
                                  //width: 50,
                                  child: Text(
                                    "¥ " +
                                        formatter
                                            .format(widget
                                                    .order
                                                    .orderSummary[
                                                        selectedItemNo]
                                                    .price *
                                                widget
                                                    .order
                                                    .orderSummary[
                                                        selectedItemNo]
                                                    .quantity)
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey.shade700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                              AppLocalizations.of(context).subtotal,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "¥ " +
                                  formatter
                                      .format(widget.order.subtotal)
                                      .toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff555555),
                              ),
                              textAlign: TextAlign.center,
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
                              AppLocalizations.of(context).serviceFee,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "¥ " +
                                  formatter
                                      .format(widget.order.subtotal *
                                          serviceFee /
                                          100)
                                      .toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff555555),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///Tax fee///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).tax,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "¥ " +
                                  formatter
                                      .format(widget.order.subtotal *
                                          widget.tax /
                                          100)
                                      .toString(),
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
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                    width: 342.w,
                    height: 37.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).total,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "¥ " +
                              formatter
                                  .format(widget.order.subtotal)
                                  .toString(),
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
            SizedBox(
              height: 120.h,
            ),

            ///QR IMAGEEE!/////
            QrImage(
              data: widget.order.orderId,
              version: QrVersions.auto,
              size: 200,
              gapless: false,
            ),
          ],
        ),
      ),
    );
  }
}
