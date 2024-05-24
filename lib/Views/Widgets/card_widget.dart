import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class card_widget {
  static Widget customcardWidget(
      String title, String text, bool isSelected) {
    return SizedBox(
        height: 105, // Fixed height for the card
        child: Card(
      margin: const EdgeInsets.all(10),
      color: const Color(0xFF383838),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: isSelected ? Color(0xFF00DBAB4): Colors.white,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10,top:2),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
          )
        ],
      ),

        ),
    );
  }

}