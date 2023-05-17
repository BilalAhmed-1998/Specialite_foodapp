import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/profile_dialogue.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:specialite_foodapp/screens/profile_refer.dart';
import 'package:specialite_foodapp/screens/profile_verify.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:specialite_foodapp/services/authService.dart';

import 'loadingScreen.dart';

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
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          offset: const Offset(0, 8),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: TextField(
                        controller: controller3,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          phone = text;
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.symmetric(vertical: 10),
                          fillColor: Colors.white,
                          filled: true,
                          hintText:
                              AppLocalizations.of(context).enterMobileNumber,
                          hintStyle: TextStyle(
                              color: const Color(0xff121212),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'regular'),
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

            ],
          ),
        ),
      ),
      bottomNavigationBar:  InkWell(
        enableFeedback: true,
        onTap: () async {
          phoneNo = phone;

          if(phoneNo!=null){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return loadingScreen();
                });

            FirebaseAuth auth = FirebaseAuth.instance;
            await auth.verifyPhoneNumber(
              phoneNumber: '+81' + phoneNo,
              verificationFailed: (FirebaseAuthException e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString()),duration: Duration(seconds: 2),));
                Navigator.popUntil(context, ModalRoute.withName(profile_homepage.routeName));


              },
              codeSent: (String verificationId, int resendToken) async {
                await Navigator.pushNamed(
                    context, profile_verify.routeName);
                String smsCode = phoneCode;
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: smsCode);


                isVerified = await AuthService().updatePhoneNumber(credential, context);

                if (FirebaseAuth.instance.currentUser.phoneNumber !=
                    null) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return profile_dialogue(
                          text: '電話番号が確認されました',
                        );
                      });
                  Future.delayed(Duration(seconds: 2)).then((value) => {
                    Navigator.popUntil(context, ModalRoute.withName(profile_homepage.routeName))
                  });

                }
              },
              codeAutoRetrievalTimeout: (String verificationId) {
              },
            );
          }

        },
        child: Container(
          margin: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
          height: 56.h,
          width: 342.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff8a959e).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 40,
                offset: const Offset(0, 8),
              )
            ],
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffFDB601),
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context).send,
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
    );
  }
}
