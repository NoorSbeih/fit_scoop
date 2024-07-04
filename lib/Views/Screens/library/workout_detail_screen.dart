import 'package:fit_scoop/Views/Screens/library/writeReview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rating_summary/rating_summary.dart';

import '../../../Controllers/exercise_controller.dart';
import '../../../Controllers/review_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/bodyPart.dart';
import '../../../Models/exercise_model.dart';
import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import '../Community/reviewsScreen.dart';
import '../WorkoutScheduling/addWorkoutForADay.dart';
import '../WorkoutScheduling/selectDayForLibrary.dart';

class DetailPage extends StatefulWidget {
  final Workout workout;

  final Function(Workout, bool) updateSavedWorkouts;

  const DetailPage(
      {Key? key, required this.workout, required this.updateSavedWorkouts})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isLiked = false;
  late List<Workout> savedWorkouts = [];
  List<Review>? _reviews = [];
  List<Review> reviews = [];
  int numberOfSaves = 0;
  int no = 0;
  List<BodyPart> parts=[];

  @override
  void initState() {
    super.initState();
    SavedWorkout();
    fetchReviews();
    fetchBodyParts();
    numberOfSaves = widget.workout.numberOfSaves;
    no = numberOfSaves;
  }

  Future<List<Workout>> SavedWorkout() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      User_model user = userSingleton.getUser();

