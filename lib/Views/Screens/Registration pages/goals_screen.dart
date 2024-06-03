import 'package:fit_scoop/Views/Widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
class Page4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: RegisterPage4(),
    );
  }
}


class RegisterPage4 extends StatefulWidget {
  static String selectedGoal = '';
  const RegisterPage4({Key? key}) : super(key: key);
  @override
  State<RegisterPage4> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage4> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

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
                    child:cardWidget("Weight loss","Primarily focus on burning fat and losing weight."),
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
  Widget cardWidget(String title, String description) {
    String selectedGoal = RegisterPage4.selectedGoal;

    return GestureDetector(
      onTap: () {
        setState(() {
          RegisterPage4.selectedGoal = title;
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

