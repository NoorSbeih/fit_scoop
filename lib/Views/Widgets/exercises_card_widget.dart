import 'package:fit_scoop/Views/Screens/add/addExercise.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../../Controllers/exercise_controller.dart';
import '../../Models/exercise_model.dart';
import '../Screens/Workout/adding_exercise_details_screen.dart';
import '../Screens/login_screen.dart';

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
                        custom_widget.customTextWidgetForExersiceCard(
                            "Sets", 17),
                        RichText(
                          text: const TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: setsController,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                        custom_widget.customTextWidgetForExersiceCard(
                            "Reps", 17), // Change color here

                        RichText(
                          text: const TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: weightController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                  onPressed: () async {
                    ExerciseController controller = ExerciseController();
                    Exercise? exercise = await controller.getExercise(id);
                    String? bodyPart = exercise?.bodyPart;
                    String? target = exercise?.target;
                    String imageUrl = "";

                    for (int i = 0; i < LoginPage.parts.length; i++) {
                      if (LoginPage.parts[i].name == bodyPart ||
                          LoginPage.parts[i].name == target) {
                        imageUrl = LoginPage.parts[i].imageUrl;
                        break; // exit loop when match is found
                      }
                    }

                    if (setsController.text.isNotEmpty && weightController.text.isNotEmpty) {
                      Map<String, dynamic> exercise = {
                        'name': name,
                        'id': id,
                        'sets': setsController.text,
                        'weight': weightController.text,
                        'imageUrl': imageUrl
                      };
                      addExercise.exercises.add(exercise);
                      Navigator.pop(context); // Close the dialog after adding exercise
                    }
                  },
                  child: custom_widget.customTextWidgetForExersiceCard(
                      "Add", 15),
                ),

                TextButton(
                  onPressed: () {
                      Navigator.pop(context);

                  },
                  child: custom_widget.customTextWidgetForExersiceCard(
                      "Cancel", 15),
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

                 // Placeholder color for the image

                child: Image.asset(
                  //replace imageurl last 3 letters with png
                  '${imageUrl.substring(0, imageUrl.length - 3)}png',
                  width: 148,
                  height: 128,
                  //fit: BoxFit.cover,
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.89,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25)),
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

  static Widget AfterAddingExerciseCardWidget(String name, String sets,
      String weight, BuildContext context, String id, String imageUrl,
      {required Null Function() onDelete}) {
    return SizedBox(
      height: 133,
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
                child:Image.asset(
                  '${imageUrl.substring(0, imageUrl.length - 3)}png',
                    width: 148,
                    height: 128,
                    fit: BoxFit.cover,
                  ),
            //  child: FutureBuilder<String>(
              //future:imageUrl,
                // builder: (context, snapshot) {
                //   if (snapshot.connectionState == ConnectionState.waiting) {
                //     return CircularProgressIndicator(); // Placeholder while loading
                //   } else if (snapshot.hasError) {
                //     return const Icon(
                //         Icons.error); // Show error icon if there is an error
                //   } else if (snapshot.hasData) {
                //     return Image.asset(
                //       snapshot.data!,
                //       width: 148,
                //       height: 128,
                //       fit: BoxFit.cover,
                //     );
                //   } else {
                //     return Icon(Icons.photo); // Placeholder if no data
                //   }
                // },
              ),
           // ),
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
                      "$sets SETS | $weight REPS",
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
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.89,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(25)),
                            border: Border.all(
                              width: 2.0, // Border width
                            ),
                          ),
                          child: AddingExerciseDetailsPage(
                            id: id,
                          ),
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
                    onDelete();
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

  static Widget CurrentWorkoutCardWidget(String name, String sets,
      String weight, BuildContext context, String id,String imageUrl) {
    return SizedBox(
      height: 120,
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
          child:Image.asset(
            '${imageUrl.substring(0, imageUrl.length - 3)}png',
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7, bottom: 10, top: 5),
                    child: Text(
                      sets + " SETS | " + weight + " REPS",
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.89,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.all(
                          width: 2.0, // Border width
                        ),
                      ),
                      child: AddingExerciseDetailsPage(
                        id: id,
                      ),
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
