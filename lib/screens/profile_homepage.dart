import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/classes/prrofileCard.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/checkout_favourites.dart';
import 'package:specialite_foodapp/screens/checkout_paymentSelection.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/checkout_nearby.dart';
import 'package:specialite_foodapp/screens/loginScreen.dart';
import 'package:specialite_foodapp/screens/profile_edit.dart';
import 'package:specialite_foodapp/screens/profile_refer.dart';
import 'package:specialite_foodapp/screens/profile_order.dart';
import 'package:specialite_foodapp/screens/profile_enterReferral.dart';
import '../services/authService.dart';
import '../services/wrapper.dart';
import 'loadingScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class profile_homepage extends StatefulWidget {
  static const routeName = '/profile_homepage';
  @override
  _profile_homepageState createState() => _profile_homepageState();
}

class _profile_homepageState extends State<profile_homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context).profile,
          style: TextStyle(
            color: const Color(0xff121212),
            fontSize: 18.sp,
            fontFamily: 'regular',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12.w, 16.h, 0, 16.h),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              width: 342.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff8a959e).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0, 8),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myimage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: Image.file(
                              myimage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffFDB601), shape: BoxShape.circle),
                          height: 60.h,
                          width: 60.w,
                          child: ImageIcon(
                            AssetImage("assets/images/pro1.png"),
                            color: Color(0xFF262626),
                          )),
                  SizedBox(
                    width: 16.w,
                  ),
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 8.h),
                          width: 214.w,
                          child: Text(
                            (FirebaseAuth.instance.currentUser.displayName !=
                                    null)
                                ? FirebaseAuth.instance.currentUser.displayName
                                : 'User',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'regular',
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff121212),
                            ),
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          width: 214.w,
                          child: Text(
                            FirebaseAuth.instance.currentUser.email,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'regular',
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff121212),
                            ),
                          )),
                    ],
                  ),
                  InkWell(
                    enableFeedback: true,
                    child: ImageIcon(
                      const AssetImage("assets/images/pro2.png"),
                      size: 24.sp,
                      color: const Color(0xffFDB601),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, profile_edit.routeName);
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
              width: 342.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff8a959e).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0, 8),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  InkWell(
                      enableFeedback: true,
                      onTap: () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return loadingScreen();
                            });

                        await dbMain.getOngoingOrders();

                        Navigator.pop(context);
                        Navigator.pushNamed(context, profile_order.routeName);
                      },
                      child: profileCard("assets/images/pro3.png", AppLocalizations.of(context).orders)),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffDFDFDF),
                    thickness: 2,
                  ),
                  InkWell(
                      enableFeedback: true,
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null)
                          refCode = FirebaseAuth.instance.currentUser.uid;
                        Navigator.pushNamed(context, profile_refer.routeName);
                      },
                      child: profileCard(
                          "assets/images/pro4.png", AppLocalizations.of(context).referFriend)),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffDFDFDF),
                    thickness: 2,
                  ),
                  InkWell(
                      enableFeedback: true,
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null)
                          refCode = FirebaseAuth.instance.currentUser.uid;
                        Navigator.pushNamed(
                            context, profile_enterReferral.routeName);
                      },
                      child: profileCard(
                          "assets/images/pro4.png", "Enter Referral Code")),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffDFDFDF),
                    thickness: 2,
                  ),

                  InkWell(
                      enableFeedback: true,
                      onTap: () {},
                      child: profileCard("assets/images/pro6.png", AppLocalizations.of(context).setting)),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffDFDFDF),
                    thickness: 2,
                  ),
                  InkWell(
                      enableFeedback: true,
                      onTap: () async {
                        if (FirebaseAuth.instance.currentUser != null) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return loadingScreen();
                              });

                          await AuthService().signOut(context);
                        }

                        Navigator.pushNamedAndRemoveUntil(
                            context, Wrapper.routeName, (route) => false);
                      },
                      child: profileCard(
                          "assets/images/pro7.png",
                          (FirebaseAuth.instance.currentUser != null)
                              ? AppLocalizations.of(context).logout
                              : AppLocalizations.of(context).login)),
                ],
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
            margin: EdgeInsets.only(bottom: 20.h, left: 39.w, right: 39.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, homeScreen.routeName);
                  },
                  child: Icon(
                    Icons.dashboard_outlined,
                    size: 22.sp,
                    color: Color(0xff7E869E),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, checkout_favourites.routeName);
                  },
                  child: Icon(
                    Icons.favorite_border_outlined,
                    size: 22.sp,
                    color: Color(0xff7E869E),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => nearby(
                                favList: nearbyList,
                              )),
                    );
                  },
                  child: Icon(
                    CupertinoIcons.location,
                    size: 22.sp,
                    color: Color(0xff7E869E),
                  ),
                ),
                Icon(
                  CupertinoIcons.person,
                  size: 22.sp,
                  color: Color(0xfffdb601),
                ),
              ],
            ),
          )),
    );
  }
}
