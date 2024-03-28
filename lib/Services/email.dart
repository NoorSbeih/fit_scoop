import 'package:flutter/material.dart';

class EmailValidator {
  bool isEmailValid(String? email) {
    if (email == null) {
      return false;
    }

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
        return 'Email is required';

    } else if (!isEmailValid(value)) {

      return 'Enter a valid email address';
    } else {
      return "";

    }
  }
}
