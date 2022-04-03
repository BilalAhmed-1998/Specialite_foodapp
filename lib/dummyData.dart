

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/services/DatabaseCollection.dart';

import 'classes/allClasses.dart';

///Firebase Collection///

DatabaseCollection dbMain = DatabaseCollection();


///profile////
dynamic myimage;
dynamic name;
dynamic emailId;
dynamic password;
String refCode="K9Q3291";
TextEditingController controller3;
String phoneNo;
String phoneCode = "";
bool isVerified = false;
Position currentCoordinates = Position();
List<String> cities = [
  "Hiroshima",
  "Islamabad",
  "Lahore",
  "Faislabad",
  "Rawalpindi",
  "Gujrat",
  "Jhelum",
];


List<Order> orderHistory = [
  Order(
    seats: 4,
    dateTime: "  "+DateFormat('dd MMMM').format(DateTime.now())+ " at "+DateFormat('hh:mm a').format(DateTime.now()),
    orderSummary: [
      CheckoutItems(
        image: "",
        title: "Kebabjees",
        price: 400,
        quantity: 2,
        time: "",
        ),
      CheckoutItems(
        image: "",
        title: "Haqbao",
        price: 900,
        quantity: 4,
        time: "",
        ),
      CheckoutItems(
        image: "",
        title: "BaoGee",
        price: 100,
        quantity: 2,
        time: "",
        ),
    ],
    subtotal: 1400,
    dineIn: true,


  ),
  Order(
    seats: 4,
    dateTime: "  "+DateFormat('dd MMMM').format(DateTime.now())+ " at "+DateFormat('hh:mm a').format(DateTime.now()),
    orderSummary: [
      CheckoutItems(
        image: "",
        title: "Kebabjees",
        price: 400,
        quantity: 2,
        time: "",
        ),
      CheckoutItems(
        image: "",
        title: "Haqbao",
        price: 500,
        quantity: 4,
        time: "",
        ),
      CheckoutItems(
        image: "",
        title: "BaoGee",
        price: 500,
        quantity: 2,
        time: "",
        ),
    ],
    subtotal: 1400,
    dineIn: false,


  ),
  Order(
    seats: 4,
    dateTime: "  "+DateFormat('dd MMMM').format(DateTime.now())+ " at "+DateFormat('hh:mm a').format(DateTime.now()),
    orderSummary: [
      CheckoutItems(
        image: "",
        title: "Kebabjees",
        price: 400,
        quantity: 2,
        time: "",
        ),
      CheckoutItems(
        image: "",
        title: "Haqbao",
        price: 500,
        quantity: 4,
        time: "",
        ),
      CheckoutItems(
        image: "",
        title: "BaoGee",
        price: 700,
        quantity: 2,
        time: "",
        ),
    ],
    subtotal: 1600,
    dineIn: true,


  ),


];

///----------////

///Change Notifier Provider Instance///

Checkout mainCheckout = Checkout();


///Home Page///
////Main Hotel Variables/////

String homeMainCity = "Hiroshima";
dynamic homeMainImage = "assets/images/rest1.png";
String homeMainTitle1 = "Tempura Naruse";
String homeMainTitle2 = "Tempura Naruse";
double tax=7;
double serviceFee=10;


////////-----------///////

