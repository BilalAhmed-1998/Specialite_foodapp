import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:specialite_foodapp/services/DatabaseCollection.dart';

import 'classes/allClasses.dart';

///checkout screen bool///
DatabaseCollection dbMain = DatabaseCollection();
///profile////
dynamic myimage;
dynamic name;
dynamic emailId;
dynamic password;
String refCode="";
dynamic refCheckoutInfo=[false,""];
TextEditingController controller3;
String phoneNo;
String phoneCode = "";
bool isVerified = false;
bool referralApplied=false;
var formatter = NumberFormat('###,###,##0');

///All Lists////
List<Order> ongoingOrders = [];
List<Order> orderHistory = [];
List<Restaurant> nearbyList=[];
List<String> favListIds = [];
List<Restaurant> favList=[];
List<Restaurant> allRestaurants = [];
///Change Notifier Provider Instance///
Checkout mainCheckout = Checkout();
///Home Page///
Position currentCoordinates = Position();
List<String> cities =
[
  "東京",
  "横浜",
  "名古屋",
  "大阪",
  "札幌",
  "仙台",
  "広島",
  "福岡",
  "那覇",
];
///by default city is TOKYO///
String homeMainCity = "東京";
double takeOutTax=8;
double dineInTax=10;
double serviceFee=10;