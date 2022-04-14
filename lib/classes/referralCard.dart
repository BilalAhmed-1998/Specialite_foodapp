import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class referralCard extends StatelessWidget {
  String image = "";
  String text1 = "";
  String text2 = "";
  int num = 0;

  referralCard(this.image,this.text1,this.text2,this.num);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40.h,
      width: 340.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/pro10.png"),
              ),
              Text(
                num.toString(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xffFFFFFF),
                ),
              )
            ],

          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xff121212),
                ),
              ),
              Text(
                text2,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xff555555),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
