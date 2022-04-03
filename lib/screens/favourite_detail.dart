import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../classes/allClasses.dart';
import '../classes/favourites_card.dart';
import '../dummyData.dart';

class favourite_detail extends StatefulWidget {
  static const routeName = '/favourite_detail';
  Restaurant restaurant;
  favourite_detail({this.restaurant});
  @override
  _favourite_detailState createState() => _favourite_detailState();
}

class _favourite_detailState extends State<favourite_detail> {
  GoogleMapController myMapController;
  Marker pickUpLocMarker = Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position: LatLng(currentCoordinates.latitude,currentCoordinates.longitude),
    markerId: MarkerId("MyLocation"),
  );


  CameraPosition campos = CameraPosition(
      target: LatLng(currentCoordinates.latitude, currentCoordinates.longitude),
      zoom: 14.0);

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF0F3FD),
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
          this.widget.restaurant.title,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 240.h, //height / 3.5,
                      width: width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.restaurant.images.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 239.h,
                              width: width,
                              child: Stack(children: [
                                Positioned.fill(
                                  child: Image(
                                    image: AssetImage(
                                      widget.restaurant.images[index],
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ]),
                            );
                          }),
                    ),
                    Container(
                      width: width,
                      //height: height,

                      decoration: BoxDecoration(
                        color: Color(0xffF0F3FD),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 225.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 16.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  this.widget.restaurant.title,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.widget.restaurant.favt =
                                            !this.widget.restaurant.favt;
                                      });
                                    },
                                    child: (!widget.restaurant.favt)
                                        ? Icon(
                                            Icons.favorite_border_outlined,
                                          )
                                        : Icon(
                                            Icons.favorite,
                                            color: Color(0xffff5252),
                                          )),
                              ]),
                          Container(
                            width: 170.w,
                            child: Text(
                              this.widget.restaurant.description,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            children: [
                              SmoothStarRating(
                                allowHalfRating: true,
                                onRated: (v) {},
                                starCount: 5,
                                rating: this.widget.restaurant.rating,
                                isReadOnly: true,
                                size: 20.sp,
                                color: Color(0xffFCD34D),
                                borderColor: Colors.black,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "+" +
                                    widget.restaurant.totalRating
                                        .truncate()
                                        .toString() +
                                    " ratings",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 19.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 20.sp,
                                color: Color(0xfffdb601),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                this.widget.restaurant.address,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: 20.sp,
                                color: Color(0xfffdb601),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                this.widget.restaurant.open
                                    ? "Open now"
                                    : "Close now",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: width,
                    padding: EdgeInsets.only(left:24,right:24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Map',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          height: 25.h,
                          width: 71.w,
                          decoration: BoxDecoration(
                            color: Color(0xffFF5252).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16.5)
                          ),
                          child: Center(
                            child: Text(
                              '${calculateDistance(currentCoordinates.latitude, currentCoordinates.longitude, currentCoordinates.latitude, currentCoordinates.longitude)} km',
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: Color(0xffFF5252),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 10.h,),
                Container(
                  width: width,
                  height: 250.h,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: campos,
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    tiltGesturesEnabled: false,

                    markers: {pickUpLocMarker,},
                    onMapCreated: (controller) async{
                      // myMapController.animateCamera(CameraUpdate.newCameraPosition(campos));
                    },

                  ),


                ),
                SizedBox(height: 30.h,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
