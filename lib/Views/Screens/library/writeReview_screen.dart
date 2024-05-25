import 'package:fit_scoop/Models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../Controllers/review_controller.dart';
import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';

class RateWorkoutPage extends StatefulWidget {
  final Workout workout;

  const RateWorkoutPage({super.key, required this.workout});

  @override
  _RateWorkoutPageState createState() => _RateWorkoutPageState();
}

class _RateWorkoutPageState extends State<RateWorkoutPage> {
  late User_model user;
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      User_model userr = userSingleton.getUser();
      setState(() {
        user = userr;
      });
    } catch (e) {
      print('Error getting workouts by user ID: $e');
      throw e;
    }
  }

  void showAlertDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          title: const Text(
            'Review submit',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        title: const Text(
          'Write Review',
          style: TextStyle(
            fontSize: 25, // Adjust the font size as needed
            fontFamily: 'BebasNeue',
            color: Colors.white, // Adjust the color as needed
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF0dbab4)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.workout.name,
                style: const TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 10.0),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rate:',
                      style: TextStyle(
                          color: Color(0xFF0dbab4),
                          fontSize: 25,
                          fontFamily: 'BebasNeue')),
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    itemCount: 5,
                    tapOnlyMode: true,
                    itemPadding: EdgeInsets.all(0),
                    // Set itemPadding to zero
                    itemSize: 35.0,
                    itemBuilder: (context, _) => Transform.scale(
                      scale: 0.9,
                      child: const Icon(
                        Icons.star,
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                    onRatingUpdate: (newRating) {
                      setState(() {
                        _rating = newRating;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              SizedBox(height: 20.0),
              const Text('Body:',
                  style: TextStyle(
                      color: Color(0xFF0dbab4),
                      fontSize: 25,
                      fontFamily: 'BebasNeue')),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _reviewController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        hintText: 'Add a review..',
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_rating == 0.0 || _reviewController.text.isEmpty) {
                        showAlertDialog(
                            'Please rate the workout and add a review',
                            Colors.red);
                      } else {
                        ReviewController controller = ReviewController();
                        Review review = Review(
                          workoutId: widget.workout.id,
                          reviewingUserId: user.id,
                          rating: _rating.toInt(),
                          comment: _reviewController.text,
                          timestamp: DateTime.now(),
                        );

                        controller.addReview(review);
                        showAlertDialog(
                            'Your review was sent successfully', Colors.green);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF0dbab4)),
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(340, 50)),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF2C2A2A),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
