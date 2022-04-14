

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppUser{

  String uid;
  AppUser({this.uid});

}

class Restaurant{

  String uid;
  List<dynamic> images;
  String description;
  String title;
  double rating;
  double totalRating;
  bool favt;
  String address;
  bool open;
  bool dineIn;
  int seatsLeft;
  GeoPoint geoPoints;
  String state;
  List<RestaurantItem> restaurantItems;


  Restaurant({this.state,this.geoPoints,this.totalRating,this.restaurantItems,this.description,this.uid,this.images,this.title,this.rating,this.favt,this.address,this.dineIn,this.open,this.seatsLeft});

}

class RestaurantItem{

  dynamic image;
  String itemTitle;
  String description;
  dynamic sale;
  int lengthTimeCost;
  Map<String,dynamic> timeCost;

  RestaurantItem({this.description,this.image,this.itemTitle,this.lengthTimeCost,this.sale,this.timeCost});

}



class Order{


  String orderId;
  String resturauntId;
  String customerId;
  String dateTime;
  bool dineIn;
  List<CheckoutItems> orderSummary;
  int subtotal;
  int seats;
  String status;

  Order({this.orderId,this.customerId,this.resturauntId,this.dateTime,this.dineIn,this.orderSummary,this.seats,this.subtotal,this.status});


  }





///Change Notifier Class///
class CheckoutItems{
  dynamic image;
  String title;
  int quantity;
  int price;
  //TimeOfDay timeOfDay;
  String time;

  CheckoutItems({this.quantity,this.price,this.time,this.image,this.title});

}

class Checkout extends ChangeNotifier{
  String restUid;
  String dateTime;
  bool dineIn;
  List<CheckoutItems> orderSummary;
  int subtotal;
  int seatsLeft;
  int totalSeats;

  Checkout(){
    dineIn = false;
    subtotal = 0;
    orderSummary = [];
    dateTime = "";
    seatsLeft=0;
    totalSeats=0;
    restUid="";
  }

  void calculateSubTotal(){

    subtotal=0;
    for(var i=0;i<orderSummary.length;i++) {
      subtotal += orderSummary[i].price * orderSummary[i].quantity;
    }
        notifyListeners();
  }


  void incrementItemQuantity(orderItemNo){
    orderSummary[orderItemNo].quantity++;
    notifyListeners();
    calculateSubTotal();
  }


  void decrementItemQuantity(orderItemNo){
    orderSummary[orderItemNo].quantity--;
    notifyListeners();
    calculateSubTotal();
  }

  void incrementSeats(){
    if(seatsLeft<totalSeats) {
      seatsLeft++;
    }
    notifyListeners();
  }


  void decrementSeats(){
    if(seatsLeft>1) {
      seatsLeft--;
    }
    notifyListeners();
  }

  void changeTimeSlot(orderItemNo,time,price){
    orderSummary[orderItemNo].time = time;
    orderSummary[orderItemNo].price = price;
    notifyListeners();
    calculateSubTotal();
  }


}


