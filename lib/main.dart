
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/routes.dart';
import 'package:specialite_foodapp/screens/checkoutScreen.dart';
import 'package:specialite_foodapp/screens/checkoutScreen2.dart';
import 'package:specialite_foodapp/screens/orderScreen.dart';
import 'package:specialite_foodapp/screens/loginScreen.dart';
import 'package:specialite_foodapp/screens/signUpScreen.dart';
import 'package:specialite_foodapp/screens/splashScreen.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/services/authService.dart';
import 'package:specialite_foodapp/services/locationService.dart';
import 'package:specialite_foodapp/services/wrapper.dart';
import 'package:geocoding/geocoding.dart';
import 'classes/allClasses.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print('message from background');
  print(message.notification.title);
  print(message.notification.body);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(390, 844),
      builder: () =>MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Checkout()),
          
          Provider(create: (_) => AuthService()),

          StreamProvider<AppUser>.value(
             value: AuthService().authStateChanges,
              initialData: null),
        ],
        child: MaterialApp(
          theme: ThemeData(

            fontFamily: "regular"
          ),
          routes: routes,
          debugShowCheckedModeBanner: false,
          home: splashScreen(1,Wrapper.routeName),
        //  home: checkoutScreen2(),
         ),
      ),
    );
  }
}



// showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context)
// {
//   return loadingScreen();
//
// });