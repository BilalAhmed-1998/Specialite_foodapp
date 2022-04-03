import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  ///Listening to AuthChanges///

  Stream<AppUser> get authStateChanges =>
      _auth.authStateChanges().map(_userFromFirebase);

  AppUser _userFromFirebase(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //sign in with email password//
  Future signInWithEmailPassword(context, String email, String password) async {
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(result.user);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      return null;
    }
  }

//Sign up with email password//
  Future signUpWithEmailPassword(context, String email, String password) async {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(result.user);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      return null;
    }
  }


  //sign in with google//
  Future signInWithGoogle(context) async {

    try {
       _googleSignIn = GoogleSignIn();
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        if (googleAuth.idToken != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircularProgressIndicator
                      .adaptive(
                    backgroundColor:
                    Color(0xfffdb601),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Signing In...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )));

          final result = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken),
          );

          return _userFromFirebase(result.user);
        }
      }

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      print(e.message);
    }
  }

// sign out //
  Future signOut(context) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      return _userFromFirebase(FirebaseAuth.instance.currentUser);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  //sign in anonymously ///

  Future signInAnon(context) async {
    try {
      dynamic result = await _auth.signInAnonymously();
      return _userFromFirebase(result.user);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      return null;
    }
  }
}
