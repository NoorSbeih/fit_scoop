
import 'package:fit_scoop/Controllers/review_controller.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Views/Screens/library/workout_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Models/workout_model.dart';
import '../../Models/review_model.dart';
import '../Screens/Community/community_workout_details_screen.dart';
import '../../../Controllers/workout_controller.dart';
import '../Screens/Community/reviewsScreen.dart';
import '../Screens/library/writeReview_screen.dart'; // Import the controller

class CommunitySearchWorkoutWidget extends StatefulWidget {
  final Workout workout;
  final User_model user;
  final bool isLiked;
  final ValueChanged<bool> onLikedChanged;

  CommunitySearchWorkoutWidget({
    required this.workout,
    required this.user,
    required this.isLiked,
    required this.onLikedChanged, required BuildContext context,
  });

  @override
  _CommunitySearchWorkoutWidgetState createState() => _CommunitySearchWorkoutWidgetState();
}

class _CommunitySearchWorkoutWidgetState extends State<CommunitySearchWorkoutWidget> {
  late bool isLiked;

  List<Review> reviews=[];

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    fetchReviews();
  }


  void fetchReviews() async {
    try {
      ReviewController controller = ReviewController();
      reviews = await controller.getReviewsByWorkoutId(widget.workout.id);
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error if needed
    }
  }


  void handleLikeButtonPressed() {
    WorkoutController controller = WorkoutController();
    int no;
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        no = widget.workout.numberOfSaves + 1;
      } else {
        no = widget.workout.numberOfSaves - 1;
      }
      widget.workout.numberOfSaves = no;
    });
    controller.updateWorkout(widget.workout);
    widget.onLikedChanged(isLiked);
  }

  @override
  Widget build(BuildContext context) {
    int intensity = 0;
    if (widget.workout.intensity == "Beginner") {
      intensity = 1;
    } else if (widget.workout.intensity == "Intermediate") {
      intensity = 2;
    } else if (widget.workout.intensity == "Advanced") {
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
                  Stack(
                    children: [
                      widget.user.imageLink != null
                          ? CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(widget.user.imageLink!),
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
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 150, // Adjust width to fit the remaining space
                        child: Text(
                          widget.user.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'BebasNeue',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0), // Padding inside the box
            margin: const EdgeInsets.all(8.0), // Margin around the box
            decoration: BoxDecoration(
              color: Color(0xFF2C2A2A), // Background color of the box
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
              border: Border.all(
                color: Colors.white,
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ), // Add some spacing
            child: Padding(
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
                        ignoreGestures: true,
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
                              widget.workout.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              ' ${widget.workout.exercises.length} EXERCISES',
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
                            workout: widget.workout,
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
                      color: isLiked ? Color(0xFF0dbab4) : Colors.white, // Change color based on isLiked
                    ),
                    onPressed: handleLikeButtonPressed,
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
                            child:   RateWorkoutPage(workout: widget.workout),
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
                            child: reviewsScreen(workout: widget.workout, reviews: reviews),
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
        ],
      ),
    );
  }
}
