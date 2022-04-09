import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';
import 'package:specialite_foodapp/dummyData.dart';

import '../dummyData.dart';

class DatabaseCollection {
  final CollectionReference restCollection =
      FirebaseFirestore.instance.collection("Resturaunts");
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  Future<bool> checkCardExist(String docID) async {
    bool exist;
    try {
      await userCollection.doc(FirebaseAuth.instance.currentUser.uid).collection('cards').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }
  Future<bool> addCard(String number, String month, String year)async{

    bool cardAdded=await userCollection.doc(FirebaseAuth.instance.currentUser.uid).collection("cards").doc(number).set({
      "number": number,
      "expirationMonth": month,
      "expirationYear": year,
    }).then((value) => true);
    if (cardAdded){

      userCollection.doc(FirebaseAuth.instance.currentUser.uid).update(
          {
            "numOfCards": FieldValue.increment(1),
          }).then((value) => true);
    }else{
      return false;
    }
  }

  Future<dynamic> getCards()async{
    QuerySnapshot querySnapshot= await userCollection.doc(FirebaseAuth.instance.currentUser.uid).collection('cards').get();
    final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return _docData;
  }

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

      allRestaurants.add(Restaurant(
        uid: value.docs[i].id,
        totalRating: value.docs[i].get('rating'),
        title: value.docs[i].get('name'),
        description: value.docs[i].get('tagline'),
        rating: value.docs[i].get('rating'),
        favt: false,
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

  Future addFavRestaurants(String uid) async {
    // userCollection.doc(uid).collection("")
  }
}
