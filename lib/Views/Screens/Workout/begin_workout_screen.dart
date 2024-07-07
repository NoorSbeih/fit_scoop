import 'dart:async';

import 'package:fit_scoop/Controllers/body_metrics_controller.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import '../../../Controllers/exercise_controller.dart';
import '../../../Controllers/workout_log_controller.dart';
import '../../../Models/bodyPart.dart';
import '../../../Models/exercise_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_log.dart';
import '../../Widgets/BeginWorkoutCardWidget2.dart';
import '../main_page_screen.dart';
import 'begin_workout_exersices_screen.dart';
import 'current_workout_screen.dart';
class BeginWorkoutPage extends StatefulWidget {

  @override
  State<BeginWorkoutPage> createState() => _BeginWorkoutPageState();
}

class _BeginWorkoutPageState extends State<BeginWorkoutPage> {
  late Timer _timer;
  Duration _duration = Duration.zero;
  bool _isRunning = true;
  List<int> remainingSets = WorkoutPagee.exercises.map((exercise) => int.parse(exercise['sets'])).toList();
  List<BodyPart> parts = [];
  Map<String, String> cachedImageUrls = {}; // Cache for fetched image URLs
  @override
  void initState() {
    super.initState();
    _startTimer();

  }


  void updateRemainingSets(int index, int newCount) {
    setState(() {
      remainingSets[index] = newCount;
      //print(remainingSets[index]);
    });
  }



  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          _duration += Duration(seconds: 1);
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        leading: IconButton(
          icon: const Icon(Icons.close_outlined, color: Color(0xFF0dbab4)),
          onPressed: () {
            showDialog(

              context: context,
              builder: (BuildContext context) {

                return AlertDialog(
                  backgroundColor: Color(0xFF2C2A2A), // S
                  content:  custom_widget.customTextWidget("Are you sure you want to cancel?", 18),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()), // Replace SecondPage() with the desired page widget
                        );
                      },
                      child: custom_widget.customTextWidget("YES", 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Pop the dialog and return false
                      },
                      child: custom_widget.customTextWidget("NO", 18),
                    ),
                  ],
                );
              },
            );


          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_sharp, color: Color(0xFF0dbab4), size: 90,),
                SizedBox(width: 8),
                custom_widget.customTextWidgetForExersiceCard(_formatDuration(_duration), 40),
                IconButton(
                  icon: Icon(
                    _isRunning ? Icons.pause : Icons.play_arrow,
                    color: Color(0xFF0dbab4), size: 90,
                  ),
                  onPressed: _togglePause,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Divider(
              color: Colors.grey,
              thickness: 1.5,
            ),
          ),
          Expanded(
            child: buildExerciseCards(),
          ),
          Padding(
            padding: const EdgeInsets.only(top:20,left: 16.0, right: 16,bottom: 20),
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {

                    return AlertDialog(
                      backgroundColor: Color(0xFF2C2A2A), // S
                      content:  custom_widget.customTextWidget("Are you sure you want to end workout?", 18),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            addWorkoutLogs();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()), // Replace SecondPage() with the desired page widget
                            );
                          },
                          child: custom_widget.customTextWidget("YES", 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // Pop the dialog and return false
                          },
                          child: custom_widget.customTextWidget("NO", 18),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFA52A2A)),
                fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    );
                  },
                ),
              ),
              child: const Text(
                'End Workout',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2C2A2A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExerciseCards() {
    List<Map<String, dynamic>> exercises = WorkoutPagee.exercises;

    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> exercise = exercises[index];
        String id = exercise['id'];
        final name = exercise['name'];
        final sets = exercise['sets'];
        final weight = exercise['weight'];
        final imageUrl = exercise['imageUrl'];

        if (name != null && sets != null && weight != null) {
          return BeginWorkoutCardWidget(
            name: name.toString(),
            sets: sets.toString(),
            weight: weight.toString(),
            id: id,
            imageUrl:imageUrl.toString(),
            remainingSets: remainingSets[index],
            onRemainingCountChanged: (int newCount) {
              updateRemainingSets(index, newCount);
            },
          );
        } else {
          return SizedBox(); // Placeholder widget, replace it with your preferred widget
        }
      },
    );
  }
  Future<void> addWorkoutLogs() async {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();

      WorkoutLogController controller = new WorkoutLogController();
      WorkoutLog workoutLog = WorkoutLog(
          userId: user.id,
          workoutId: WorkoutPagee.currentWorkoutId,
          time: DateTime.now(),
          exercisesPerformed: getPerformedExercises()

      );
      controller.addWorkoutLog(workoutLog);
      // BodyMetricsController bodyController=new BodyMetricsController();
      // await bodyController.updateCurrentDay(user.bodyMetrics);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  WorkoutPage()), // Replace SecondPage() with the desired page widget
      );


  }
  static List<ExercisePerformed> getPerformedExercises() {
    return WorkoutPagee.exerciseslog.map((exercise) {
      return ExercisePerformed(
        name: exercise['name'],
        setsCompleted: int.parse(exercise['sets']),
      );
    }).toList();
  }


}


// Future<String> getImageUrl(Map<String, dynamic> exercise) async {
//   String id = exercise['id'];
//   ExerciseController controller=new ExerciseController() ;
//   Exercise? exersice=await controller.getExercise(id);
//   String? bodyPart = exersice?.bodyPart;
//   String? target = exersice?.target;
//   //print("ffffffffffffffffff");
//   //print(bodyPart);
//   //print(target);
//
//   for (int i = 0; i < parts.length; i++) {
//     if (parts[i].name == bodyPart) {
//       //print("ffjjfjf");
//       //print(parts[i].imageUrl);
//       return parts[i].imageUrl;
//
//     }
//     if (parts[i].name != bodyPart && parts[i].name == target) {
//       //print("cfff");
//       //print(parts[i].imageUrl);
//       return parts[i].imageUrl;
//     }
//   }
//   return "";
// }
