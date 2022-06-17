import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';
import 'package:specialite_foodapp/dummyData.dart';

import '../dummyData.dart';

class DatabaseCollection {
  final CollectionReference restCollection =
      FirebaseFirestore.instance.collection("Resturaunts");
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');
  
  /// referral ///

  Future<bool> checkReferral(String code, context) async {
    bool exist;
    try {
      print('going into friends collection');
      // check if the person referring(person A) is already in this user's friendlist ( A joined from this users code ).
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('friends')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        exist = value.exists;
      });
      if (!exist) {
        await userCollection
            .doc(code)
            .collection('friends')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get()
            .then((value) {
          exist = value.exists;
        });
        return !exist;
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print('phone not verified.');
      return false;
    }
  }

  Future<bool> updateFriends(String code) async {
    await userCollection
        .doc(code)
        .collection('friends')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({}).then((value) => true);
    await userCollection.doc(FirebaseAuth.instance.currentUser.uid).collection('referral')
        .doc(FirebaseAuth.instance.currentUser.uid).set({
      'referredFrom': code,
      'referralBonus': 2,
    });
    await userCollection.doc(code).collection('referral')
        .doc(code).set({
      'referredFrom': "",
      'referralBonus': 0,
    });

  }
  
  Future checkReferralBonus(context)async{
    try {
      var data = await userCollection.doc(FirebaseAuth.instance.currentUser.uid)
          .collection('referral').doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      if(data.exists) {
        if (data['referralBonus'] > 0) {
          return [true, data['referredFrom']];
        }
        return [false, ""];
      }else{
        return [false, ""];
      }
    }on Exception catch(e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print('referral issue.');
      return [false, ""];
    }
  }

  Future decrementBonus(String referredFrom, context)async{
    await userCollection.doc(FirebaseAuth.instance.currentUser.uid).collection('referral').doc(FirebaseAuth.instance.currentUser.uid).update({
      "referralBonus": FieldValue.increment(-1),
    });
    if (referredFrom !=""){
      await userCollection.doc(referredFrom).collection('referral').doc(referredFrom).update({
        "referralBonus": FieldValue.increment(1),
      });
    }
  }
  

  /// promo code ////
  Future<dynamic> checkPromo(String code) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Promos')
        .where('promoCode', isEqualTo: code)
        .get();
    if (querySnapshot.size > 0) {
      if (querySnapshot.docs[0]['expiryDate']
              .toDate()
              .compareTo(DateTime.now()) >
          0) {
        return querySnapshot.docs[0]['discount'];
      } else {
        return -1;
      }
    }
    return 0;
  }

  ///cards related functions///

  Future<bool> checkCardExist(String docID) async {
    bool exist;
    try {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('cards')
          .doc(docID)
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  Future<bool> addCard(String number, String month, String year) async {
    bool cardAdded = await userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("cards")
        .doc(number)
        .set({
      "number": number,
      "expirationMonth": month,
      "expirationYear": year,
    }).then((value) => true);
  }

  Future<dynamic> getCards() async {
    QuerySnapshot querySnapshot = await userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('cards')
        .get();
    final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return _docData;
  }

  /// -------------------////////

  /// Fetching restaurants all in one ///
  Future<bool> getRestaurants(String cityName) async {
    var value = await restCollection
        .where(
          'state',
          isEqualTo: cityName,
        )
        .get();

    for (var i = 0; i < value.size; i++) {
      var imgDocs =
          await restCollection.doc(value.docs[i].id).collection('Images').get();
      var dishDocs =
          await restCollection.doc(value.docs[i].id).collection('dishes').get();
      bool exists = await checkFavtList(value.docs[i].id, BuildContext);

      allRestaurants.add(Restaurant(
        uid: value.docs[i].id,
        joinDate: value.docs[i].get('joinedAt'),
        totalRating: value.docs[i].get('rating'),
        title: value.docs[i].get('name'),
        description: value.docs[i].get('tagline'),
        rating: value.docs[i].get('rating'),
        favt: exists,
        address: value.docs[i].get('address'),
        dineIn: value.docs[i].get('dineIn'),
        seatsLeft: value.docs[i].get('seats'),
        open: value.docs[i].get('open'),
        geoPoints: value.docs[i].get('coordinates'),
        state: value.docs[i].get('state'),
        images: [
          for (var j = 0; j < imgDocs.size; j++)
            imgDocs.docs[j].data().values.elementAt(0),
        ],
        restaurantItems: [
          for (var j = 0; j < dishDocs.size; j++)
            RestaurantItem(
              dishId: dishDocs.docs[j].id,
              itemTitle: dishDocs.docs[j].get('name'),
              description: dishDocs.docs[j].get('description'),
              lengthTimeCost: dishDocs.docs[j].get('dynamicPrice').length,
              sale: dishDocs.docs[j].get('averageprice'),
              timeCost: dishDocs.docs[j].get('dynamicPrice'),
              image: dishDocs.docs[j].get('imageUrl'),
            ),
        ],
      ));
    }

    return true;
  }

  ///Checking favt list if exists particular restaurant uid////
  Future checkFavtList(String uid, context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      bool exist;
      try {
        await userCollection
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('FavtList')
            .doc(uid)
            .get()
            .then((value) {
          exist = value.exists;
        });
        return exist;
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      return false;
    }
  }

  Future<bool> updateFavtList(String uid) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('FavtList')
          .doc(uid)
          .set({});
      return true;
    }
    return false;
  }

  Future getFavtList() async {

    List<String> Uids = [];
    var favtUids =  await userCollection.doc(FirebaseAuth.instance.currentUser.uid).collection("FavtList").get();

    for(var j =0;j<favtUids.docs.length;j++) {
      Uids.add(favtUids.docs[j].id);
    }

     var value = await restCollection
         .where(FieldPath.documentId, whereIn: Uids)
         .get();

    for (var i = 0; i < value.size; i++) {
      var imgDocs = await restCollection.doc(value.docs[i].id).collection('Images').get();
      var dishDocs = await restCollection.doc(value.docs[i].id).collection('dishes').get();
      bool exists = await checkFavtList(value.docs[i].id, BuildContext);

      favList.add(Restaurant(
        uid: value.docs[i].id,
        joinDate: value.docs[i].get('joinedAt'),
        totalRating: value.docs[i].get('rating'),
        title: value.docs[i].get('name'),
        description: value.docs[i].get('tagline'),
        rating: value.docs[i].get('rating'),
        favt: exists,
        address: value.docs[i].get('address'),
        dineIn: value.docs[i].get('dineIn'),
        seatsLeft: value.docs[i].get('seats'),
        open: value.docs[i].get('open'),
        geoPoints: value.docs[i].get('coordinates'),
        state: value.docs[i].get('state'),
        images: [
          for (var j = 0; j < imgDocs.size; j++)
            imgDocs.docs[j].data().values.elementAt(0),
        ],
        restaurantItems: [
          for (var j = 0; j < dishDocs.size; j++)
            RestaurantItem(
              dishId: dishDocs.docs[j].id,
              itemTitle: dishDocs.docs[j].get('name'),
              description: dishDocs.docs[j].get('description'),
              lengthTimeCost: dishDocs.docs[j].get('dynamicPrice').length,
              sale: dishDocs.docs[j].get('averageprice'),
              timeCost: dishDocs.docs[j].get('dynamicPrice'),
              image: dishDocs.docs[j].get('imageUrl'),
            ),
        ],
      ));
    }

    return true;
  }

  Future<bool> deleteFavtList(String uid) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('FavtList')
          .doc(uid)
          .delete();
      return true;
    }
    return false;
  }

  /// //////-------------------------////////

  /// ---------Orders related Functions      ------------/////

  Future<bool> updateOrders(Order order) async {
    await orderCollection.doc(order.orderId).set({
      'resturauntId': order.resturauntId,
      'customerId': order.customerId,
      'dineIn': order.dineIn,
      'status': order.status,
      'price': order.subtotal,
      'seats': order.seats,
      'timeOfOrder': order.dateTime,
      'orderPlaceTime': Timestamp.now(),
      'dishes': [
        for (var i = 0; i < order.orderSummary.length; i++)
          {
            'dishId': order.orderSummary[i].dishId,
            'dishName': order.orderSummary[i].title,
            'quantity': order.orderSummary[i].quantity,
            'price': order.orderSummary[i].price,
            'time': order.orderSummary[i].time,
          },
      ]
    });

    //just to fetch the fresh ongoing order list//
    ongoingOrders.clear();
  }

  Future<bool> getOngoingOrders() async {
    var orderDocs = await orderCollection
        .where('customerId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where('status', isNotEqualTo: 'completed')
        .get();

    for (var i = 0; i < orderDocs.size; i++) {
      ongoingOrders.add(Order(
          orderId: orderDocs.docs[i].id,
          resturauntId: orderDocs.docs[i]['resturauntId'],
          customerId: orderDocs.docs[i]['customerId'],
          dateTime: orderDocs.docs[i]['timeOfOrder'],
          dineIn: orderDocs.docs[i]['dineIn'],
          subtotal: orderDocs.docs[i]['price'],
          seats: orderDocs.docs[i]['seats'],
          status: orderDocs.docs[i]['status'],
          orderSummary: [
            for (var j = 0; j < orderDocs.docs[i]['dishes'].length; j++)
              CheckoutItems(
                title: orderDocs.docs[i]['dishes'][j]['dishName'],
                price: orderDocs.docs[i]['dishes'][j]['price'],
                quantity: orderDocs.docs[i]['dishes'][j]['quantity'],
                time: orderDocs.docs[i]['dishes'][j]['time'],
              ),
          ]));
    }
  }
  
  Future<bool> getCompletedOrders() async {

    var orderDocs =
    await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.uid)
        .collection('completedOrders').get();


    if(orderDocs.docs.isNotEmpty){


      for (var i = 0; i < orderDocs.size; i++) {
        orderHistory.add(Order(
            orderId: orderDocs.docs[i].id,
            resturauntId: orderDocs.docs[i]['resturauntId'],
            customerId: orderDocs.docs[i]['customerId'],
            dateTime: orderDocs.docs[i]['timeOfOrder'],
            dineIn: orderDocs.docs[i]['dineIn'],
            subtotal: orderDocs.docs[i]['price'],
            seats: orderDocs.docs[i]['seats'],
            status: orderDocs.docs[i]['status'],
            orderSummary: [
              for (var j = 0; j < orderDocs.docs[i]['dishes'].length; j++)
                CheckoutItems(
                  title: orderDocs.docs[i]['dishes'][j]['dishName'],
                  price: orderDocs.docs[i]['dishes'][j]['price'],
                  quantity: orderDocs.docs[i]['dishes'][j]['quantity'],
                  time: orderDocs.docs[i]['dishes'][j]['time'],
                ),
            ]));
      }


    }





  }


  ///Timing fetching depends on day ///

  Future getSpecificDatePrices(String restId,String dishId,String docId)async{


    var timings = await restCollection.doc(restId).collection('dishes').doc(dishId).collection('specificTimings')
    .doc(docId).get().then((value) => {
      
      if(value.exists){
        value.get('timings')
      }
      else{
        false
      }
      
    });

    var valueMap = timings.elementAt(0).elementAt(0);

    if(valueMap!=false){

      var keysString = valueMap.keys.toList();
      List <dynamic> sortedKeys = keysString.map(int.parse).toList();
      sortedKeys.sort();
      var sortedMap = {
        for (var key in sortedKeys)
          key.toString(): valueMap[key.toString()],
      };
      valueMap = sortedMap;

    }

    return (valueMap);


  }

  Future updateProfileImage()async{
    if (myimage == null){
      return null;
    }
    try{
      final ref = FirebaseStorage.instance.ref().child('userPictures').child(
          FirebaseAuth.instance.currentUser.uid
      );
      await ref.putFile(myimage);

      String url = await ref.getDownloadURL();
      return url;
    }catch(e){
      print('error uploading image');
    }
  }
}
