

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseCollection{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> addCard(String number, String month, String year){
    firestore.collection("Card").doc(FirebaseAuth.instance.currentUser.uid).collection("cards").doc().set({
      "number":number,
      "expirationMonth": month,
      "expirationYear": year,
    }).then((value) => true);
  }












}