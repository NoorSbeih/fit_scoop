import 'package:flutter/material.dart';
import '../Services/authentication_service.dart'; // Assuming your AuthService class is in service/auth_service.dart

class SignUpController {
  final AuthenticationService _authService = AuthenticationService();

  Future<void> signUpUser(String email, String password, BuildContext context) async {
    var user = await _authService.signUpWithEmail(email, password);
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/home_view'); // Navigate to home page or dashboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up failed')),
      );
    }
  }
}