import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginController {
  static String user_id="";
  Future<User?> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      user_id=user!.uid;
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


  Future<String?> getUserBodyMetric() async {
    try {

      CollectionReference users = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot snapshot = await users.doc(user_id).get();
      if (snapshot.exists) {

        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        final String? bodyMetrics = data?['bodyMetrics'];
        return bodyMetrics;

      } else {
        print('No data available for user_id: $user_id');
        return null;
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
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


