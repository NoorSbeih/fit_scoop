import 'package:fit_scoop/Views/Widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../../../Controllers/body_metrics_controller.dart';
import '../../../Models/body_metrics_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../WorkoutScheduling/Schedule.dart';
class Page4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: RegisterPage4M(),
    );
  }
}


class RegisterPage4M extends StatefulWidget {
  static String selectedGoal = '';
  const RegisterPage4M({Key? key}) : super(key: key);
  @override
  State<RegisterPage4M> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage4M> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
    backgroundColor: const Color(0xFF2C2A2A),
    appBar: AppBar(
    backgroundColor: const Color(0xFF2C2A2A),
    automaticallyImplyLeading: false,
    title: Row(
    children: [
    IconButton(
    icon: const Icon(Icons.arrow_back, color: Color(0xFF0dbab4)),
    onPressed: () {
    Navigator.of(context).pop(); // Close the page
    },
    ),

    ],
    ),
    ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10,left:16,bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: custom_widget.startTextWidget("Goals"),
                ),

              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: custom_widget.customTextWidget(
                      "What is Your Main Goal for Joining FitScoop?", 15),

                ), // Add padding from the bottom only

              ),


              Align(
                alignment: Alignment.centerLeft,
                child:cardWidget("Bodybuilding","Focus on increasing overall muscle mass and decreasing body fat percentage."),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child:cardWidget("Strength Training","Focus on increasing muscle strength and lifting heavy weights."),
              ),


              Align(
                alignment: Alignment.centerLeft,
                child:cardWidget("Powerlifting","Specialized training that focuses on extremely heavy weights and low amount of reps."),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();
    String? bodyMetricId = user.bodyMetrics;
    print( user.bodyMetrics);
    print(user.name);

    BodyMetrics? metrics;
    if (bodyMetricId != null) {
      BodyMetricsController bodyMetricsController = BodyMetricsController();
      metrics = await bodyMetricsController.fetchBodyMetrics(
          user.bodyMetrics);
      metrics?.fitnessGoal=  RegisterPage4M.selectedGoal;
      bodyMetricsController.updateBodyMetrics(user.bodyMetrics, metrics!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  SchedulePage(),
        ),
      );

    }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF0dbab4)), // Change color to blue
                  fixedSize:
                  MaterialStateProperty.all<Size>(   const Size(190, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(5.0), // Border radius
                      );
                    },
                  ),
                ),
                child: const Text(
                  'FINISH',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),

            ]
        )
    )
    );
  }
  Widget cardWidget(String title, String description) {
    String selectedGoal = RegisterPage4M.selectedGoal;

    return GestureDetector(
      onTap: () {
        setState(() {
          RegisterPage4M.selectedGoal = title;
        });
      },
      child: card_widget.customcardWidget(
        title,
        description,
        title == selectedGoal,
      ),
    );
  }


}

