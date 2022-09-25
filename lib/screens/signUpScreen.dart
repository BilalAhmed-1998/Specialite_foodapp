import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/services/authService.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class signUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';

  @override
  _signUpScreenState createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscured = true;
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
          title: Text(AppLocalizations.of(context).signup,
            style: TextStyle(
                fontFamily: 'regular',
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Colors.black
            ),),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 20.h),
            color: Color(0xffF0F3FD),
            child: Column(
              children: [
                ///email field///
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
                          borderSide: BorderSide(color: Color(0xffFDB601), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                        ),
                        hintText: AppLocalizations.of(context).email,
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xff121212).withOpacity(0.7),
                        )
                    ),



                  ),
                ),
                SizedBox(height: 16.h,),
                ///password field///
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,

                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: obscured,

                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(obscured?Icons.visibility_off_outlined:Icons.visibility, color: Colors.grey.shade700,),
                          onPressed: (){
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
                          borderSide: BorderSide(color: Color(0xffFDB601), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                        ),
                        hintText: AppLocalizations.of(context).password,
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xff121212).withOpacity(0.7),
                        )
                    ),

                  ),
                ),
                SizedBox(height: 50.h,),
                InkWell(
                  enableFeedback: true,
                  onTap: () async {

                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
                    bool passValid = RegExp("^.{8,}\$").hasMatch(passwordController.text);

                    if(emailValid && passValid && FirebaseAuth.instance.currentUser==null){


                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              CircularProgressIndicator
                                  .adaptive(
                                backgroundColor:
                                Color(0xfffdb601),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Signing Up...",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )));

                      await AuthService().signUpWithEmailPassword(
                          context,
                          emailController.text,
                          passwordController.text);
                      await FirebaseAuth.instance.currentUser.sendEmailVerification();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("メールに送信された確認リンク")));
                      Navigator.pop(context);

                    }
                    else {
                      (!emailValid)?
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('無効なメール'),))
                          :ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('最小8桁のパスワードを入力してください'),));
                    }



                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFDB601),
                    ),
                    alignment: Alignment.center,
                    width: 342.w,
                    height: 56.h,
                    child: Text(AppLocalizations.of(context).signup,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
                ),
                SizedBox(height: 24.h,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context).alreadyAccount,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context).login,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color(0xffFDB601),
                            fontWeight: FontWeight.bold,
                          ),),
                      ),

                    ],
                  ),

                ),
                SizedBox(height: 50.h,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("OR",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),),
                    ],
                  ),

                ),
                SizedBox(
                  height: 25.h,
                ),
                ///sign in with Apple///
                (Platform.isIOS)?
                InkWell(
                  onTap: ()async{
                    await AuthService().signInWithApple(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 342.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.apple,
                          size: 30,),
                        SizedBox(width: 54.w,),
                        Text(AppLocalizations.of(context).signApple,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),),

                      ],
                    ),
                  ),
                ):Container(),
                (Platform.isIOS)?
                SizedBox(
                  height: 15.h,
                ):Container(),
                ///sign in with google///
                InkWell(
                  onTap: ()async{


                    await AuthService().signInWithGoogle(context);
                    Navigator.pop(context);
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
                  height: 35.h,
                ),
                InkWell(
                  onTap: ()  {

                    Navigator.pushNamed(context, homeScreen.routeName);
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
