import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/routes.dart';
import 'package:specialite_foodapp/screens/splashScreen.dart';
import 'package:specialite_foodapp/services/authService.dart';
import 'package:specialite_foodapp/services/notificationService.dart';
import 'package:specialite_foodapp/services/wrapper.dart';
import 'classes/allClasses.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  notificationService.useNotificationService();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(390, 844),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => Checkout()),
              Provider(create: (_) => AuthService()),
              StreamProvider<AppUser>.value(
                  value: AuthService().authStateChanges, initialData: null),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                //for languages with right to left directions
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ja'),
                //Locale('en'),
              ],
              theme: ThemeData(fontFamily: "regular"),
              routes: routes,
              debugShowCheckedModeBanner: false,
              home: splashScreen(1, Wrapper.routeName),
            ),
          );
        });
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
