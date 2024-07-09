
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../../../Controllers/body_metrics_controller.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/body_metrics_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';
import '../add/createworkout1.dart';
import '../add/createworkout2.dart';
import '../main_page_screen.dart';
import 'package:fit_scoop/Views/Screens/add/addExercise.dart';

class AddWorkoutForADay extends StatelessWidget {
  const AddWorkoutForADay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddWorkoutForADayy(),
    );
  }
}

class AddWorkoutForADayy extends StatefulWidget {
  static String daysSelected = "";
  static List<bool> isSelected = [false, false, false, false, false, false, false];

  const AddWorkoutForADayy({Key? key}) : super(key: key);

  @override
  State<AddWorkoutForADayy> createState() => _AddWorkoutForADayState();
}

class _AddWorkoutForADayState extends State<AddWorkoutForADayy> {
  final List<String> _daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0dbab4)),
          onPressed: () {
            Navigator.pop(context);
            createWorkout2();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.startTextWidget("One more step!"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 16, right: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.customTextWidget(
                  "Assign the new workout For Specific Day", 15),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 16, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please choose only one day!',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  color: Colors.red,
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 17.0,
              childAspectRatio: 3.0,
            ),
            itemCount: 7,
            // Number of days in a week
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    showConfirmationDialog(context, index);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF383838),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),

                    ),
                  ),
                  child: Text(
                    _daysOfWeek[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  void showAlertDialogSuccess(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: const Color(0xFF2C2A2A),
      dialogType: DialogType.success,
      title: "Profile Update",
      titleTextStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        color: Colors.white,
      ),
      desc: 'Profile Updated Successfully',
      descTextStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        color: Color(0xFFA1A1A1),
      ),
      // btnCancelText:'Dismiss',
      btnCancelText: 'Dismiss',
      btnOkText: 'Add',
      btnCancelColor: const Color(0xFF383838),
      btnOkColor: Colors.red,
      dialogBorderRadius: BorderRadius.circular(15),
      buttonsBorderRadius: BorderRadius.circular(15),
      dismissOnTouchOutside: true,
      animType: AnimType.leftSlide,
      btnCancelOnPress: () {

      },

      btnOkOnPress: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => HomePage(initialIndex: 4)),
          // Set initialIndex to 1 for ProfilePage
              (Route<dynamic> route) => false,
        );
      },
    ).show();
  }



  void showConfirmationDialoggg(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: custom_widget.customTextWidget('Confirm Day Selection',18),
          backgroundColor: Color(0xFF2C2A2A),
          content:  custom_widget.customTextWidget('Are you sure you want to add workout in ${_daysOfWeek[index]}?',16),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child:  custom_widget.customTextWidget('No',16),
            ),
            TextButton(
              onPressed: () async {
                // Perform asynchronous work outside setState
                for (int i = 0; i < AddWorkoutForADayy.isSelected.length; i++) {
                  AddWorkoutForADayy.isSelected[i] = (i == index);
                }

                UserSingleton userSingleton = UserSingleton.getInstance();
                User_model user = userSingleton.getUser();

                Workout workout = Workout(
                  name: createWorkout1.name,
                  description: createWorkout2.descriptionController.text,
                  exercises: addExercise.exercises,
                  intensity: createWorkout2.label,
                  creatorId: user.id,
                  numberOfSaves: 0,
                  reviews: [],
                  isPrivate: createWorkout2.isPrivate,
                  timestamp: DateTime.now(),
                );

                WorkoutController workoutController = WorkoutController();
                await workoutController.createWorkout(workout);
                addExercise.exercises.clear();
                String? bodyMetricId = user.bodyMetrics;
                //print( user.bodyMetrics);
                //print(user.name);

                BodyMetrics? metrics;
                if (bodyMetricId != null) {
                  BodyMetricsController bodyMetricsController = BodyMetricsController();
                  metrics = await bodyMetricsController.fetchBodyMetrics(
                      user.bodyMetrics);
                  setState(() {
                    metrics?.workoutSchedule[index] = workout.id!;
                    bodyMetricsController.updateBodyMetrics(user.bodyMetrics, metrics!);
                  });
                }

                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: custom_widget.customTextWidget('Yes', 16),
            ),

          ],
        );
      },
    );
  }

  void showConfirmationDialog(BuildContext context, int index) {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: const Color(0xFF2C2A2A),
      dialogType: DialogType.question,
      title: 'Confirm Day Selection',
      titleTextStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        color: Colors.white,
      ),
      desc: 'Are you sure you want to select ${_daysOfWeek[index]}?',
      descTextStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        color: Color(0xFFA1A1A1),
      ),
      btnCancelText: 'Dismiss',
      btnOkText: 'Add',
      btnCancelColor: const Color(0xFF383838),
      btnOkColor: Color(0xFF0dbab4),
      dialogBorderRadius: BorderRadius.circular(15),
      buttonsBorderRadius: BorderRadius.circular(15),
      dismissOnTouchOutside: true,
      animType: AnimType.leftSlide,
      btnCancelOnPress: () {
      },
      btnOkOnPress: () async {
          for (int i = 0; i < AddWorkoutForADayy.isSelected.length; i++) {
            AddWorkoutForADayy.isSelected[i] = (i == index);
          }

          UserSingleton userSingleton = UserSingleton.getInstance();
          User_model user = userSingleton.getUser();

          Workout workout = Workout(
            name: createWorkout1.name,
            description: createWorkout2.descriptionController.text,
            exercises: addExercise.exercises,
            intensity: createWorkout2.label,
            creatorId: user.id,
            numberOfSaves: 0,
            reviews: [],
            isPrivate: createWorkout2.isPrivate,
            timestamp: DateTime.now(),
          );

          WorkoutController workoutController = WorkoutController();
          await workoutController.createWorkout(workout);
          addExercise.exercises.clear();
          String? bodyMetricId = user.bodyMetrics;
          //print( user.bodyMetrics);
          //print(user.name);

          BodyMetrics? metrics;
          if (bodyMetricId != null) {
            BodyMetricsController bodyMetricsController = BodyMetricsController();
            metrics = await bodyMetricsController.fetchBodyMetrics(
                user.bodyMetrics);
            setState(() {
              metrics?.workoutSchedule[index] = workout.id!;
              bodyMetricsController.updateBodyMetrics(user.bodyMetrics, metrics!);
            });
          }

          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },

    ).show();
  }
}