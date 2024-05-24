
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Models/workout_model.dart';
import 'community_workout_details_screen.dart';
import '../library/workout_detail_screen.dart';
import '../../Widgets/custom_widget.dart';

class communityWorkoutWidget {
  static Widget communityCardWidget(Workout workout, BuildContext context,String name,bool isLike,  final ValueChanged<bool> onLikedChanged,String time) {

    int intensity = 0;
    if (workout.intensity == "Beginner") {
      intensity = 1;
    } else if (workout.intensity == "Intermediate") {
      intensity = 2;
    } else if (workout.intensity == "Advanced") {
      intensity = 3;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Row(
            children: [
              const Icon(
                Icons.account_circle_outlined,
                color: Color(0xFF0dbab4),
              ),
              SizedBox(width: 5), // Add spacing between icon and text
              Text(
                '${name} has posted new a workout',
                style: const TextStyle(
                  color: Color(0xFF0dbab4),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF0dbab4),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
      SizedBox(height: 10), // Add some spacing
      Padding(
              padding: const EdgeInsets.all(0.0),
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
                        itemPadding: const EdgeInsets.all(0),
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
                            const SizedBox(height: 2),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommunityWorkoutDetailPage(
                            workout: workout,
                          ),
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

    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Row(
    children: [
      IconButton(
        icon: SvgPicture.asset(
          'images/heart_clicked.svg',
          width: 24,
          height: 24,
          color:isLike  ? Color(0xFF0dbab4) : Colors
              .white, // Change color based on isLiked
        ),
        onPressed: () async {
          print(isLike);
          onLikedChanged(!isLike);
        },
      ),
      IconButton(
        icon: Icon(Icons.rate_review_outlined),
        color: Colors.white,
        onPressed: () async {
        },
      ),
        ],

    ),
    ]
    ),

          const Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
    ]
    )
    );
  }
}