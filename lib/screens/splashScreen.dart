
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../dummyData.dart';
import '../services/locationService.dart';

class splashScreen extends StatelessWidget {
  static const routeName = '/splash_screen';
  int duration = 0;
  String goTopage = "";

  splashScreen(this.duration, this.goTopage, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(microseconds: duration,), () async{

      dynamic currentcoordinates = await LocationService.determinePosition(context);
      if(currentcoordinates.runtimeType != String ){
        currentCoordinates = currentcoordinates;
        List<Placemark> placeMarks = await placemarkFromCoordinates(currentCoordinates.latitude,currentCoordinates.longitude,localeIdentifier: 'ja');
        bool exist = false;

        for (var item in cities) {
          if(placeMarks[0].administrativeArea.contains(item) && placeMarks[0].locality.contains(item)){
            exist = true;
            homeMainCity = item;
            break;
          }
        }
      }

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/splashlogo.png"),
                  SizedBox(height: 15.h,),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation((Colors.black12)),
                  ),


                ],
              ),
            ),

          ],
        ));

  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
