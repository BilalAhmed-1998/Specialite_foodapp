


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class emailVerificationScreen extends StatefulWidget {
  static const routeName = '/emailVerificationScreen';

  // const emailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<emailVerificationScreen> createState() => _emailVerificationScreenState();
}

class _emailVerificationScreenState extends State<emailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF0F3FD),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("メールによる確認",
          style: TextStyle(
              fontFamily: 'regular',
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: Colors.black
          ),),
      ),

      body: Container(
        width: width,
        height: height,
        color: Color(0xffF0F3FD),
        child: Center(child: Text("メールに送信された確認リンク",
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.grey,
          fontSize: 18.sp,
        ),)),

      ),
    );
  }
}
