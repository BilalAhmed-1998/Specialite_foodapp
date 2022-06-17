import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/favourites_card.dart';
import 'package:specialite_foodapp/screens/favourite_detail.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/checkout_nearby.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dummyData.dart';
import '../services/wrapper.dart';

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
          AppLocalizations.of(context).favourites,
          style: TextStyle(
            color: const Color(0xff121212),
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body:(FirebaseAuth.instance.currentUser!=null)?
      Container(
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
      ):
      Padding(
        padding: EdgeInsets.fromLTRB(15,40,15,0),
        child: Text("お気に入りのお店を見るためには、ログインが必要です。",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),),
      ),
      bottomNavigationBar: Container (
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
                  onTap: (){
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    size: 22.sp,
                    color: Color(0xfffdb601),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => nearby(
                          favList: allRestaurants,
                        )
                      ),
                    );

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.location,
                      size: 22.sp,
                      color: Color(0xff7E869E),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
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
