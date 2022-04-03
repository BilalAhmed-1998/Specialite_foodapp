import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dummyData.dart';
import '../services/locationService.dart';

class splashScreen extends StatelessWidget {
  //const splash_screen({Key key}) : super(key: key);
  static const routeName = '/splash_screen';
  int duration = 0;
  String goTopage = "";

  splashScreen(int duration, String goTopage) {
    this.duration = duration;
    this.goTopage = goTopage;
  }

  @override
  Widget build(BuildContext context) {


    Future.delayed(Duration(seconds: this.duration), () async{
      currentCoordinates = await LocationService.determinePosition();

      Navigator.pushNamed(context, goTopage);
    });

    return Scaffold(
        backgroundColor: Color(0xffFDB601),
        body: Stack(
          children: [
            Container(
              // height: height,
              // width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Color(0xffFDB601).withOpacity(0.7), BlendMode.dstATop),
                    image: AssetImage("assets/images/splash0.png"),
                  ),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(69.w, 535.h, 0, 0),
              //height: 373.h,
              alignment: Alignment.bottomRight,
              color: Colors.transparent,
              child: Image.asset("assets/images/splash1.png"),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(90.w, 239.h, 90.w, 0),
              //height: 373.h,
              //alignment: Alignment.center,
              color: Colors.transparent,
              child: Image.asset("assets/images/splashlogo.png"),
            ),
          ],
        ));
  }
}
