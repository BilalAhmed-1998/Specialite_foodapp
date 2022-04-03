import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/favourites_card.dart';
import 'package:specialite_foodapp/screens/favourite_detail.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/checkout_nearby.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';

import '../dummyData.dart';

class checkout_favourites extends StatefulWidget {
  static const routeName = '/checkout_favourites';
  @override
  _checkout_favouritesState createState() => _checkout_favouritesState();
}

class _checkout_favouritesState extends State<checkout_favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F3FD),

      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Favourites',
          style: TextStyle(
            color: const Color(0xff121212),
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: ListView.builder(
            itemCount: favList.length,
            itemBuilder: (context, index) {
              if (favList[index].favt) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) => favourite_detail(restaurant: favList[index]),
                    ));
                  },
                  child: favourites_card(fav: favList[index]),
                );
              } else {
                return Container();
              }
            }),
      ),
      bottomNavigationBar: Container(
          height: 79.h,
          color: Colors.white,
          child: Container(
            color: Colors.white,
            width: 312.w,
            margin: EdgeInsets.only(bottom: 20.h, left: 39.w, right: 39.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){

                    Navigator.pushNamed(context, homeScreen.routeName);
                  },
                  child: Icon(
                    Icons.dashboard_outlined,
                    size: 22.sp,
                    color: Color(0xff7E869E),
                  ),
                ),
                Icon(
                  Icons.favorite_border_outlined,
                  size: 22.sp,
                  color: Color(0xfffdb601),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => nearby(
                          favList: nearbyList,
                        )
                      ),
                    );

                  },
                  child: Icon(
                    CupertinoIcons.location,
                    size: 22.sp,
                    color: Color(0xff7E869E),
                  ),
                ),
                InkWell(
                  onTap: (){

                    Navigator.pushNamed(context, profile_homepage.routeName);
                  },
                  child: Icon(
                    CupertinoIcons.person,
                    size: 22.sp,
                    color: Color(0xff7E869E),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
