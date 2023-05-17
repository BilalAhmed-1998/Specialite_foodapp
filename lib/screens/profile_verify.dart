import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/screens/profile_phone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../classes/OtpInput.dart';

class profile_verify extends StatefulWidget {
  static const routeName = '/profile_verify';
  @override
  _profile_verifyState createState() => _profile_verifyState();
}

class _profile_verifyState extends State<profile_verify> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();


  String _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,

        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
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
              AppLocalizations.of(context).numberVerify,
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
        padding: EdgeInsets.fromLTRB(0.w, 32.h, 0.w, 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context).verification,
                    style: TextStyle(
                      color: Color(0xff121212),
                      fontSize: 20.sp,
                      fontFamily: 'regular',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    AppLocalizations.of(context).codeIsSend,
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontSize: 14.sp,
                      fontFamily: 'regular',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpInput(_fieldOne, true),
                        OtpInput(_fieldTwo, false),
                        OtpInput(_fieldThree, false),
                        OtpInput(_fieldFour, false),
                        OtpInput(_fieldFive, false),
                        OtpInput(_fieldSix, false)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    AppLocalizations.of(context).didNotReceive,
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontSize: 14.sp,
                      fontFamily: 'regular',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
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
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffFDB601),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).verifyNumber,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'regular',
                      color: const Color(0xff121212),
                    ),
                  ),
                ),

              ),
            )



          ],
        ),
      ),
    );
  }
}
