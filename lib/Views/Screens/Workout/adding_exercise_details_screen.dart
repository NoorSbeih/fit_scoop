import 'package:fit_scoop/Controllers/exercise_controller.dart';
import 'package:fit_scoop/Models/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class AddingExerciseDetailsPage extends StatefulWidget {
  final String id; // Declare an id parameter
  const AddingExerciseDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AddingExerciseDetailsPage> createState() => _AddingExerciseDetailsPageState();
}

class _AddingExerciseDetailsPageState extends State<AddingExerciseDetailsPage> {
  String name = "";
  String url = "";
  List<String> instruction = [];
  String target = "";
  String secondaryMuscles = "";
  int remainingCount = 0; // Initial remaining count

  String equipment="";
  void decrementCount() {
    setState(() {
      remainingCount--;
      if (remainingCount <= 0) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    ExerciseController controller = new ExerciseController();
    Exercise? exercise = await controller.getExercise(widget.id);
    setState(() {
      name = exercise!.name;
      instruction = exercise.instructions;
      target = exercise.target;
      List<String> muscleGroups = exercise.secondaryMuscles;
      secondaryMuscles = muscleGroups.join(', ');
      url = exercise.gifUrl;
      equipment=exercise.equipment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTitletWidget(name, Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0), // Adjust padding as needed
              child: Container(
                height: 200, // Set the height of the image
                width: MediaQuery.of(context).size.width,
                child: Image.network(url),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTitletWidget("Instructions", Color(0xFF0dbab4)),
              ),
            ),
            Column(
              children: instruction.map((instr) =>
                  Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: custom_widget.WorkoutTexttWidget(instr, 18),
                    ),
                  )
              ).toList(),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTitletWidget("TARGETED MUSCLE", Color(0xFF0dbab4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTexttWidget(target.toUpperCase(), 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTitletWidget("SECONDARY MUSCLES", Color(0xFF0dbab4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTexttWidget(secondaryMuscles.toUpperCase(), 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTitletWidget("EQUIPMENT USED", Color(0xFF0dbab4)),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 90),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTexttWidget(equipment, 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
