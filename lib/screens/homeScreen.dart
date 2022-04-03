import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/restaurantCard.dart';
import 'package:specialite_foodapp/classes/restaurantCard2.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:specialite_foodapp/screens/checkout_favourites.dart';
import 'package:specialite_foodapp/services/local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:specialite_foodapp/screens/loadingScreen.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:specialite_foodapp/screens/restaurantDetailScreen.dart';
import 'package:specialite_foodapp/screens/restaurant_search.dart';

import 'checkout_nearby.dart';

class homeScreen extends StatefulWidget {
  //const homeScreen({Key? key}) : super(key: key);
  static const routeName = '/homeScreen';

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String notification_msg="to be filled";
  void fcm()async{
    String fcm = await FirebaseMessaging.instance.getToken();
    print(fcm);
  }
  @override
  void initState() {
    super.initState();
    fcm();
    print("********");
    LocalNotificationService.initialize();
    FirebaseMessaging.instance.getInitialMessage().then((event){

      if(event!=null && event.notification!=null) {
        LocalNotificationService.showNotificationOnForeground(event);
        notification_msg = "${event.notification.title}";
        print("coming from terminated");
      }
      else{
        print("null recieved, terminated");
      }
      //Navigator.pushNamed(context, ref_messages.routeName);

    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

      if(event!=null && event.notification!=null) {
        LocalNotificationService.showNotificationOnForeground(event);
          notification_msg = "${event.notification.title}";
        print("coming from background");
      }
      else{
        print("null recieved, background");
      }
      //Navigator.pushNamed(context, ref_messages.routeName);

    });

    FirebaseMessaging.onMessage.listen((event) {
      if(event!=null && event.notification!=null) {
        LocalNotificationService.showNotificationOnForeground(event);
          notification_msg = "${event.notification.title}";
        print("coming from foreground");
      }
      else{
        print("null recieved, foreground");
      }
    });

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
                    "Search for shop & restaurants",
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
      body: SingleChildScrollView(
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
                        child: Text(items,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        homeMainCity = val;
                      });
                    }),
              ),

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
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => restaurantDetailScreen(
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
                padding: EdgeInsets.fromLTRB(24.w, 5.h, 0, 12.h),
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
                margin: EdgeInsets.fromLTRB(24.w, 0, 0, 28.h),
                child: ListView.builder(
                  padding: EdgeInsets.only(right: 24.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: allRestaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => restaurantDetailScreen(
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

              ///Text (Good Deals!)///
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 5.h, 0, 12.h),
                child: Text(
                  "Good Deals",
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
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => restaurantDetailScreen(
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
                padding: EdgeInsets.fromLTRB(24.w, 5.h, 0, 12.h),
                child: Text(
                  "Specialite for you!",
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
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => restaurantDetailScreen(
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
            margin: EdgeInsets.only(bottom: 20.h, left: 39.w, right: 39.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.dashboard_outlined,
                  size: 22.sp,
                  color: Color(0xfffdb601),
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
                InkWell(
                  onTap: () {
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
