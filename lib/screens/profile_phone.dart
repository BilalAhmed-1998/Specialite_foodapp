import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/profile_copied.dart';
import 'package:specialite_foodapp/screens/profile_dialogue.dart';
import 'package:specialite_foodapp/screens/profile_refer.dart';
import 'package:specialite_foodapp/screens/profile_verify.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class profile_phone extends StatefulWidget {
  static const routeName = '/profile_phone';
  @override
  _profile_phoneState createState() => _profile_phoneState();
}

class _profile_phoneState extends State<profile_phone> {
  String phone;
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
                Navigator.popAndPushNamed(context, profile_refer.routeName);
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
             AppLocalizations.of(context).continueWithPhone,
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
        padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 275.w,
                    height: 210.h,
                    child: Image(
                      image: AssetImage("assets/images/pro13.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  AppLocalizations.of(context).phoneNumber,
                  style: TextStyle(
                    color: Color(0xff121212),
                    fontSize: 20.sp,
                    fontFamily: 'regular',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  height: 60.h,
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
                    color: Colors.white,

                  ),
                  child: Center(
                    child: TextField(
                      controller: controller3,
                      onChanged: (text){
                        phone=text;
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: AppLocalizations.of(context).enterMobileNumber,
                        hintStyle: TextStyle(
                            color: const Color(0xff121212),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'regular'
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  AppLocalizations.of(context).receiveDigitCode,
                  style: TextStyle(
                    color: Color(0xff555555),
                    fontSize: 14.sp,
                    fontFamily: 'regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            InkWell(
              enableFeedback: true,
              onTap: () async {
                phoneNo=phone;

                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.verifyPhoneNumber(
                  phoneNumber: '+81'+phoneNo,

                  verificationFailed: (FirebaseAuthException e) {
                    if (e.code == 'invalid-phone-number') {
                      print('The provided phone number is not valid.');
                      Clipboard.setData(ClipboardData(text: refCode));
                      Timer timer = Timer(Duration(milliseconds: 2000), (){
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context)
                          {
                            return profile_dialogue(text: 'Invalid Phone Number',);
                          }).then((value){
                        // dispose the timer in case something else has triggered the dismiss.
                        timer?.cancel();
                        timer = null;
                      });;
                    }
                  },
                  codeSent: (String verificationId, int resendToken) async {
                    await Navigator.pushNamed(context, profile_verify.routeName);
                    String smsCode = phoneCode;

                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                    await auth.signInWithCredential(credential);
                    isVerified=true;
                    Clipboard.setData(ClipboardData(text: refCode));
                    Timer timer = Timer(Duration(milliseconds: 2000), (){
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context)
                        {
                          return profile_dialogue(text: 'Phone Number Verified',);
                        }).then((value){
                      // dispose the timer in case something else has triggered the dismiss.
                      timer?.cancel();
                      timer = null;
                    });;
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );


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
                    AppLocalizations.of(context).cont,
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
