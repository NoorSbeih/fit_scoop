import 'package:fit_scoop/Controllers/body_metrics_controller.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Views/Widgets/card_widget.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../../../Controllers/user_controller.dart';
import '../../../Models/bodyMetricsSingleton.dart';
import '../../../Models/user_singleton.dart';
import '../main_page_screen.dart';


class GymType extends StatefulWidget {
  final Function(String) onUpdateGymType;
  GymType({Key? key, required this.onUpdateGymType}) : super(key: key);

  @override
   createState() => _gymTypeState();
}

class _gymTypeState extends State<GymType> {

  String typeOfPlace="";

  @override
  void initState() {
    super.initState();
    BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
    BodyMetrics metrics = singleton.getMetrices();
    typeOfPlace=metrics.gymType;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    backgroundColor: const Color(0xFF2C2A2A),
        appBar: AppBar(
          backgroundColor: Color(0xFF2C2A2A),
          iconTheme: const IconThemeData(
            color: Color(0xFF0dbab4), // Change the drawer icon color here
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:16,top:10,bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: custom_widget.startTextWidget(""),
                ),

              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                  custom_widget.customTextWidget(
                      "Choose what type of place you go to in order to exercise", 15),

                ), // Add padding from the bottom only

              ),

              Align(
                alignment: Alignment.centerLeft,
                child:cardWidget("Large gym","A gym that includes most equipment needed."),
              ),


              Align(
                alignment: Alignment.centerLeft,
                child:cardWidget("Small gym","small gym that has a limited amount of equipment that just get the job done."),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child:cardWidget("Home","Work-out at home with every limited equipment such as dumbbells,pull-up bars,etc."),
              ),


              Align(
                alignment: Alignment.centerLeft,
                child:cardWidget("Bodyweight training","Work-out with little to no equipment with exercises that use your bodyweight."),
              ),


            ]
        )
    );
  }
  Widget cardWidget(String title, String description) {
    bool isSelected= typeOfPlace== title;

    return GestureDetector(
      onTap: () {
        setState(() {
          BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
          BodyMetrics metrics = singleton.getMetrices();
          typeOfPlace= title;
          widget.onUpdateGymType(title);
          BodyMetricsController controller=BodyMetricsController();
          UserSingleton userSingleton = UserSingleton.getInstance();
          User_model user = userSingleton.getUser();
          metrics.gymType=title;
          controller.updateBodyMetrics(user.bodyMetrics!,metrics);
          Navigator.pop(context);
        });

      },
      child: card_widget.customcardWidget(
        title,
        description,
        isSelected,
      ),
    );
  }

}