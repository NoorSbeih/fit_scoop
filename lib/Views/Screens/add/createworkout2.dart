import 'package:fit_scoop/Controllers/workout_controller.dart';
import 'package:fit_scoop/Views/Screens/WorkoutScheduling/addWorkoutForADay.dart';
import 'package:fit_scoop/Views/Screens/add/createworkout1.dart';
import 'package:fit_scoop/Views/Screens/add/addExercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class createWorkout2 extends StatefulWidget {
  static bool isPrivate = true;
  static double rating = 0;
  static String label = "Beginner";
  static TextEditingController descriptionController = new TextEditingController();

  @override
  _createWorkout2 createState() => _createWorkout2();
}

class _createWorkout2 extends State<createWorkout2> {
  String ErrorText = '';

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        title: const Text(
          'CREATE WORKOUT',
          style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'BebasNeue'),
        ),
        iconTheme: IconThemeData(color: Color(0xFF0dbab4)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Workout Intensity',
                    style: TextStyle(fontSize: 24, color: Color(0xFF0dbab4), fontFamily: 'BebasNeue'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 3,
                        tapOnlyMode: true,
                        itemPadding: EdgeInsets.all(0),
                        itemSize: 35.0,
                        itemBuilder: (context, _) => Transform.scale(
                          scale: 0.9,
                          child: const Icon(
                            Icons.electric_bolt,
                            color: Color(0xFF0dbab4),
                          ),
                        ),
                        onRatingUpdate: (newRating) {
                          setState(() {
                            createWorkout2.rating = newRating;
                            switch (newRating.toInt()) {
                              case 1:
                                createWorkout2.label = 'Beginner';
                                break;
                              case 2:
                                createWorkout2.label = 'Intermediate';
                                break;
                              case 3:
                                createWorkout2.label = 'Advanced';
                                break;
                            }
                          });
                        },
                      ),
                      Text(
                        createWorkout2.label,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            const Text(
              'Description',
              style: TextStyle(fontSize: 25, color: Color(0xFF0dbab4), fontFamily: 'BebasNeue'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding
                  child: TextField(
                    controller: createWorkout2.descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15.0),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (text) {
                      setState(() {
                        ErrorText = '';
                        createWorkout2.descriptionController.text = text;
                      });
                    },
                  ),
                ),
              ),
            ),
            if (ErrorText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  ErrorText,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            const SizedBox(height: 16.0),
            SwitchListTile(
              title: const Text(
                'Private Workout',
                style: TextStyle(fontSize: 25, color: Color(0xFF0dbab4), fontFamily: 'BebasNeue'),
              ),
              value: createWorkout2.isPrivate,
              onChanged: (value) {
                setState(() {
                  createWorkout2.isPrivate = value;
                });
              },
              activeColor: Color(0xFF0dbab4),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: SingleChildScrollView( // Wrap the Row with SingleChildScrollView
                scrollDirection: Axis.horizontal, // Allow horizontal scrolling
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (createWorkout2.descriptionController.text.isEmpty) {
                          setState(() {
                            ErrorText = 'Please enter a description for the workout';
                          });
                        } else {
                          setState(() {
                            ErrorText = '';
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddWorkoutForADayy()), // Replace SecondPage() with the desired page widget
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
                        fixedSize: MaterialStateProperty.all<Size>(const Size(335, 50)),
                        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                              (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          },
                        ),
                      ),
                      child: const Text(
                        'FINISH',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF2C2A2A)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
