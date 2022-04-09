import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'allClasses.dart';

class favourites_card extends StatefulWidget {
  Restaurant fav;
  favourites_card({this.fav});
  @override
  _favourites_cardState createState() => _favourites_cardState();
}

class _favourites_cardState extends State<favourites_card> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            height: 200.h,
            width:width,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width:width,
                    child: Image.network(
                      widget.fav.images[0],
                      fit: BoxFit.fill,
                    ),

                  ),
                ),
                Positioned(
                  left: 10.w,
                  bottom: 15.h,
                  child: Container(
                      height: 26.h,
                      width: 56.w,
                    child: Center(child: Text('Open',style: TextStyle(fontSize: 12.sp,fontFamily: 'regular',color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.white70.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16.sp),
                    ),

                ),
                ),
              ],
            ),

          ),
          SizedBox(height: 20.h,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.fav.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        widget.fav.favt =
                        !widget.fav.favt;
                      });
                    },
                    child: (!widget.fav.favt)
                        ? Icon(
                      Icons.favorite_border_outlined,
                    )
                        : Icon(
                      Icons.favorite,
                      color: Color(0xffff5252),
                    )),
              ]),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(

              widget.fav.description,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              SmoothStarRating(
                allowHalfRating: true,
                onRated: (v) {},
                starCount: 5,
                rating: widget.fav.rating,
                isReadOnly: true,
                size: 20.sp,
                color: Color(0xffFCD34D),
                borderColor: Colors.black,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                "+" +
                    widget.fav.totalRating
                        .truncate()
                        .toString() +
                    " ratings",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 19.h,
          ),
        ],
      ),
    );
  }
}