List<Restaurant> nearbyList=[
  Restaurant(
      uid: "001",
      totalRating: 91,
      images: [
        "assets/images/rest1.png",
        "assets/images/rest0.png",
        "assets/images/rest2.png",
      ],
      title: "Tempura Naruse",
      description: "Tempura Naruse",
      rating: 4.2,
      favt: true,
      address: "2798 Mission Street",
      dineIn: true,
      seatsLeft: 10,
      open: true,
      ///add geopoints when firebase  implemented///
      restaurantItems: [
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 5,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 700,
              "03:00 AM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 2,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 5,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 700,
              "03:00 AM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 2,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
            }
        ),
      ]


  ),
  Restaurant(
      uid: "002",
      totalRating: 101,
      images: [
        "assets/images/rest0.png",
        "assets/images/rest1.png",
        "assets/images/rest2.png",
      ],
      title: "Kebabjees",
      description: "Tempura Naruse",
      rating: 2.2,
      favt: true,
      address: "2000 Mission Street",
      dineIn: false,
      seatsLeft: 15,
      open: false,
      ///add geopoints when firebase  implemented///
      restaurantItems: [
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 5,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 700,
              "03:00 AM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 2,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
            }
        ),
      ]


  ),
  Restaurant(
      totalRating: 81,
      uid: "003",
      images: [
        "assets/images/rest2.png",
        "assets/images/rest1.png",
        "assets/images/rest0.png",
      ],
      title: "Haq Bao",
      description: "Haq Bao",
      rating: 3.2,
      favt: false,
      address: "Saddar Mission Street",
      dineIn: true,
      seatsLeft: 11,
      open: true,
      ///add geopoints when firebase  implemented///
      restaurantItems: [
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
      ]


  ),
];

List<Restaurant> favList=[
  Restaurant(
      uid: "001",
      totalRating: 91,
      images: [
        "assets/images/rest1.png",
        "assets/images/rest0.png",
        "assets/images/rest2.png",
      ],
      title: "Tempura Naruse",
      description: "Tempura Naruse",
      rating: 4.2,
      favt: true,
      address: "2798 Mission Street",
      dineIn: true,
      seatsLeft: 10,
      open: true,
      ///add geopoints when firebase  implemented///
      restaurantItems: [
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 5,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 700,
              "03:00 AM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 2,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 5,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 700,
              "03:00 AM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 2,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
            }
        ),
      ]


  ),
  Restaurant(
      uid: "002",
      totalRating: 101,
      images: [
        "assets/images/rest0.png",
        "assets/images/rest1.png",
        "assets/images/rest2.png",
      ],
      title: "Kebabjees",
      description: "Tempura Naruse",
      rating: 2.2,
      favt: true,
      address: "2000 Mission Street",
      dineIn: false,
      seatsLeft: 15,
      open: false,
      ///add geopoints when firebase  implemented///
      restaurantItems: [
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 5,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 700,
              "03:00 AM": 600,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 2,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
            }
        ),
      ]


  ),
  Restaurant(
      totalRating: 81,
      uid: "003",
      images: [
        "assets/images/rest2.png",
        "assets/images/rest1.png",
        "assets/images/rest0.png",
      ],
      title: "Haq Bao",
      description: "Haq Bao",
      rating: 3.2,
      favt: false,
      address: "Saddar Mission Street",
      dineIn: true,
      seatsLeft: 11,
      open: true,
      ///add geopoints when firebase  implemented///
      restaurantItems: [
        RestaurantItem(
            image: "assets/images/restItem1.png",
            itemTitle: "Tempura Naruse",
            description: "Tempura Naruse",
            lengthTimeCost: 3,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
            }
        ),
        RestaurantItem(
            image: "assets/images/restItem2.png",
            itemTitle: "Kebabjees",
            description: "Kebabjees",
            lengthTimeCost: 4,
            sale: 450,
            timeCost: {
              "11:00 PM": 500,
              "12:00 PM": 600,
              "01:00 AM": 800,
              "02:00 AM": 900,
            }
        ),
      ]


  ),
];

