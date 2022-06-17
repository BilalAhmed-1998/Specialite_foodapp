import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:specialite_foodapp/classes/favourites_card.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/checkout_favourites.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../classes/allClasses.dart';
import '../services/wrapper.dart';
import 'favourite_detail.dart';
import 'loadingScreen.dart';

class nearby extends StatefulWidget {
  static const routeName = '/nearby';
  List<Restaurant> favList;
  nearby({this.favList});

  @override
  _nearbyState createState() => _nearbyState();


}

class _nearbyState extends State<nearby> {

  GoogleMapController myMapController;
  Marker pickUpLocMarker = Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position: LatLng(currentCoordinates.latitude,currentCoordinates.longitude),
    markerId: MarkerId("MyLocation"),
  );


  CameraPosition campos = CameraPosition(
      target: LatLng(currentCoordinates.latitude, currentCoordinates.longitude),
      zoom: 14.0);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context).nearby,
          style: TextStyle(
            color: const Color(0xff121212),
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
                width: width,
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Map',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Container(
                    //   height: 25.h,
                    //   width: 71.w,
                    //   decoration: BoxDecoration(
                    //       color: Color(0xffFF5252).withOpacity(0.15),
                    //       borderRadius: BorderRadius.circular(16.5)),
                    //   child: Center(
                    //     child: Text(
                    //       '20 - 30 min',
                    //       style: TextStyle(
                    //         fontSize: 8.sp,
                    //         color: Color(0xffFF5252),
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
            SizedBox(
              height: 10.h,
            ),
            ///Google map///
            Container(
              width: width,
              height: 250.h,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: campos,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                 zoomGesturesEnabled: true,
                 scrollGesturesEnabled: true,
                 markers: {pickUpLocMarker,},
                onMapCreated: (controller) async{
                 // myMapController.animateCamera(CameraUpdate.newCameraPosition(campos));
                  setState(() {
                    myMapController = controller;
                  });
                },

              ),


            ),
            SizedBox(
              height: 28.h,
            ),
            for (int index = 0; index < widget.favList.length; index++)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => favourite_detail(
                            restaurant: widget.favList[index],
                          ),
                        ));
                  },
                  child: favourites_card(fav: widget.favList[index]),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 79.h,
          color: Colors.white,
          child: Container(
            color: Colors.white,
            width: 312.w,
            margin: EdgeInsets.only(bottom: 20.h, left: 35.w, right: 35.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, homeScreen.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.dashboard_outlined,
                      size: 22.sp,
                      color: Color(0xff7E869E),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (favList.isEmpty) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return loadingScreen();
                          });

                      await dbMain.getFavtList();

                      Navigator.pop(context);
                    }


                    Navigator.pushNamed(context, checkout_favourites.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      size: 22.sp,
                      color: Color(0xff7E869E),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.location,
                    size: 22.sp,
                    color: Color(0xfffdb601),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if(FirebaseAuth.instance.currentUser!=null){
                      Navigator.pushNamed(context, profile_homepage.routeName);
                    }else{
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("を利用するためには、ログインが必要です。")));
                      Navigator.pushNamedAndRemoveUntil(
                          context, Wrapper.routeName, (route) => false);
                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.person,
                      size: 22.sp,
                      color: Color(0xff7E869E),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
