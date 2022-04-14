import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dummyData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class profile_picture extends StatelessWidget {
  static const routeName = '/profile_picture';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        width: 342.w,
        height: 415.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              margin: const EdgeInsets.all(12),
              width: 318.w,
              height: 318.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    myimage,
                    fit: BoxFit.cover,
                  ),
                )

            ),
            InkWell(
              enableFeedback: true,
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 56.h,
                width: 342.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff8a959e).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0,8),

                    )],
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                  color: const Color(0xffFDB601),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'regular',
                      color: const Color(0xff121212),
                    ),
                  ),
                ),

              ),
            ),
          ],
        )
      ),
    );
  }
}
