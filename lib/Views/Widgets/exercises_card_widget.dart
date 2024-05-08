import 'package:fit_scoop/Views/Screens/exercise_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class exercises_card {
  static Widget customcardWidget(
      String name, String sets, String weight,BuildContext context,String id,int duration) {
    return SizedBox(
      height: 105,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
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
                    padding: const EdgeInsets.only(left: 7, top: 15),
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
                    padding: EdgeInsets.only(left: 7, bottom: 10, top: 1),
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
                print("popppp"+id);
                // Show the bottom sheet from bottom to up
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.all(
                          width: 2.0, // Border width
                        ),
                      ),
                      child: ExerciseDetailsPage(id: id,sets:sets,duration:duration),
                    );
                  },
                );

              },
              child: Container(
                margin: EdgeInsets.all(16),
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: Color(0xFF0dbab4),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
