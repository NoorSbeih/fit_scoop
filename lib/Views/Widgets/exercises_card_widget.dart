import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class exercises_card {
  static Widget customcardWidget(
      String name, String sets, String weight, bool isSelected) {
    return SizedBox(
      height: 105,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Color(0xFF2C2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              height: double.infinity,
              width: 80,
              color: Colors.grey, // Placeholder color for the image
              child: const Icon(
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
