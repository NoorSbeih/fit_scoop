import 'package:flutter/material.dart';
import 'package:fit_scoop/Controllers/body_metrics_controller.dart';
import 'package:fit_scoop/Controllers/workout_controller.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Models/user_singleton.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/drawer_widget.dart';
import '../Workout/current_workout_screen.dart';
import '../library/library_screen.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SchedulePageScreen(),
    );
  }
}

class SchedulePageScreen extends StatefulWidget {
  const SchedulePageScreen({Key? key}) : super(key: key);

  @override
  State<SchedulePageScreen> createState() => _SchedulePageScreenState();
}

class _SchedulePageScreenState extends State<SchedulePageScreen> {
  List<String> daysOfWeek = ["SUNDAY","MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];
  List<Workout?> workoutSchedule = List.filled(7, null); // Initialize with null values
  WorkoutController controller = WorkoutController();
  late User_model user;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isSaved(String? id) {
    // Check if any workout in the list has the given id
    return user.savedWorkoutIds.contains(id);
  }

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      user = userSingleton.getUser();
      String? bodyMetricId = user.bodyMetrics;
      if (user != null && user.id != null) {
        BodyMetricsController bodyMetricsController = BodyMetricsController();
        BodyMetrics? metrics = await bodyMetricsController.fetchBodyMetrics(bodyMetricId!);

        if (metrics?.workoutSchedule != null) {
          List<String> workoutIds = metrics!.workoutSchedule!;
          print("Fetched workout IDs: $workoutIds"); // Debug print
          fetchWorkouts(workoutIds);
        }
      } else {
        print('User or user ID is null.');
      }
    } catch (e) {
      print('Error getting workouts by user ID: $e');
      throw e;
    }
  }

  Future<void> fetchWorkouts(List<String> workoutIds) async {
    try {
      for (int i = 0; i < workoutIds.length; i++) {
        print("Processing workout ID: ${workoutIds[i]}"); // Debug print
        if (workoutIds[i].compareTo("No workout") != 0) {
          Workout? workout = await controller.getWorkout(workoutIds[i]);
          print("Fetched workout: ${workout?.name}"); // Debug print
          setState(() {
            workoutSchedule[i] = workout;
          });
        } else {
          setState(() {
            workoutSchedule[i] = null; // No workout for this day
          });
        }
      }
    } catch (e) {
      print('Error fetching workout details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        iconTheme: const IconThemeData(
          color: Color(0xFF0dbab4), // Change the drawer icon color here
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0dbab4)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  WorkoutPagee()), // Replace SecondPage() with the desired page widget
            );

          },
        ),
        title: const Text(
          'MY SCHEDULE',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 20, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        centerTitle: true,
      ),


      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int index = 0; index < daysOfWeek.length; index++)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,top:6,bottom:6),
                              child: Text(
                                daysOfWeek[index],
                                style: TextStyle(fontSize: 18, color: Color(0xFF0dbab4), fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (workoutSchedule[index] == null)
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '- NO WORKOUT',
                                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),

                        if (workoutSchedule[index] != null)
                          Row(
                            children: <Widget>[

                              IconButton(
                                icon: Icon(Icons.delete_outline, color: Colors.red),
                                onPressed: () {
                                  // Handle delete action for this day
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (workoutSchedule[index] != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: workout_widget.customcardWidget(
                        workoutSchedule[index]!,
                        isSaved(workoutSchedule[index]!.id),
                        context,
                            (Workout workout, bool liked) {
                          // Handle liked/unliked logic if needed
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
