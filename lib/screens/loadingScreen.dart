import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class loadingScreen extends StatelessWidget {
 // const loadingScreen({Key? key}) : super(key: key);
  static const routeName = '/loadingScreen';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 6.w,),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation((Colors.amber)),),
            SizedBox(width: 20.w,),
            Text("炉料...",
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),)
          ],
        ),
      ),
    );
  }
}
