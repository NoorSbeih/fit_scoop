import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Controllers/workout_controller.dart';
import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/reviews_widget.dart';


class reviewsProfile extends StatefulWidget {
  final List<Review> reviews;
  final User_model user;

  const reviewsProfile({super.key, required this.reviews, required this.user});

  @override
  State<reviewsProfile> createState() => _ReviewsScreen();
}

class _ReviewsScreen extends State<reviewsProfile> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2A2A),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Color(0xFF0dbab4)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the page
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  Text("${widget.user?.name}'s Reviews").data ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'BebasNeue',
                  ),
                ),
              ),
            ),
            SizedBox(width: 48), // To balance the space taken by IconButton
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30),
            // Adjust the padding as needed
            child: Text(
              '${widget.reviews.length} REVIEWS',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF0dbab4),
                fontFamily: 'BebasNeue',
              ),
            ),
          ),
          SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ),
          // Add this variable to track loading state

          Expanded(
            child: ListView.builder(
              itemCount: widget.reviews.length,
              itemBuilder: (context, index) {
                Review review = widget.reviews[index];
                WorkoutController workoutController = WorkoutController();
                UserController userController = UserController();

                return FutureBuilder<Workout?>(
                  future: workoutController.getWorkout(review.workoutId),
                  builder: (context, workoutSnapshot) {
                    if (workoutSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      isLoading = true; // Set loading state to true
                      return SizedBox(); // Return an empty widget
                    } else if (workoutSnapshot.hasError) {
                      return Text('Error: ${workoutSnapshot.error}');
                    } else if (!workoutSnapshot.hasData ||
                        workoutSnapshot.data == null) {
                      return Text('Workout not found');
                    } else {
                      Workout workout = workoutSnapshot.data!;
                      return FutureBuilder<User_model?>(
                        future: userController.getUser(workout.creatorId),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            if (!isLoading) {
                              isLoading = true; // Set loading state to true
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return SizedBox(); // Return an empty widget
                            }
                          } else if (userSnapshot.hasError) {
                            return Text('Error: ${userSnapshot.error}');
                          } else if (!userSnapshot.hasData ||
                              userSnapshot.data == null) {
                            return Text('Creator not found');
                          } else {
                            User_model creator = userSnapshot.data!;
                            isLoading = false; // Reset loading state
                            return ReviewsWidget.reviewsWidget(
                                workout, review, creator);
                          }
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
