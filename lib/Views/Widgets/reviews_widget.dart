import 'package:fit_scoop/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Models/review_model.dart';
import '../../Models/workout_model.dart';
import '../Screens/library/workout_detail_screen.dart';

class ReviewsWidget {
  static Widget reviewsWidget(
      Workout workout, Review review, User_model creator) {
    int intensity = 0;
    if (workout.intensity == "Low") {
      intensity = 1;
    } else if (workout.intensity == "Medium") {
      intensity = 2;
    } else if (workout.intensity == "High") {
      intensity = 3;
    }
    return Padding(
        padding: const EdgeInsets.only(left: 20.0,right:20),
    child:SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          workout.name,
                          style: const TextStyle(
                            color: Color(0xFF0dbab4),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        // Add space between name and rating bar
                       SizedBox(width:120),
                        RatingBar.builder(
                          initialRating: intensity.toDouble(),
                          direction: Axis.horizontal,
                          itemCount: 3,
                          tapOnlyMode: true,
                          itemPadding: EdgeInsets.all(0),
                          itemSize: 30.0,
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
                      ],
                    ),
                    Text(
                      'Created by: ${creator.name}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Text(
              '${review.comment} ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              )
          ),
          SizedBox(height: 10.0),
          const Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ],
      ),
    ),
    );
  }
}
