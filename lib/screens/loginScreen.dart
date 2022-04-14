import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/signUpScreen.dart';

import '../services/authService.dart';
import 'loadingScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class loginScreen extends StatefulWidget {
  //const loginScreen({Key? key}) : super(key: key);
  static const routeName = '/loginScreen';

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscured = true;
  String Emailtext = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).login,

          style: TextStyle(
              fontFamily: 'regular',
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          color: Color(0xffF0F3FD),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                      hintText: AppLocalizations.of(context).email,
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xff121212).withOpacity(0.7),
                      )),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
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
              SizedBox(
                height: 12.h,
              ),
              InkWell(
                onTap: () async {
                  Emailtext = emailController.text;
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(Emailtext);

                  if (Emailtext != "" && emailValid) {
                    final list = await FirebaseAuth.instance
                        .fetchSignInMethodsForEmail(Emailtext);
                    if (list.isNotEmpty) {
                      try {
                        FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "A link has been sent to your email successfully!")));
                      } on Exception catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("User not found!")));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Email Field is empty/invalid!")));
                  }
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context).forgot,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              InkWell(
                enableFeedback: true,
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          CircularProgressIndicator.adaptive(
                            backgroundColor: Color(0xfffdb601),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Signing In...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )));

                  await AuthService().signInWithEmailPassword(
                      context, emailController.text, passwordController.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffFDB601),
                  ),
                  alignment: Alignment.center,
                  width: 342.w,
                  height: 56.h,
                  child: Text(
                    AppLocalizations.of(context).login,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).dontAccount,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, signUpScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context).signup+'へ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xffFDB601),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              InkWell(
                onTap: ()async{


                  await AuthService().signInWithGoogle(context);

                 // Navigator.pop(context);
                },
                child: Container(
                  width: 342.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(image: AssetImage("assets/images/google.png")),
                      SizedBox(width: 54.w,),
                      Text(AppLocalizations.of(context).signGoogle,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),),

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              InkWell(
                onTap: ()  {

                  Navigator.pushNamed(context, homeScreen.routeName);
                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (context) {
                  //       return loadingScreen();
                  //     });
                  //  await AuthService().signInAnon(context);
                  //
                  // Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context).continueGuest,
                  style: TextStyle(
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