      if (user != null && user.id != null) {
        UserController controller = UserController();
        List<Workout> newSavedWorkouts =
            await controller.getSavedWorkouts(user.id);
        savedWorkouts = newSavedWorkouts;
        //print(newSavedWorkouts.first.id);
        setState(() {
          isLiked = liked(widget.workout.id!);
        });

        //print(isLiked);
        return savedWorkouts;
      } else {
        //print('User or user ID is null.');
        return [];
      }
    } catch (e) {
      //print('Error getting workouts by user ID: $e');
      throw e;
    }
  }

  Future<void> fetchBodyParts() async {
    try {
      ExerciseController controller = ExerciseController();
      List<BodyPart> equipments = await controller.getAllBoyImages();
      setState(() {
        parts = equipments;
      });

    } catch (e) {
      //print('Error fetching data: $e');
    }
  }

  Future<String> getImageUrl(Map<String, dynamic> exercise) async {
    String id = exercise['id'];
    ExerciseController controller=new ExerciseController() ;
    Exercise? exersice=await controller.getExercise(id);
    String? bodyPart = exersice?.bodyPart;
    String? target = exersice?.target;
    //print("ffffffffffffffffff");
    //print(bodyPart);
    //print(target);

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].name == bodyPart) {
        //print("ffjjfjf");
        //print(parts[i].imageUrl);
        return parts[i].imageUrl;

      }
      if (parts[i].name != bodyPart && parts[i].name == target) {
        //print("cfff");
        //print(parts[i].imageUrl);
        return parts[i].imageUrl;
      }
    }
    return "";
  }



  bool liked(String? id) {
    for (int i = 0; i < savedWorkouts.length; i++) {
      if ((savedWorkouts[i].id) == id) {
        return true;
      }
    }
    return false;
  }

  void fetchReviews() async {
    try {
      ReviewController controller = ReviewController();

     reviews =
          await controller.getReviewsByWorkoutId(widget.workout.id);

      if (!reviews.isEmpty) {
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
        //print('Total Reviews: $totalReviews, Total Rating: $totalRating');

        double averageRating =
            totalReviews > 0 ? totalRating / totalReviews : 0;

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
      }
    } catch (e) {
      //print('Error getting workouts by user ID: $e');
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
            const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                 "Workout Details",
                  style: TextStyle(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.workout.name,
                style: const TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 5),
              SingleChildScrollView(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.white,
                    ),
                    color: Color(0xFF2C2A2A),
                  ),
                  child: buildExerciseCards(widget.workout.exercises),
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
                          color: isLiked
                              ? Color(0xFF0dbab4)
                              : Colors.white, // Change color based on isLiked
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

                        UserSingleton userSingleton =
                            UserSingleton.getInstance();
                        User_model user = userSingleton.getUser();

                          if (user != null && user.id != null) {
                            String userId = user.id;
                            UserController controller = UserController();
                            if (isLiked) {
                              await controller.saveWorkout(
                                  userId, widget.workout.id);
                              liked(widget.workout.id!);
                            } else {
                              await controller.unsaveWorkout(
                                  userId, widget.workout.id);
                            }
                            widget.updateSavedWorkouts(widget.workout, isLiked);
                            widget.workout.numberOfSaves = numberOfSaves;
                            WorkoutController controller2 = WorkoutController();
                            controller2.updateWorkout(widget.workout);
                          }
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
                  Text(
                    'Saves: ${no ?? 0}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'INTENSITY ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF0dbab4),
                        fontFamily: 'BebasNeue'),
                  ),
                  SizedBox(height: 10.0),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                  RatingBar.builder(
                    initialRating: widget.workout.intensity == 'Beginner'
                        ? 1
                        : widget.workout.intensity == 'Intermediate'
                            ? 2
                            : widget.workout.intensity == 'Advanced'
                                ? 3
                                : 0,
                    direction: Axis.horizontal,
                    itemCount: 3,
                    itemSize: 24.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color(0xFF0dbab4),
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (double value) {
                      //print(value);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),

              const Text(
                'DESCRIPTION',
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF0dbab4),
                    fontFamily: 'BebasNeue'),
              ),
              SizedBox(height: 0),
              Text(
                widget.workout.description,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 10.0),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),

              const Text(
                "RATINGS AND REVIEWS",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF0dbab4),
                    fontFamily: 'BebasNeue'),
              ),
              if (_reviews != null && _reviews!.isNotEmpty) ...[
                RatingSummary(
                  counter: _ratingSummaryData['counter'],
                  average: averageRating,
                  showAverage: _ratingSummaryData['showAverage'],
                  counterFiveStars: _ratingSummaryData['counterFiveStars'],
                  counterFourStars: _ratingSummaryData['counterFourStars'],
                  counterThreeStars: _ratingSummaryData['counterThreeStars'],
                  counterTwoStars: _ratingSummaryData['counterTwoStars'],
                  counterOneStars: _ratingSummaryData['counterOneStars'],
                  color: _ratingSummaryData['color'],
                  labelCounterOneStarsStyle:
                      const TextStyle(color: Colors.white),
                  labelCounterTwoStarsStyle:
                      const TextStyle(color: Colors.white),
                  labelCounterThreeStarsStyle:
                      const TextStyle(color: Colors.white),
                  labelCounterFourStarsStyle:
                      const TextStyle(color: Colors.white),
                  labelCounterFiveStarsStyle:
                      const TextStyle(color: Colors.white),
                  labelStyle: const TextStyle(color: Colors.white),
                  averageStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 75,
                      fontFamily: 'BebasNeue'),
                ),
                // Add any other widgets you want to display when reviews are present
              ] else ...[
                const Text(
                  'No reviews available.',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ],
              SizedBox(height: 15.0),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),

              ElevatedButton(
                onPressed: () {
                  //  AddWorkoutForADay()
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          selectDayForLibraryy(workout :widget.workout),
                    ),
                  );

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF0dbab4)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      );
                    },
                  ),
                ),
                child: const Text(
                  'ADD TO SCHEDULE',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget buildExerciseCards(exercises) {
  return ListView.builder(
    itemCount: exercises.length,
    itemBuilder: (context, index) {
      Map<String, dynamic> exercise = exercises[index];
      String id = exercise['id'];
      final name = exercise['name'];
      final sets = exercise['sets'];
      final weight = exercise['weight'];
      if (name != null && sets != null && weight != null) {
        return exercises_card.CurrentWorkoutCardWidget(
          name.toString(),
          sets.toString(),
          weight.toString(),
          context,
          id,
            getImageUrl(exercise)
        );
      } else {
        return SizedBox(); // Placeholder widget, replace it with your preferred widget
      }
    },
  );
}
}
