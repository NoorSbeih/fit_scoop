import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../Models/bodyMetricsSingleton.dart';
import '../Models/user_singleton.dart';
import '../Services/authentication_service.dart';

class AuthController {
  final AuthenticationService _authenticationService = AuthenticationService();

  // Register with email and password
  Future<User?> registerWithEmail(BuildContext context, String email, String password) async {
    try {
      // Call the signUpWithEmail method from AuthenticationService
      return await _authenticationService.signUpWithEmail(email, password);
    } catch (error) {
      // Handle registration errors
      //print("Error registering: $error");
      return null;
    }
  }

  // Log in with email and password
  Future<User?> loginWithEmail(BuildContext context, String email, String password) async {
    try {
      // Call the signInWithEmailAndPassword method from AuthenticationService
      return await _authenticationService.signInWithEmailAndPassword(email, password);
    } catch (error) {
      // Handle login errors
      //print("Error logging in: $error");
      return null;
    }
  }

  // Log in with Google
  Future<void> loginWithGoogle(BuildContext context, bool mounted) async {
    try {
      // Call the signUpWithGoogle method from AuthenticationService
      await _authenticationService.signUpWithGoogle(context, mounted);
    } catch (error) {
      // Handle login errors
      //print("Error logging in with Google: $error");
    }
  }

  // Log out
  Future<void> logout(BuildContext context) async {
    try {
      // Call the signOut method from AuthenticationService
      await _authenticationService.signOut();
    } catch (error) {
      // Handle logout errors
      //print("Error logging out: $error");
    }
  }

}
