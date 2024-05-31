import 'package:fit_scoop/Controllers/body_metrics_controller.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:fit_scoop/Views/Screens/Equipments/equipment_sceen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Models/user_model.dart';
import '../../../Controllers/workout_controller.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/drawer_widget.dart';
import '../main_page_screen.dart';
import 'begin_workout_screen.dart';
class WorkoutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WorkoutPagee (),
    );
  }
}

class WorkoutPagee extends StatefulWidget{
  static late List<Map<String, dynamic>> exercises = [];
  static List<Map<String, dynamic>> exerciseslog=[];
  static late String currentWorkoutId;
  static void copyExercisesToLog() {
    exerciseslog = [];
    for (var exercise in exercises) {
      exerciseslog.add({
        'name': exercise['name'],
        'sets': exercise['sets'],
      });
    }
  }
  const WorkoutPagee ({Key? key}) : super(key: key);

  @override
  State<WorkoutPagee > createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPagee> {
  Workout? currentWorkout;
  int intensity = 0;
  String name = "";
  int duration = 0;

  late User_model user;
  void initState() {

    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
       user = userSingleton.getUser();

      String? bodyMetricId = user.bodyMetrics;
      print("djdjdj");
      print(bodyMetricId); // Assuming you want the user's UID
      if (bodyMetricId != null) {
        BodyMetricsController controller = BodyMetricsController();
        BodyMetrics? metrics = await controller.fetchBodyMetrics(bodyMetricId!);

        if (metrics != null) {
          int currentDayIndex = metrics.CurrentDay;
          currentWorkout =
          await Calculate(metrics.workoutSchedule, currentDayIndex);
          setState(() {
            WorkoutPagee.exercises = currentWorkout!.exercises;
            WorkoutPagee.copyExercisesToLog();
            print("cureennnnn");
            print(metrics.CurrentDay);

            intensity = checkIntensity(currentWorkout!.intensity);
            name = currentWorkout!.name;
            duration = currentWorkout!.duration;
          });
        } else {
          print("Empty body metrics");
        }
      }
      else {
        print("fffffffff");
      }

    } catch (e) {
      print('Error fetching data: $e');
      // Handle error if needed
    }

  }

  bool isSaved(String? id) {

    // Check if any workout in the list has the given id
    return user.savedWorkoutIds.any((workout) => id == id);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF0dbab4),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    EquipmentPage(onUpdateEquipments: (newType) {
                    setState(() {
                                         });
                },)), // Replace SecondPage() with the desired page widget
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: currentWorkout != null
                ? Align(
              alignment: Alignment.centerLeft,
              child: workout_widget.customcardWidget(
                currentWorkout!, isSaved(currentWorkout!.id), context,
                      (Workout workout, bool liked) {}
              ),
            )
                : const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ), // Adjust the height as needed for spacing
          Expanded(
            child: buildExerciseCards(WorkoutPagee.exercises),
          ),
          Container(
            alignment: Alignment.center,
            height: 80.0, // Set a fixed height for the button container
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      BeginWorkoutPage()), // Replace SecondPage() with the desired page widget
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF0dbab4)),
                fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Border radius
                    );
                  },
                ),
              ),
              child: const Text(
                'BEGIN WORKOUT',
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
            duration,
          );
        } else {
          return SizedBox(); // Placeholder widget, replace it with your preferred widget
        }
      },
    );

  }



  Future<Workout?> Calculate(List<String> workoutSchedule,int currentDayIndex) async {
    int currentDayOfWeek = DateTime
        .now()
        .weekday;
    print("The day of the week");
    print(getDayOfWeek(currentDayOfWeek));

   WorkoutPagee.currentWorkoutId = workoutSchedule[currentDayIndex];
  //  print(WorkoutPagee.currentWorkoutId);
    print("IDDDD");
    WorkoutController controller = new WorkoutController();
    return controller.getWorkout(WorkoutPagee.currentWorkoutId);
  }

  int getDayOfWeek(int day) {
    switch (day) {
      case DateTime.saturday:
        return 0;
      case DateTime.sunday:
        return 1;
      case DateTime.monday:
        return 2;
      case DateTime.tuesday:
        return 3;
      case DateTime.wednesday:
        return 4;
      case DateTime.thursday:
        return 5;
      case DateTime.friday:
        return 6;
      default:
        return 7;
    }
  }

  int checkIntensity(String intensity) {
    if (intensity == "Low") {
      return 1;
    } else if (intensity == "Medium") {
      return 2;
    } else if (intensity == "High") {
      return 3;
    }
    return 0;
  }


}