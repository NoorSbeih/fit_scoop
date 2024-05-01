import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class exercises_card {
  static Widget customcardWidget(
      String name, String sets, String weight, bool isSelected) {
    return SizedBox(
      height: 105,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: const Color(0xFF383838),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: isSelected ? Color(0xFF0FE8040) : Colors.white,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              height: double.infinity,
              width: 80,
              color: Colors.grey, // Placeholder color for the image
              child: Icon(
                Icons.photo, // Placeholder icon for the image
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:7,top: 15),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:7,bottom: 10, top: 1),
                    child: Text(
                      sets + " | " + weight,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                ],
              ),
            ),
      GestureDetector(
        onTap: () {

        },
           child:Container(
              margin: EdgeInsets.all(16),
              child: Icon(
                Icons.more_horiz_outlined,
                color: Colors.white,
              ),
            ),
      ),
          ],
        ),
      ),
    );
  }
}
