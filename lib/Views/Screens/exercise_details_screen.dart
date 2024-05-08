import 'package:fit_scoop/Controllers/exercise_controller.dart';
import 'package:fit_scoop/Models/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:flutter/material.dart';


class ExerciseDetailsPage extends StatefulWidget{
  final String id; // Declare an id parameter
  final String sets;
  final int duration;
  const ExerciseDetailsPage({
    Key? key,
    required this.id,
    required this.sets,
    required this.duration,
  }) : super(key: key);

  @override
  State<ExerciseDetailsPage> createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
   String name="";

   String description="";
   String target="";
   int remainingCount = 0; // Initial remaining count
   void decrementCount() {
     setState(() {
       remainingCount--;
       if (remainingCount <= 0) {
         Navigator.of(context).pop();
       }
     });

   }

  void initState() {
    super.initState();
    remainingCount = int.tryParse(widget.sets) ?? 0;

    fetchData();

  }

  void fetchData() async {
ExerciseController controller=new ExerciseController();
Exercise? exercise=await controller.getExercise(widget.id) ;
setState(() {
name=exercise!.name;
description=exercise.description;
List<String> muscleGroups = exercise.muscleGroups;
 target = muscleGroups.join(', ');

});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
      Padding(
      padding: EdgeInsets.only(top: 10, left: 16, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: custom_widget.WorkoutTitletWidget(name,Colors.white),
      ),
    ),
            Padding(
              padding: EdgeInsets.all(16.0), // Adjust padding as needed
              child: Container(
                height: 200, // Set the height of the image
                width: MediaQuery.of(context).size.width,
                  child: Image.asset('images/jumpingJacks.jpg')

              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16, bottom: 10,right:16),
              child: Row(
                children: [
                  Expanded(
                    child: custom_widget.WorkoutTitletWidget("Duration", Color(0xFF0dbab4)), // Text on the left
                  ),
                  custom_widget.WorkoutTitletWidget(widget.duration.toString(), Color(0xFF0dbab4)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTitletWidget("Description",Color(0xFF0dbab4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only( left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTexttWidget(description,14),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTitletWidget("TARGETED MUSCLES",Color(0xFF0dbab4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,bottom:98),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.WorkoutTexttWidget(target,14),
              ),
            ),

            Divider(), // Divider at the end
            Padding(
            padding: EdgeInsets.only( left: 16,right: 14),// Add some space between the divider and text
            child:Row(
              children: [
                Expanded(
                  child: custom_widget.WorkoutTexttWidget("Sets Remaining: $remainingCount",20), // Text on the left
                ),

                ElevatedButton(
                  onPressed: () async {decrementCount();},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
                    fixedSize: MaterialStateProperty.all<Size>(const Size(180, 50)),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Border radius
                        );
                      },
                    ),
                  ),
                  child: const Text(
                    'FINISH SET',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF2C2A2A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            ),
          ],),
    );
  }
}