List<Restaurant> allRestaurants = [

  Restaurant(
    uid: "001",
    totalRating: 91,
    images: [
      "assets/images/rest1.png",
      "assets/images/rest0.png",
      "assets/images/rest2.png",
    ],
    title: "Tempura Naruse",
    description: "Tempura Naruse",
    rating: 4.2,
    favt: false,
    address: "2798 Mission Street",
    dineIn: true,
    seatsLeft: 10,
    open: true,
    ///add geopoints when firebase  implemented///
    restaurantItems: [
      RestaurantItem(
          image: "assets/images/restItem1.png",
          itemTitle: "Tempura Naruse",
          description: "Tempura Naruse",
          lengthTimeCost: 3,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem2.png",
          itemTitle: "Kebabjees",
          description: "Kebabjees",
          lengthTimeCost: 4,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
            "02:00 AM": 900,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem1.png",
          itemTitle: "Tempura Naruse",
          description: "Tempura Naruse",
          lengthTimeCost: 5,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
            "02:00 AM": 700,
            "03:00 AM": 600,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem2.png",
          itemTitle: "Kebabjees",
          description: "Kebabjees",
          lengthTimeCost: 2,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem1.png",
          itemTitle: "Tempura Naruse",
          description: "Tempura Naruse",
          lengthTimeCost: 3,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem2.png",
          itemTitle: "Kebabjees",
          description: "Kebabjees",
          lengthTimeCost: 4,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
            "02:00 AM": 900,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem1.png",
          itemTitle: "Tempura Naruse",
          description: "Tempura Naruse",
          lengthTimeCost: 5,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
            "02:00 AM": 700,
            "03:00 AM": 600,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem2.png",
          itemTitle: "Kebabjees",
          description: "Kebabjees",
          lengthTimeCost: 2,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
          }
      ),
    ]


  ),
  Restaurant(
    uid: "002",
    totalRating: 101,
    images: [
      "assets/images/rest0.png",
      "assets/images/rest1.png",
      "assets/images/rest2.png",
    ],
    title: "Kebabjees",
    description: "Tempura Naruse",
    rating: 2.2,
    favt: false,
    address: "2000 Mission Street",
    dineIn: false,
    seatsLeft: 15,
    open: false,
    ///add geopoints when firebase  implemented///
    restaurantItems: [
      RestaurantItem(
        image: "assets/images/restItem1.png",
        itemTitle: "Tempura Naruse",
        description: "Tempura Naruse",
        lengthTimeCost: 3,
        sale: 450,
        timeCost: {
          "11:00 PM": 500,
          "12:00 PM": 600,
          "01:00 AM": 800,
        }
      ),
      RestaurantItem(
        image: "assets/images/restItem2.png",
        itemTitle: "Kebabjees",
        description: "Kebabjees",
        lengthTimeCost: 4,
        sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
            "02:00 AM": 900,
          }
      ),
      RestaurantItem(
        image: "assets/images/restItem1.png",
        itemTitle: "Tempura Naruse",
        description: "Tempura Naruse",
        lengthTimeCost: 5,
        sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
            "02:00 AM": 700,
            "03:00 AM": 600,
          }
      ),
      RestaurantItem(
        image: "assets/images/restItem2.png",
        itemTitle: "Kebabjees",
        description: "Kebabjees",
        lengthTimeCost: 2,
        sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
          }
      ),
    ]


  ),
  Restaurant(
      totalRating: 81,
    uid: "003",
    images: [
      "assets/images/rest2.png",
      "assets/images/rest1.png",
      "assets/images/rest0.png",
    ],
    title: "Haq Bao",
    description: "Haq Bao",
    rating: 3.2,
    favt: false,
    address: "Saddar Mission Street",
    dineIn: true,
    seatsLeft: 11,
    open: true,
    ///add geopoints when firebase  implemented///
    restaurantItems: [
      RestaurantItem(
          image: "assets/images/restItem1.png",
          itemTitle: "Tempura Naruse",
          description: "Tempura Naruse",
          lengthTimeCost: 3,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
          }
      ),
      RestaurantItem(
          image: "assets/images/restItem2.png",
          itemTitle: "Kebabjees",
          description: "Kebabjees",
          lengthTimeCost: 4,
          sale: 450,
          timeCost: {
            "11:00 PM": 500,
            "12:00 PM": 600,
            "01:00 AM": 800,
            "02:00 AM": 900,
          }
      ),
    ]


  ),

];

/// /////////////