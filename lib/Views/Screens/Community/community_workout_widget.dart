
import 'package:fit_scoop/Views/Screens/Community/reviewsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/workout_model.dart';
import '../library/writeReview_screen.dart';
import 'community_workout_details_screen.dart';
import '../library/workout_detail_screen.dart';
import '../../Widgets/custom_widget.dart';

class communityWorkoutWidget {
  static Widget communityCardWidget(Workout workout, BuildContext context,User_model user,bool isLike,  final ValueChanged<bool> onLikedChanged,String time,  List<Review> reviews) {

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
          Expanded(
            child: Row(
              children: [
                Stack(
                  children: [
                    user.imageLink != null
                        ? CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(user.imageLink!),
                    )
                        : CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        'images/profile-circle-svgrepo-com.svg',
                        width: 128,
                        height: 128,
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name} has posted a new workout',
                        style: const TextStyle(
                          color: Color(0xFF0dbab4),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                        maxLines: null, // Allow text to wrap onto new lines
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF0dbab4),
              fontSize: 15,
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
                        ignoreGestures: true,
                        itemPadding: const EdgeInsets.all(0),
                        itemSize: 26.0,
                        itemBuilder: (context, _) => Transform.scale(
                          scale: 0.9,
                          child: const Icon(
                            Icons.electric_bolt,
                            color: Color(0xFF0dbab4),
                          ),
                        ),
                        onRatingUpdate: (rating) {
                          //print(rating);
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
                              '${workout.exercises.length} EXERCISES',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'images/heart_clicked.svg',
                      width: 24,
                      height: 24,
                      color: isLike ? Color(0xFF0dbab4) : Colors.white,
                    ),
                    onPressed: () async {
                      //print(isLike);
                      onLikedChanged(!isLike);
                    },
                  ),
                  IconButton(
                    icon: const ImageIcon(
                      AssetImage('images/pen.png'),
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                              border: Border.all(
                                width: 2.0,
                              ),
                            ),
                            child:   RateWorkoutPage(workout: workout),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const ImageIcon(
                      AssetImage('images/review.png'),
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                              border: Border.all(
                                width: 2.0,
                              ),
                            ),
                            child: reviewsScreen(workout: workout, reviews: reviews),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
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