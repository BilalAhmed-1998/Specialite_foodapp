import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';

class restaurantCard extends StatelessWidget {

  Restaurant restaurant;
  double height;
  double width;
  restaurantCard({this.restaurant,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: this.height,
      width: this.width,
      child:
      Stack(
        children: [
          Positioned.fill(
            child: Image.network(this.restaurant.images[0],
            fit: BoxFit.fitWidth,),
          ),
          Container(
            width: 342.w,
            height: 222.h,
            decoration: BoxDecoration(
                color: Colors.black,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff8B8B8B).withOpacity(0),
                      Color(0xff000000).withOpacity(0.6),
                    ]
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h,horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.restaurant.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),),
                SizedBox(height: 4.h,),
                Text(this.restaurant.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
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
