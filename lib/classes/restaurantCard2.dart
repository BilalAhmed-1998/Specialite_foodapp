import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';

class restaurantCard2 extends StatefulWidget {
  //const restaurantCard2({Key? key}) : super(key: key);

  Restaurant restaurant;
  double height;
  double width;

  restaurantCard2({this.restaurant, this.width, this.height});

  @override
  _restaurantCard2State createState() => _restaurantCard2State();
}

class _restaurantCard2State extends State<restaurantCard2> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.only(right: 8.w),
      width: this.widget.width,
      //height: this.widget.height,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(

              width: this.widget.width,
              height: 152.h,
              child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(this.widget.restaurant.images[0],
                    fit: BoxFit.fill,),
                ),
                Positioned(
                  left: 12.w,
                  bottom: 12.h,
                  child: Container(
                    width: 57.w,
                    //height: 26.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.5),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffffffff).withOpacity(0.5),
                              Color(0xffffffff).withOpacity(0.5),
                            ]
                        )
                    ),
                    child: Center(
                      child: Text(
                        this.widget.restaurant.open?"Open":"Close",
                      textAlign: TextAlign.center,
                      style: TextStyle(

                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),),
                    ),
                  ),
                ),

              ],
        ),
            ),
          ),
          SizedBox(height: 8.h,),
          Container(
            margin: EdgeInsets.only(right: 4.w),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(this.widget.restaurant.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(CupertinoIcons.star_fill,color: Colors.amber,size: 15,),
                        Text(" "+this.widget.restaurant.rating.toString(),
                            style: TextStyle(
                             fontSize: 13.sp,
                          color: Color(0xff555555),
),
                        )


                    ],)
                ]),
                SizedBox(height: 4.h,),
                Container(
                  height: 20.h,
                  child: Text(this.widget.restaurant.description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),),
                ),


              ],
            ),
          ),

      ]),
    );
  }
}
