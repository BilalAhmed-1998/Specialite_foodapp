import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dummyData.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SizedBox(
        height: 52.h,
        width: 52.w,
        child: TextField(
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.top,
          keyboardType: TextInputType.number,
          controller: controller,
          maxLength: 1,
          cursorColor: Color(0xffFDB601),

          decoration:  InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xffFDB601)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
              ),

              counterText: '',
              hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            fontFamily: 'Poppins',
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
               phoneCode=phoneCode+controller.text.toString();
              print("phoneeeeeeeeeeeeeeeeee Codeeeeeeeeeeeeeeeee");
              print(phoneCode);

            }
          },
        ),
      ),
    );
  }
}