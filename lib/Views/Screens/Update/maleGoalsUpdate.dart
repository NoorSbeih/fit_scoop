import 'package:fit_scoop/Views/Widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../../../Controllers/body_metrics_controller.dart';
import '../../../Models/bodyMetricsSingleton.dart';
import '../../../Models/body_metrics_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';


class maleGoalsUpdate extends StatefulWidget {
  final Function(String) onUpdateGoal;
  const maleGoalsUpdate({Key? key,required this.onUpdateGoal}) : super(key: key);
  @override
  State<maleGoalsUpdate> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<maleGoalsUpdate> {
  String selectedGoal = '';
  @override
  void initState() {
    super.initState();
    BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
    BodyMetrics metrics = singleton.getMetrices();
    selectedGoal=metrics.fitnessGoal;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2C2A2A),
          iconTheme: const IconThemeData(
            color: Color(0xFF0dbab4), // Change the drawer icon color here
          ),

        ),

        backgroundColor: const Color(0xFF2C2A2A),
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

            ]
        )
    );
  }
  // Widget cardWidget(String title, String description) {
  //   String selectedGoal = RegisterPage4M.selectedGoal;
  //
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         RegisterPage4M.selectedGoal = title;
  //       });
  //     },
  //     child: card_widget.customcardWidget(
  //       title,
  //       description,
  //       title == selectedGoal,
  //     ),
  //   );
  // }

  Widget cardWidget(String title, String description) {

    return GestureDetector(
      onTap: () {
        setState(() {
          BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
          BodyMetrics metrics = singleton.getMetrices();
          selectedGoal= title;
          widget.onUpdateGoal(title);
          BodyMetricsController controller=BodyMetricsController();
          UserSingleton userSingleton = UserSingleton.getInstance();
          User_model user = userSingleton.getUser();
          metrics.fitnessGoal=title;
          controller.updateBodyMetrics(user.bodyMetrics!,metrics);
          Navigator.pop(context);
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

