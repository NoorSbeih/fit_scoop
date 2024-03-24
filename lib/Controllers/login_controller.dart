import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginController {
  Future<User?> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
      return null;
    }
  }


  getUserData(String email) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$email').get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

Future<void> refreshIdToken() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      String? idToken = await user.getIdToken(true);
      // Use the new ID token for authentication
      print('Refreshed ID token: $idToken');
    } catch (e) {
      print('Error refreshing ID token: $e');
    }
  }
}


