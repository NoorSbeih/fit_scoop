import 'package:flutter/material.dart';

import '../Models/user_model.dart';
import '../Services/Database Services/user_service.dart';


class UserController {
  final UserService _userService = UserService();

  User? currentUser;


  Future<void> updateUserProfile(User user) async {
    try {
      await _userService.updateUser(user);
      // Optionally: Update UI or state to reflect the profile update
      currentUser = user;
    } catch (e) {

      print(e.toString());
    }
  }
}

