import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class profile_copied extends StatelessWidget {
  static const routeName = '/profile_copied';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xffFDB601),
                  size: 48,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  AppLocalizations.of(context).successfullyCopied,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'regular',
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
