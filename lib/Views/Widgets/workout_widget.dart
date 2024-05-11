import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Models/workout_model.dart';
import '../Screens/library/workout_detail_screen.dart';

class workout_widget {
  static Widget customcardWidget(Workout workout,isSelected, BuildContext context) {

    int intensity = 0;
    if (workout.intensity == "Low") {
      intensity = 1;
    } else if (workout.intensity == "Medium") {
      intensity = 2;
    } else if (workout.intensity == "High") {
      intensity = 3;
    }
    return SizedBox(
      height: 110,

      child: Card(
        margin: const EdgeInsets.only(left:20,right:20,top:15),
        color: const Color(0xFF2C2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected ? Color(0xFF0dbab4) : Colors.white,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: intensity.toDouble(),
                    direction: Axis.horizontal,
                    itemCount: 3,
                    tapOnlyMode: true,
                    itemPadding: EdgeInsets.all(0),
                    itemSize: 26.0,
                    itemBuilder: (context, _) => Transform.scale(
                      scale: 0.7,
                      child: const Icon(
                        Icons.star,
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${workout.duration} MINS | ${workout.exercises.length} EXERCISES',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
             Navigator.push(context,MaterialPageRoute(
               builder: (context) => DetailPage(workout: workout),
          ),
         );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Icon(
                    Icons.more_horiz_outlined,
                    color: Color(0xFF0dbab4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
