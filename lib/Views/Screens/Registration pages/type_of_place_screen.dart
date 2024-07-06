import 'package:fit_scoop/Views/Widgets/card_widget.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
class Page5 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage5(),
    );
  }
}


class RegisterPage5 extends StatefulWidget {
  static String typeOfPlace="";
  RegisterPage5();
  @override
  State<RegisterPage5> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage5> {

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
                padding: const EdgeInsets.only(left:16,top:10,bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: custom_widget.startTextWidget("Almost done!"),
                ),

              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:


                  custom_widget.customTextWidget(
                      "Select the type of gym you prefer to exercise in.", 18),

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
    bool isSelected =RegisterPage5.typeOfPlace == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          RegisterPage5.typeOfPlace=title;

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

