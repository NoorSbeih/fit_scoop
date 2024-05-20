import 'package:fit_scoop/Views/Screens/library/writeReview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rating_summary/rating_summary.dart';

import '../../../Controllers/review_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';

class DetailPage extends StatefulWidget {
  final Workout workout;
  final Function(Workout, bool) updateSavedWorkouts;

  const DetailPage({Key? key, required this.workout, required this.updateSavedWorkouts}) : super(key: key);

 // const DetailPage({Key? key, required this.workout}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isLiked;

  List<Review>? _reviews = [];
  int numberOfSaves = 0;
  int no = 0;

  @override
  void initState() {
    super.initState();
    fetchReviews();
    numberOfSaves = widget.workout.numberOfSaves;
    no = numberOfSaves;
    isLiked = liked(widget.workout.id);

    print(isLiked);
  }

  void fetchReviews() async {
    try {
      ReviewController controller = ReviewController();
      List<Review> reviews = await controller.getReviewsByWorkoutId(
          widget.workout.id);
      double totalRating = 0;
      int totalReviews = reviews.length;
      int counterFiveStars = 0;
      int counterFourStars = 0;
      int counterThreeStars = 0;
      int counterTwoStars = 0;
      int counterOneStars = 0;

      for (int i = 0; i < totalReviews; i++) {
        int rating = reviews[i].rating;
        totalRating += rating;
        switch (rating) {
          case 5:
            counterFiveStars++;
            break;
          case 4:
            counterFourStars++;
            break;
          case 3:
            counterThreeStars++;
            break;
          case 2:
            counterTwoStars++;
            break;
          case 1:
            counterOneStars++;
            break;
          default:
            break;
        }
      }
      print('Total Reviews: $totalReviews, Total Rating: $totalRating');

      double averageRating = totalReviews > 0 ? totalRating / totalReviews : 0;

      if (averageRating != "Null" && totalReviews != "Null") {
        setState(() {
          _ratingSummaryData = {
            'counter': totalReviews,
            'showCounter': false,
            'average': averageRating,
            'showAverage': true,
            'color': Color(0xFF0dbab4),
            'counterFiveStars': counterFiveStars,
            'counterFourStars': counterFourStars,
            'counterThreeStars': counterThreeStars,
            'counterTwoStars': counterTwoStars,
            'counterOneStars': counterOneStars,
          };
          _reviews = reviews;
        });
      }
    } catch (e) {
      print('Error getting workouts by user ID: $e');
      throw e;
    }
  }


  Map<String, dynamic> _ratingSummaryData = {};

  @override
  Widget build(BuildContext context) {
    double averageRating = _ratingSummaryData['average'] ?? 0;
    if (!averageRating.isFinite || averageRating.isNaN) {
      averageRating = 0;
    }
    return Scaffold(
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.workout.name,
              style: const TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: 'BebasNeue'),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.5,
                  color: Colors.white,
                ),
                color: Color(0xFF2C2A2A),
              ),
              child: const Center(child: Text('Exercise Images')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.rate_review_sharp),
                      color: Colors.white,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RateWorkoutPage(workout: widget.workout),
                          ),
                        );


                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'images/heart_clicked.svg',
                        width: 24,
                        height: 24,
                        color: isLiked  ? Color(0xFF0dbab4) : Colors
                            .white, // Change color based on isLiked
                      ),
                      onPressed: () async {
                        setState(() {
                          isLiked = !isLiked;
                          if (isLiked) {
                            no = numberOfSaves + 1;
                            numberOfSaves++;
                          } else {
                            no = numberOfSaves - 1;
                            numberOfSaves--;
                          }
                        });

                        UserSingleton userSingleton = UserSingleton
                            .getInstance();
                        User_model user = userSingleton.getUser();

                        if (user != null && user.id != null) {
                          String userId = user.id;
                          UserController controller = UserController();
                          if (isLiked) {
                            await controller.saveWorkout(
                                userId, widget.workout.id);
                            liked(widget.workout.id);
                          } else {
                            await controller.unsaveWorkout(
                                userId, widget.workout.id);
                          }
                          widget.workout.updateNumberOfSaves(no);
                          widget.updateSavedWorkouts(widget.workout, isLiked);
                        }
                      },
                    ),
                  ],
                ),
                Text(
                  'Saves: ${no ?? 0}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'INTENSITY ',
                  style: TextStyle(fontSize: 25,
                      color: Color(0xFF0dbab4),
                      fontFamily: 'BebasNeue'),
                ),
                RatingBar.builder(
                  initialRating: widget.workout.intensity == 'Low'
                      ? 1
                      : widget.workout.intensity == 'Medium'
                      ? 2
                      : widget.workout.intensity == 'High'
                      ? 3
                      : 0,
                  direction: Axis.horizontal,
                  itemCount: 3,
                  itemSize: 24.0,
                  itemBuilder: (context, _) =>
                  const Icon(
                    Icons.star,
                    color: Color(0xFF0dbab4),
                  ),
                  ignoreGestures: true,
                  onRatingUpdate: (double value) {
                    print(value);
                  },
                ),

              ],
            ),
            SizedBox(height: 5),
            const Text(
              'DESCRIPTION',
              style: TextStyle(fontSize: 25,
                  color: Color(0xFF0dbab4),
                  fontFamily: 'BebasNeue'),

            ),
            SizedBox(height: 0),
            Text(
              widget.workout.description,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),

            const Text(
              "RATINGS AND REVIEWS",
              style: TextStyle(fontSize: 25,
                  color: Color(0xFF0dbab4),
                  fontFamily: 'BebasNeue'),
            ),
            // RatingSummary(
            //   counter: _ratingSummaryData['counter'] ?? 0,
            //   average: (_ratingSummaryData['average'] ?? 0.0).isFinite
            //       ? (_ratingSummaryData['average'] ?? 0.0)
            //       : 0.0,
            //   showAverage: _ratingSummaryData['showAverage'] ?? false,
            //   color: _ratingSummaryData['color'] ?? Colors.white,
            //   counterFiveStars: _ratingSummaryData['counterFiveStars'] ?? 0,
            //   counterFourStars: _ratingSummaryData['counterFourStars'] ?? 0,
            //   counterThreeStars: _ratingSummaryData['counterThreeStars'] ?? 0,
            //   counterTwoStars: _ratingSummaryData['counterTwoStars'] ?? 0,
            //   counterOneStars: _ratingSummaryData['counterOneStars'] ?? 0,
            //   labelCounterOneStarsStyle: const TextStyle(color: Colors.white),
            //   labelCounterTwoStarsStyle: const TextStyle(color: Colors.white),
            //   labelCounterThreeStarsStyle: const TextStyle(color: Colors.white),
            //   labelCounterFourStarsStyle: const TextStyle(color: Colors.white),
            //   labelCounterFiveStarsStyle: const TextStyle(color: Colors.white),
            //   labelStyle: const TextStyle(color: Colors.white),
            //   averageStyle: const TextStyle(
            //       color: Colors.white, fontSize: 75, fontFamily: 'BebasNeue'),
            // ),

            ElevatedButton(
              onPressed: () {
                // Add your button functionality here
                print('Your button action');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF0dbab4)), // Change color to blue
                fixedSize: MaterialStateProperty.all<Size>(const Size(10, 30)),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // Border radius
                    );
                  },
                ),
              ),
              child: const Text(
                'Try this workout',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }


  bool liked(String id) {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();
    List<String> ids = user.savedWorkoutIds;
    print("dhdhdhd");
    print(user.id);
    for (int i = 0; i < ids.length; i++) {
      print(ids[i]);
    }
    return ids.contains(id);
  }
}
