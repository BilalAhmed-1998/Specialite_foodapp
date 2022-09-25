import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/restaurantCard.dart';
import 'package:specialite_foodapp/classes/restaurantCard2.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:specialite_foodapp/screens/checkout_favourites.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:specialite_foodapp/screens/loadingScreen.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:specialite_foodapp/screens/restaurantDetailScreen.dart';
import 'package:specialite_foodapp/screens/restaurant_search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/wrapper.dart';
import 'checkout_nearby.dart';

class homeScreen extends StatefulWidget {
  //const homeScreen({Key? key}) : super(key: key);
  static const routeName = '/homeScreen';

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  void fcm() async {
    String fcm = await FirebaseMessaging.instance.getToken();
    print(fcm);
  }

  @override
  void initState() {
    super.initState();
  }

  int navigationItem = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // String currentCity = homeMainCity;

    return Scaffold(
      backgroundColor: Color(0xffF0F3FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, restaurant_search.routeName);
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              width: 342.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Color(0xffF0F3FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.search,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    AppLocalizations.of(context).searchForShopRestaurants,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                    ),
                  )
                ],
              )),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: (allRestaurants.isEmpty)
          ? FutureBuilder(
              future: dbMain.getRestaurants(homeMainCity),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
                      color: Color(0xffF0F3FD),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///city name///
                          Padding(
                            padding: EdgeInsets.fromLTRB(24.w, 16.h, 0, 12.h),
                            child: DropdownButton(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Color(0xfffdb601),
                                  size: 30.sp,
                                ),
                                value: homeMainCity,
                                // items: items,
                                items: cities.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) async {
                                  homeMainCity = val;
                                  allRestaurants.clear();
                                  Navigator.popAndPushNamed(
                                      context, homeScreen.routeName);
                                }),
                          ),
                          allRestaurants.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /// Swiper card 1 (Big one) ///
                                    SizedBox(
                                      height: 222.h,
                                      width: width,
                                      child: Swiper(
                                        itemWidth: 500,
                                        layout: SwiperLayout.DEFAULT,
                                        scrollDirection: Axis.horizontal,
                                        loop: true,
                                        itemCount: allRestaurants.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      restaurantDetailScreen(
                                                    restaurant:
                                                        allRestaurants[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: restaurantCard(
                                              height: 222.h,
                                              width: 342.w,
                                              restaurant: allRestaurants[index],
                                            ),
                                          );
                                        },
                                        viewportFraction: 0.85,
                                        scale: 0.9,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 28.h,
                                    ),

                                    ///Text (Specialite for you!)///
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          24.w, 5.h, 0, 12.h),
                                      child: Text(
                                        "Specialite for you!",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    /// Swiper card 2 (small one)///
                                    Container(
                                      height: 235.h,
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      margin:
                                          EdgeInsets.fromLTRB(24.w, 0, 0, 28.h),
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(right: 24.w),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: allRestaurants.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      restaurantDetailScreen(
                                                    restaurant:
                                                        allRestaurants[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: restaurantCard2(
                                              height: 200.h,
                                              width: 244.w,
                                              restaurant: allRestaurants[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // SizedBox(height: 28.h,),

                                    ///Text (Good Deals!)///
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          24.w, 5.h, 0, 12.h),
                                      child: Text(
                                        AppLocalizations.of(context).goodDeals,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    /// Swiper card 3 (small one)///
                                    Container(
                                      height: 235.h,
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      margin:
                                          EdgeInsets.fromLTRB(24.w, 0, 0, 28.h),
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(right: 24.w),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: allRestaurants.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      restaurantDetailScreen(
                                                    restaurant:
                                                        allRestaurants[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: restaurantCard2(
                                              height: 200.h,
                                              width: 244.w,
                                              restaurant: allRestaurants[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // SizedBox(height: 28.h,),

                                    ///Text (New on Specialite)///
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          24.w, 5.h, 0, 12.h),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .newOnSpecialite,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    /// Swiper card 4 (small one)///
                                    Container(
                                      height: 235.h,
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      margin:
                                          EdgeInsets.fromLTRB(24.w, 0, 0, 28.h),
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(right: 24.w),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: allRestaurants.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (allRestaurants[index]
                                              .joinInMonth()) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        restaurantDetailScreen(
                                                      restaurant:
                                                          allRestaurants[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: restaurantCard2(
                                                height: 200.h,
                                                width: 244.w,
                                                restaurant:
                                                    allRestaurants[index],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    // SizedBox(height: 28.h,),
                                  ],
                                )
                              : Padding(
                                  padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
                                  child: Text(
                                    "このエリアにはお店が登録されていません。他のエリアを選択し、もう一度検索をしてください。",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return loadingScreen();
                }
              })
          : SingleChildScrollView(
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
                color: Color(0xffF0F3FD),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///city name///
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 0, 12.h),
                      child: DropdownButton(
                          icon: Icon(
                            Icons.location_on,
                            color: Color(0xfffdb601),
                            size: 30.sp,
                          ),
                          value: homeMainCity,
                          // items: items,
                          items: cities.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) async {
                            homeMainCity = val;
                            allRestaurants.clear();
                            Navigator.popAndPushNamed(
                                context, homeScreen.routeName);
                          }),
                    ),
                    allRestaurants.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// Swiper card 1 (Big one) ///
                              SizedBox(
                                height: 222.h,
                                width: width,
                                child: Swiper(
                                  itemWidth: 500,
                                  layout: SwiperLayout.DEFAULT,
                                  scrollDirection: Axis.horizontal,
                                  loop: true,
                                  itemCount: allRestaurants.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                restaurantDetailScreen(
                                              restaurant: allRestaurants[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: restaurantCard(
                                        height: 222.h,
                                        width: 342.w,
                                        restaurant: allRestaurants[index],
                                      ),
                                    );
                                  },
                                  viewportFraction: 0.85,
                                  scale: 0.9,
                                ),
                              ),
                              SizedBox(
                                height: 28.h,
                              ),

                              ///Text (Specialite for you!)///
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(24.w, 5.h, 0, 12.h),
                                child: Text(
                                  "Specialite for you!",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              /// Swiper card 2 (small one)///
                              Container(
                                height: 245.h,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.fromLTRB(24.w, 0, 0, 28.h),
                                child: ListView.builder(
                                  padding: EdgeInsets.only(right: 24.w),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: allRestaurants.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                restaurantDetailScreen(
                                              restaurant: allRestaurants[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: restaurantCard2(
                                        height: 210.h,
                                        width: 244.w,
                                        restaurant: allRestaurants[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(height: 28.h,),

                              ///Text (Good Deals!)///
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(24.w, 5.h, 0, 12.h),
                                child: Text(
                                  AppLocalizations.of(context).goodDeals,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              /// Swiper card 3 (small one)///
                              Container(
                                height: 235.h,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.fromLTRB(24.w, 0, 0, 28.h),
                                child: ListView.builder(
                                  padding: EdgeInsets.only(right: 24.w),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: allRestaurants.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                restaurantDetailScreen(
                                              restaurant: allRestaurants[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: restaurantCard2(
                                        height: 200.h,
                                        width: 244.w,
                                        restaurant: allRestaurants[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(height: 28.h,),

                              ///Text (New on Specialite)///
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(24.w, 5.h, 0, 12.h),
                                child: Text(
                                  AppLocalizations.of(context).newOnSpecialite,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              /// Swiper card 4 (small one)///
                              Container(
                                height: 235.h,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.fromLTRB(24.w, 0, 0, 28.h),
                                child: ListView.builder(
                                  padding: EdgeInsets.only(right: 24.w),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: allRestaurants.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (allRestaurants[index].joinInMonth()) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  restaurantDetailScreen(
                                                restaurant:
                                                    allRestaurants[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: restaurantCard2(
                                          height: 200.h,
                                          width: 244.w,
                                          restaurant: allRestaurants[index],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              // SizedBox(height: 28.h,),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
                            child: Text(
                              "このエリアにはお店が登録されていません。他のエリアを選択し、もう一度検索をしてください。",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
          height: 80.h,
          color: Colors.white,
          child: Container(
            color: Colors.white,
            width: 312.w,
            margin: EdgeInsets.only(bottom: 20.h, left: 35.w, right: 35.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.dashboard_outlined,
                    size: 22.sp,
                    color: Color(0xfffdb601),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (FirebaseAuth.instance.currentUser != null) {
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
                      Navigator.pushNamed(
                          context, checkout_favourites.routeName);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("を利用するためには、ログインが必要です。")));
                      Navigator.pushNamedAndRemoveUntil(
                          context, Wrapper.routeName, (route) => false);
                    }
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
                InkWell(
                  onTap: () {
                    if (currentCoordinates.longitude != null &&
                        currentCoordinates.latitude != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => nearby(
                                  favList: allRestaurants,
                                )),
                      );
                    }else{

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Your Location Services are Disabled!")));
                    }
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
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.pushNamed(context, profile_homepage.routeName);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("を利用するためには、ログインが必要です。")));
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
