import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/loginScreen.dart';
import 'package:specialite_foodapp/services/authService.dart';

import 'loadingScreen.dart';

class signUpScreen extends StatefulWidget {
  //const signUpScreen({Key? key}) : super(key: key);
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
          title: Text("Sign Up",
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
                        hintText: 'Email Address',
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
                        hintText: 'Password',
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

                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFDB601),
                    ),
                    alignment: Alignment.center,
                    width: 342.w,
                    height: 56.h,
                    child: Text("Sign up",
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
                      Text("Already have an account?",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text(" Log In",
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
                  height: 45.h,
                ),
                InkWell(
                  onTap: ()async{

                    // showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (context) {
                    //       return loadingScreen();
                    //     });
                    await AuthService().signInWithGoogle(context);

                    // //one for loading ///
                    // Navigator.pop(context);
                     //one for signup screen //
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
                        Text("Sign in with Google",
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
                  onTap: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return loadingScreen();
                        });
                    await AuthService().signInAnon(context);

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Continue as a Guest",
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