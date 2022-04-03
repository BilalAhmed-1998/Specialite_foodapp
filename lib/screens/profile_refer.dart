import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/referralCard.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:specialite_foodapp/screens/profile_copied.dart';
import 'package:flutter/services.dart';
import 'package:specialite_foodapp/screens/profile_phone.dart';


class profile_refer extends StatefulWidget {

  static const routeName = '/profile_refer';

  @override
  _profile_referState createState() => _profile_referState();
}

class _profile_referState extends State<profile_refer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,

        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, profile_homepage.routeName);
              },
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              'Refer a friend',
              style: TextStyle(
                color: const Color(0xff121212),
                fontSize: 18.sp,
                fontFamily: 'regular',
                fontWeight: FontWeight.w500,

              ),
            ),

          ],
        ),
      ),
      body: Container(

        child: Column(
          children: [
            Container(
              height: 200.h,
              width: 319.w,
              margin: EdgeInsets.fromLTRB(35.w, 20.h, 35.w, 24.h),
              child: Image(
                image: AssetImage("assets/images/pro8.png"),
              ),
            ),
            Center(
              child: Text(
                'Refer a friend',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'regular',
                  fontWeight: FontWeight.w600,
                  color: Color(0xff121212),
                ),
              ),
            ),
            Center(
              child: Text(
                'And you can both earn a reward',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'regular',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff555555),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 342.w,
              height: 208.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff8a959e).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0,8),

                  )],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(12.w, 16.h, 0.w, 16.h),
              child: Stack(
                children: [
                  Positioned(
                    left: 16.w,
                    top: 32.h,
                    child: Image(
                      image: AssetImage("assets/images/pro9.png"),
                    ),
                  ),
                  Column(
                    children: [
                      referralCard("assets/images/pro10.png", 'Invite your friends', 'Just share your link',1),
                      SizedBox(
                        height: 28.h,
                      ),
                      referralCard("assets/images/pro10.png", 'They hit the restaurant', 'with reward',2),
                      SizedBox(
                        height: 28.h,
                      ),
                      referralCard("assets/images/pro10.png", 'You will be rewarded', 'you will get a reward',3),
                    ],
                  ),

                ],
              ),

            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 70.h,
              width: 342.w,
              padding: EdgeInsets.fromLTRB(12.w, 4.h, 16.w, 4.h),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff000000)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff8a959e).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0,8),

                  )],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 250.w,
                        child: Text(
                          refCode,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w700,
                            color: Color(0xff121212),
                          ),
                        ),
                      ),

                      Text(
                        'Share this code with your Friends',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff555555),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    enableFeedback: true,
                    onTap: (){
                      Clipboard.setData(ClipboardData(text: refCode));
                      Timer timer = Timer(Duration(milliseconds: 2000), (){
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context)
                          {
                            return profile_copied();
                          }).then((value){
                        // dispose the timer in case something else has triggered the dismiss.
                        timer?.cancel();
                        timer = null;
                      });;
                    },
                    child: Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        color: Color(0xffFFF0CB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ImageIcon(
                        AssetImage("assets/images/pro11.png"),
                        color: Color(0xFFFDB601),
                      ),

                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              enableFeedback: true,
              onTap: (){
                isVerified==false?
                Navigator.pushNamed(context, profile_phone.routeName):
                    null;
              },
              child: Container(
                height: 56.h,
                width: 342.w,
                decoration: BoxDecoration(
                  color: isVerified==false?Color(0xffFDB601):Colors.yellow[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Refer friends now',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff121212),
                      ),
                    ),
                    SizedBox(
                      width: 70.w,
                    ),
                    ImageIcon(
                      AssetImage("assets/images/pro12.png"),
                      color: Color(0xFF000000),
                    ),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
