import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class profile_dialogue extends StatelessWidget {
  static const routeName = '/profile_dialogue';

  final String text;
  profile_dialogue({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: double.minPositive,
            height: 119.h,
            decoration: BoxDecoration(
              color: Colors.black54,
              // borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'regular',
                  fontWeight: FontWeight.w500,
                  color: Color(0xffFFFFFF),
                ),
              ),
            )
        ),
      ),
    );
  }
}
