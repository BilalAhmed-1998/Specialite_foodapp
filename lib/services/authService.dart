import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircularProgressIndicator.adaptive(
                    backgroundColor: Color(0xfffdb601),
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
    }
  }

  //sign in with apple//
  Future signInWithApple(context) async {
    final appleSignInAvailable = await TheAppleSignIn.isAvailable();
    if (appleSignInAvailable) {
      AuthorizationResult appleSignIn = await TheAppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (appleSignIn.status) {
        case AuthorizationStatus.authorized:
          try {
            final appleIdCredential = appleSignIn.credential;
            final appleOAuth = OAuthProvider('apple.com');
            final credential = appleOAuth.credential(
                idToken: String.fromCharCodes(appleIdCredential.identityToken),
                accessToken:
                    String.fromCharCodes(appleIdCredential.authorizationCode));
            final result = await _auth.signInWithCredential(credential);
            return _userFromFirebase(result.user);
          } on PlatformException catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          } on FirebaseException catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
          break;
        case AuthorizationStatus.error:
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Apple Authorization Failed!')));
          break;
        case AuthorizationStatus.cancelled:
          break;
      }
    }
  }

// sign out //
  Future signOut(context) async {
    try {
      if(FirebaseAuth.instance.currentUser.providerData.first.providerId=='google.com'){
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
      return _userFromFirebase(FirebaseAuth.instance.currentUser);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  //Delete User Account ///
  Future deleteUser(String email, String password, context) async {
    try {
      dynamic user = _auth.currentUser;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      dynamic result = await user.reauthenticateWithCredential(credentials);
      await result.user.delete();
      await FirebaseFirestore.instance
          .collection('User')
          .doc(result.user.uid)
          .delete(); // called from database class
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  //Delete Google Account ///
  Future deleteGoogleUser(context) async {
    try {
      dynamic user = _auth.currentUser;
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      dynamic result = await user.reauthenticateWithCredential(credential);
      await result.user.delete();
      await _googleSignIn.signOut();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  //Delete Apple Account ///
  Future deleteAppleUser(context) async {

    try {
      final appleSignInAvailable = await TheAppleSignIn.isAvailable();
      if (appleSignInAvailable) {
        AuthorizationResult appleSignIn = await TheAppleSignIn.performRequests([
          AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
        ]);

        switch (appleSignIn.status) {
          case AuthorizationStatus.authorized:
            try {
              final appleIdCredential = appleSignIn.credential;
              final appleOAuth = OAuthProvider('apple.com');
              final credential = appleOAuth.credential(
                  idToken: String.fromCharCodes(appleIdCredential.identityToken),
                  accessToken:
                  String.fromCharCodes(appleIdCredential.authorizationCode));
              final result = await _auth.currentUser.reauthenticateWithCredential(credential);
              await result.user.delete();
              return true;
            } on PlatformException catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.message)));
            } on FirebaseException catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.message)));
            }
            break;
          case AuthorizationStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Apple Authorization Failed!')));
            break;
          case AuthorizationStatus.cancelled:
            break;
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }

  }
}
