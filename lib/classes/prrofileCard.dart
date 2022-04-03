import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class profileCard extends StatelessWidget {
  String icon = "";
  String text = "";

  profileCard(this.icon,this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 60.h,
      width: 342.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                ImageIcon(
                  AssetImage(icon),
                  size: 24.sp,
                  color: const Color(0xffFDB601),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff121212),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 14.sp,
            color: const Color(0xff000000),
          )
        ],
      ),
    );
  }
}
