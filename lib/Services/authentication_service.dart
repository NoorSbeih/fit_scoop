

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign Up with Email & Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign In with Email & Password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (error) {
      print("Error signing in: $error");
      return null;
    }
  }

  // Future<void> signInWithGoogle() async {
  //
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //       final OAuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleAuth.idToken,
  //         accessToken: googleAuth.accessToken,
  //       );
  //       final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //
  //       // // Save user data to Firebase Realtime Database
  //       // await saveUserDataToDatabase(userCredential.user);
  //       //
  //       // // Navigate to home screen
  //       // Navigator.pushReplacementNamed(context, '/home_view');
  //
  //
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         await FirebaseFirestore.instance
  //             .collection('Users')
  //             .doc(userCredential.user!.uid)
  //             .set({
  //           "Name": userCredential.user!.displayName,
  //           "Email": userCredential.user!.email,
  //         });
  //       }
  //
  //       if (mounted) return;
  //       InfoBox.show(context, InfoBox.success, "Signed In With Google");
  //
  //
  //     } on Exception catch (e) {
  //     if (mounted) return;
  //     InfoBox.show(context, InfoBox.success, e.toString());
  //   }
  // }



  Future<void> signUpWithGoogle(
      BuildContext context,
      bool mounted,
      ) async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        // await FirebaseFirestore.instance
        //     .collection('Data')
        //     .doc(authResult.user!.uid)
        //     .set({
        //   "userName": authResult.user!.displayName,
        //   "email": authResult.user!.email,
        // });
        saveUserDataToDatabase(authResult.user!);
      }
      print("helllllllllllllllllo");
      print(authResult.user!.displayName);

      if (mounted) return;
      InfoBox.show(context, InfoBox.success, "Signed In With Google");
      print("Signed In With Google");

    } on Exception catch (e) {
      if (mounted) return;
      print(e.toString());
      InfoBox.show(context, InfoBox.success, e.toString());
    }
  }

  Future<void> saveUserDataToDatabase(User user) async {
    // Example: Save user data to Firebase Realtime Database
    await FirebaseDatabase.instance
        .reference()
        .child('Data')
        .child(user.uid)
        .set({
      'name': user.displayName,
      'email': user.email,

    });
  }








  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print("Error signing out: $error");
    }
  }

  // Check if User is Signed In
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}


class InfoBox {
  static const success = 'success'; // Define the 'success' constant

  static void show(BuildContext context, String type, String message) {
    // Implementation of showing an info box in your app's UI
    // This could be a Snackbar, a Toast, or any other widget to display messages to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _getBackgroundColor(type),
      ),
    );
  }

  static Color _getBackgroundColor(String type) {
    // Return a color based on the type of message (e.g., success, error)
    // You can define your own color scheme for different message types
    return type == success ? Colors.green : Colors.red;
  }
}

