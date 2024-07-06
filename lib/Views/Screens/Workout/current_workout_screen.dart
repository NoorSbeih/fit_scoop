import 'package:fit_scoop/Controllers/body_metrics_controller.dart';
import 'package:fit_scoop/Controllers/workout_log_controller.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:fit_scoop/Views/Screens/Equipments/equipment_sceen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Models/user_model.dart';
import '../../../Controllers/exercise_controller.dart';
import '../../../Controllers/workout_controller.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import '../../../Models/bodyPart.dart';
import '../../../Models/exercise_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_log.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/drawer_widget.dart';
import '../WorkoutScheduling/Schedule.dart';
import '../main_page_screen.dart';
import 'begin_workout_screen.dart';

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WorkoutPagee(),
    );
  }
}

class WorkoutPagee extends StatefulWidget {
  static late List<Map<String, dynamic>> exercises = [];
  static List<Map<String, dynamic>> exerciseslog = [];
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

  const WorkoutPagee({Key? key}) : super(key: key);

  @override
  State<WorkoutPagee> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPagee> {
  Workout? currentWorkout;
  WorkoutLog? log;
  int intensity = 0;
  String name = "";
  int duration = 0;
  late User_model user;
  bool isLoading = true;
  List<BodyPart> parts=[];

  @override
  void initState() {
    super.initState();
    fetchBodyParts();
    fetchData();

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

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      user = userSingleton.getUser();
      String? bodyMetricId = user.bodyMetrics;
      if (bodyMetricId != null) {
        BodyMetricsController controller = BodyMetricsController();
        BodyMetrics? metrics = await controller.fetchBodyMetrics(bodyMetricId);
        if (metrics != null) {
          // int currentDayIndex = metrics.CurrentDay;
          WorkoutLogController logController=WorkoutLogController();

          currentWorkout = await Calculate(metrics.workoutSchedule);
          log= await logController.getWorkoutLogByWorkoutId(currentWorkout!.id);
          print(currentWorkout?.id);
          print("log");
          setState(() {
            WorkoutPagee.exercises = currentWorkout?.exercises ?? [];
            WorkoutPagee.copyExercisesToLog();
            intensity = checkIntensity(currentWorkout?.intensity ?? '');
            name = currentWorkout?.name ?? '';
            duration = currentWorkout?.duration ?? 0;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      //print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isSaved(String? id) {
    return user.savedWorkoutIds.any((workout) => workout == id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        iconTheme: const IconThemeData(
          color: Color(0xFF0dbab4),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.table_view_outlined,
              color: Color(0xFF0dbab4),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SchedulePage()),
              );
            },
          ),
        ],
        title: const Text(
          "TODAY'S WORKOUT",
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 20, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : currentWorkout != null &&  log==null
          ? buildWorkoutContent()
          : buildNoWorkoutContent(),
    );
  }

  Widget buildWorkoutContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: workout_widget.customcardWidget(
              currentWorkout!,
              isSaved(currentWorkout!.id),
              context,
                  (Workout workout, bool liked) {},
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
        Expanded(
          child: buildExerciseCards(WorkoutPagee.exercises),
        ),
        Container(
          alignment: Alignment.center,
          height: 80.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BeginWorkoutPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
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
              'BEGIN WORKOUT',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNoWorkoutContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'No Workout for Today',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
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
            getImageUrl(exercise)
          );
        }else {
          return Center(child: Text('No exercises found.'));
        }
      },
    );
  }


  Future<Workout?> Calculate(List<String> workoutSchedule) async {
    int currentDayOfWeek = DateTime.now().weekday;
    WorkoutPagee.currentWorkoutId = workoutSchedule[getDayOfWeek(currentDayOfWeek)];
    WorkoutController controller = WorkoutController();
    return controller.getWorkout(WorkoutPagee.currentWorkoutId);
  }

  int getDayOfWeek(int day) {
    switch (day) {
      case DateTime.saturday:
        return 6;
      case DateTime.sunday:
        return 0;
      case DateTime.monday:
        return 1;
      case DateTime.tuesday:
        return 2;
      case DateTime.wednesday:
        return 3;
      case DateTime.thursday:
        return 4;
      case DateTime.friday:
        return 5;
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
