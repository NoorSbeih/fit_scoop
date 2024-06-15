


import 'package:fit_scoop/Views/Screens/add/addExercise.dart';
import 'package:fit_scoop/Views/Screens/Workout/exercise_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../Screens/Workout/adding_exercise_details_screen.dart';

class exercises_card {


  static Widget addingExersiceWidget(
      String name,
      String id,
      String imageUrl,
      BuildContext context,
      ) {
  TextEditingController setsController = TextEditingController();
  TextEditingController weightController = TextEditingController();

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF2C2A2A),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        custom_widget.customTextWidgetForExersiceCard("Sets", 17), // Change color here
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: setsController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        custom_widget.customTextWidgetForExersiceCard("Weight", 17), // Change color here
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: weightController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add more details as needed
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Map<String, dynamic> exercise = {
                      'name':name,
                      'id': id,
                      'sets': setsController.text,
                      'weight': weightController.text,
                    };

                    addExercise.exercises.add(exercise);
                    Navigator.pop(context);

                  },

                  child: custom_widget.customTextWidgetForExersiceCard("Confirm", 15),
                ),
              ],
            );
          },
        );
      },
      child: SizedBox(
        height: 105,
        child: Card(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
          color: Color(0xFF2C2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: double.infinity,
                width: 80,
                color: Colors.grey, // Placeholder color for the image
                // child: const Icon(
                //   Icons.photo, // Placeholder icon for the image
                //   color: Colors.white,
                // ),

                child: Image.asset(
                  imageUrl,
                  width: 148,
                  height: 128,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7, top: 15),
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.89,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                          border: Border.all(
                            width: 2.0, // Border width
                          ),
                        ),
                        child: AddingExerciseDetailsPage(id: id),
                      );
                    },
                  );

                },
                child: Container(
                  margin: EdgeInsets.all(16),
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
  static Widget AfterAddingExerciseCardWidget(
      String name, String sets, String weight,BuildContext context,String id,int duration, {required Null Function() onDelete}) {
    return SizedBox(
      height: 107,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        color: Color(0xFF2C2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              height: double.infinity,
              width: 80,
              color: Colors.grey, // Placeholder color for the image
              child: const Icon(
                Icons.photo, // Placeholder icon for the image
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7, top: 15),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7, bottom: 10, top: 1),
                    child: Text(
                      sets + " | " + weight,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                ],
              ),
            ),
      Column(
        children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.all(
                          width: 2.0, // Border width
                        ),
                      ),
                      child: AddingExerciseDetailsPage(id: id,),
                    );
                  },
                );

              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: const Icon(
                  Icons.more_horiz_outlined,
                  color: Color(0xFF0dbab4),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  if (onDelete != null) {
                    onDelete();
                  }
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Icon(
                  Icons.delete_outline,
                  color: Color(0xFF0dbab4),
                ),
              ),
            ),
    ],
      ),
          ],

        ),
      ),

    );

  }

  static Widget CurrentWorkoutCardWidget(
      String name, String sets, String weight,BuildContext context,String id,int duration) {
    return SizedBox(
      height: 110,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        color: Color(0xFF2C2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              height: double.infinity,
              width: 80,
              color: Colors.grey, // Placeholder color for the image
              child: Image.network(
                'https://v2.exercisedb.io/image/UcvY9fRgNeiV4m', // URL of your image
                fit: BoxFit.cover, // Adjust the image fit as needed
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7, top: 15),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7, bottom: 10, top: 1),
                    child: Text(
                      sets + " | " + weight,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.all(
                          width: 2.0, // Border width
                        ),
                      ),
                      child: AddingExerciseDetailsPage(id: id,),
                    );
                  },
                );

              },
              child: Container(
                margin: EdgeInsets.all(16),
                child: const Icon(
                  Icons.more_horiz_outlined,
                  color: Color(0xFF0dbab4),
                ),
              ),
            ),
          ],
        ),
      ),

    );

  }






}
