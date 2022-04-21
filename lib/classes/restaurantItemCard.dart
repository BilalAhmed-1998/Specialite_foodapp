import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';


class restaurantItemCard extends StatelessWidget {
  //const restaurantItemCard({Key? key}) : super(key: key);
 RestaurantItem restaurantItem;

 restaurantItemCard({this.restaurantItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      //margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff0A0A0A).withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 12.sp,
            offset: Offset(0,4),

          )],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 342.w,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.w,
            height: 76.h,
            child: Image.network(this.restaurantItem.image,
            fit: BoxFit.fill,),

          ),
          SizedBox(width: 16.w,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurantItem.itemTitle,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),),
                Text(restaurantItem.description,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
