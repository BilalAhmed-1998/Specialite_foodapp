
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';


class orderHistoryCard extends StatelessWidget {
  Order order;
  
  orderHistoryCard({this.order});
  
  //const orderHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                        "  "+DateFormat('dd MMMM','ja').format(order.dateTime.toDate())+ "（木）"+DateFormat.Hm().format(order.dateTime.toDate()),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade800,
                        ),
                      ),

                      Row(
                          children:[
                            (order.dineIn)?
                            Text(order.seats.toString()+' seats',
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
                                  order.dineIn?"Dine In":"Take Away",
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
                ///dish items
                for (var selectedItemNo = 0;
                selectedItemNo < order.orderSummary.length;
                selectedItemNo++)
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          // color: Colors.amber,
                          width: 140.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 8.w,),
                              Text(
                                // order.orderSummary[selectedItemNo].quantity.toString()+'  '+
                                    order.orderSummary[selectedItemNo].title,
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
                          child:Text(
                            "¥ " +
                                (order.orderSummary[selectedItemNo].price *
                                    order
                                        .orderSummary[selectedItemNo].quantity)
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
                  "¥ " + order.subtotal.toString(),
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

    );
  }
}
