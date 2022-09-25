import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/authService.dart';
import '../services/wrapper.dart';
import 'loadingScreen.dart';

class profile_deletion extends StatefulWidget {
  static const routeName = '/profile_deletion';
  @override
  State<profile_deletion> createState() => _profile_deletionState();
}

class _profile_deletionState extends State<profile_deletion> {
  TextEditingController passwordController = TextEditingController();
  bool obscured = true;
  String providerId = FirebaseAuth.instance.currentUser.providerData.first.providerId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff303030),
            size: 22.sp,
          ),
        ),
        title: Text(
          'アカウントの削除',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        color: Color(0xffF0F3FD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            Text(
              AppLocalizations.of(context).password,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: TextField(
                readOnly: providerId=='password'?false:true,
                obscureText: obscured,
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        color: Colors.grey.shade700,
                      ),
                      onPressed: () {
                        setState(() {
                          obscured = !obscured;
                        });
                      },
                    ),
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    fillColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Color(0xffFDB601), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    hintText: AppLocalizations.of(context).password,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff121212).withOpacity(0.7),
                    )),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 22.h),
          color: Colors.white,
          height: 85.h,
          child: InkWell(
            enableFeedback: true,
            onTap: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return loadingScreen();
                  });

              if (FirebaseAuth
                      .instance.currentUser.providerData.first.providerId ==
                  'google.com') {
                dynamic result = await AuthService().deleteGoogleUser(context);
                if (result != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Wrapper.routeName, (route) => false);
                } else {
                  Navigator.pop(context);
                }
              } else if (FirebaseAuth
                      .instance.currentUser.providerData.first.providerId ==
                  'apple.com') {
                dynamic result = await AuthService().deleteAppleUser(context);
                if (result != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Wrapper.routeName, (route) => false);
                } else {
                  Navigator.pop(context);
                }
              } else {
                dynamic result = await AuthService().deleteUser(
                    FirebaseAuth.instance.currentUser.email,
                    passwordController.text,
                    context);
                if (result != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Wrapper.routeName, (route) => false);
                } else {
                  Navigator.pop(context);
                }
              }
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
                    offset: const Offset(0, 8),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffFDB601),
              ),
              child: Center(
                child: Text(
                  'アカウントの削除',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'regular',
                    color: const Color(0xff121212),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
