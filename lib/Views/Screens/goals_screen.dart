import 'package:fit_scoop/Views/Widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
class Page4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage4(),
    );
  }
}


class RegisterPage4 extends StatefulWidget {

  const RegisterPage4({Key? key}) : super(key: key);
  @override
  State<RegisterPage4> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage4> {
List<String> _selectedGoals = [];
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
                padding: const EdgeInsets.only(top:30,right:25,bottom:10),
                child: custom_widget.skipButtom(),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: custom_widget.startTextWidget("Goals"),
                ),

              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 16),
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
   bool isSelected = _selectedGoals.contains(title);

   return GestureDetector(
     onTap: () {
       setState(() {
         if (isSelected) {
           _selectedGoals.remove(title);
         } else {
           _selectedGoals.add(title);
         }
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

