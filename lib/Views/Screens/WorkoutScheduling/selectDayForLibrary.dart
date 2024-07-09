import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:input_slider/input_slider.dart';

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

class selectDayForLibraryy extends StatefulWidget {
  static String daysSelected = "";
  static List<bool> isSelected = [false, false, false, false, false, false, false];
  final Workout workout;

  const selectDayForLibraryy({Key? key, required this.workout}) : super(key: key);

  @override
  State<selectDayForLibraryy> createState() => _selectDayForLibrary();
}

class _selectDayForLibrary extends State<selectDayForLibraryy> {
  final List<String> _daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
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
              child: custom_widget.customTextWidget("Assign the new workout For Specific Day", 18),
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
            itemCount: 7, // Number of days in a week
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    showConfirmationDialogg(context, index);
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



  void showConfirmationDialogg(BuildContext context, int index) {
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
      desc: 'Are you sure you want to add workout in  ${_daysOfWeek[index]}?',
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
        Navigator.of(context).pop();
      },
      btnOkOnPress: () async {
          for (int i = 0; i < selectDayForLibraryy.isSelected.length; i++) {
            selectDayForLibraryy.isSelected[i] = (i == index);
          }

          UserSingleton userSingleton = UserSingleton.getInstance();
          User_model user = userSingleton.getUser();
          String? bodyMetricId = user.bodyMetrics;
          //print( user.bodyMetrics);
          //print(user.name);

          BodyMetrics? metrics;
          if (bodyMetricId != null) {
            BodyMetricsController bodyMetricsController = BodyMetricsController();
            metrics = await bodyMetricsController.fetchBodyMetrics(
                user.bodyMetrics);
            setState(() {
              metrics?.workoutSchedule[index] =widget.workout.id!;
              bodyMetricsController.updateBodyMetrics(user.bodyMetrics, metrics!);
            });
          }
          // Navigate to the home page
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
      },
    ).show();
  }

}
