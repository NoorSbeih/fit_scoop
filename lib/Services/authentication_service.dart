


import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user_model.dart' as model;
import '../Views/Screens/main_page_screen.dart';
import 'Database Services/user_service.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Sign Up with Email & Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Save user authentication state
      await _persistUser(result.user!);

      return result.user;
    } catch (e) {
      //print(e.toString());
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

      // Save user authentication state
      await _persistUser(userCredential.user!);

      return userCredential.user;
    } catch (error) {
      //print("Error signing in: $error");
      return null;
    }
  }




  Future<User?> signUpWithGoogle(BuildContext context, bool mounted) async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }
  Future<void> saveUserDataToDatabase(User user) async {
    try {
      final UserService _userService = UserService();
      model.User_model usermodel = model.User_model(id: user.uid, name: user.displayName.toString(), email: user.email.toString());

      await _userService.addUser(usermodel);
      //print('Data saved successfully!');
    } catch (error) {
      //print('Error saving data: $error');
    }
  }


  Future<void> _persistUser(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userUid', user.uid);
    } catch (error) {
      //print("Error persisting user: $error");
    }
  }



  Future<User?> getAuthenticatedUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userUid = prefs.getString('userUid');

      if (userUid != null) {
        // User is authenticated, return the user
        return _auth.currentUser;
      } else {
        // User is not authenticated
        return null;
      }
    } catch (error) {
      //print("Error retrieving user: $error");
      return null;
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        return userCredential.user;
        // Navigate to the desired page after sign in
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      // Handle sign in errors
      print('Error signing in with Google: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userUid');

      await _auth.signOut();
    } catch (error) {
      //print("Error signing out: $error");
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

