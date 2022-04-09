
import 'package:flutter/material.dart';
import 'package:specialite_foodapp/screens/checkoutScreen.dart';
import 'package:specialite_foodapp/screens/checkoutScreen2.dart';
import 'package:specialite_foodapp/screens/checkout_addNewCard.dart';
import 'package:specialite_foodapp/screens/checkout_chooseExisting.dart';
import 'package:specialite_foodapp/screens/checkout_favourites.dart';
import 'package:specialite_foodapp/screens/checkout_paymentSelection.dart';
import 'package:specialite_foodapp/screens/favourite_detail.dart';
import 'package:specialite_foodapp/screens/checkout_nearby.dart';
import 'package:specialite_foodapp/screens/orderScreen.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/loadingScreen.dart';
import 'package:specialite_foodapp/screens/loginScreen.dart';
import 'package:specialite_foodapp/screens/orderScreen.dart';
import 'package:specialite_foodapp/screens/profile_copied.dart';
import 'package:specialite_foodapp/screens/profile_dialogue.dart';
import 'package:specialite_foodapp/screens/profile_edit.dart';
import 'package:specialite_foodapp/screens/profile_enterReferral.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:specialite_foodapp/screens/profile_order.dart';
import 'package:specialite_foodapp/screens/profile_phone.dart';
import 'package:specialite_foodapp/screens/profile_picture.dart';
import 'package:specialite_foodapp/screens/profile_refer.dart';
import 'package:specialite_foodapp/screens/profile_verify.dart';
import 'package:specialite_foodapp/screens/restaurant_search.dart';
import 'package:specialite_foodapp/screens/signUpScreen.dart';
import 'package:specialite_foodapp/screens/streamTest.dart';
import 'package:specialite_foodapp/services/wrapper.dart';




final Map <String,WidgetBuilder> routes =  {

  Wrapper.routeName: (context) => Wrapper(),
  UserInformation.routeName: (context) => UserInformation(),
  loginScreen.routeName: (context) => loginScreen(),
  signUpScreen.routeName:(context) => signUpScreen(),
  homeScreen.routeName:(context) => homeScreen(),
  loadingScreen.routeName:(context) => loadingScreen(),
  orderScreen.routeName:(context) => orderScreen(),
  checkoutScreen.routeName:(context) => checkoutScreen(),
  checkoutScreen2.routeName:(context) => checkoutScreen2(),
  checkout_paymentSelection.routeName:(context) => checkout_paymentSelection(),
  checkout_chooseExisting.routeName:(context) => checkout_chooseExisting(),
  checkout_addNewCard.routeName:(context) => checkout_addNewCard(),
  checkout_favourites.routeName:(context) => checkout_favourites(),
  favourite_detail.routeName:(context) => favourite_detail(),
  nearby.routeName:(context) => nearby(),
  restaurant_search.routeName:(context) => restaurant_search(),
  //            profile routes          //
  profile_homepage.routeName:(context) => profile_homepage(),
  profile_edit.routeName:(context) => profile_edit(),
  profile_picture.routeName:(context) => profile_picture(),
  profile_refer.routeName:(context) => profile_refer(),
  profile_copied.routeName:(context) => profile_copied(),
  profile_dialogue.routeName:(context) => profile_dialogue(),
  profile_phone.routeName:(context) => profile_phone(),
  profile_verify.routeName:(context) => profile_verify(),
  profile_order.routeName:(context) => profile_order(),
  profile_enterReferral.routeName:(context) => profile_enterReferral(),


};