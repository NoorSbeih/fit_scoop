import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:input_slider/input_slider.dart';

import 'goals_screen.dart';

class Page3 extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: RegisterPage3(),
    );
  }
}


class RegisterPage3 extends StatefulWidget {
  static double currentValue=50 ;
  RegisterPage3();


  @override
  State<RegisterPage3> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage3> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF2C2A2A),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(top:10,left:16,bottom:10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: custom_widget.startTextWidget("Body Fat Percentage"),
          ),

        ),
        Padding(
          padding: const EdgeInsets.only(bottom:60.0,left:16,right:16),
          child: Align(
            alignment: Alignment.centerLeft,
            child:custom_widget.customTextWidget("Your body fat percentage helps us accurately determine your body type and give you the most fitting workout schedule.",15),
          )

        ),
        Padding(
          padding: const EdgeInsets.only(left: 23.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                custom_widget.customTextWidget("Body Fat %",20),
                SizedBox(width: 200,),
                Text(
                      "${RegisterPage3.currentValue.round()}%",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),

              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child:Align(
              alignment: Alignment.centerLeft,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor:  const Color(0xFF0FFA466),
                    inactiveTrackColor:  const Color(0xFF04d4d4d),
                    thumbColor:  const Color(0xFF0FE8040),
                    overlayColor:  const Color(0xFF0FF954D).withAlpha(32),
                    valueIndicatorColor: const Color(0xFF0FF954D),
                  ),
                  child: Slider(
                    value: RegisterPage3.currentValue,
                    min: 0.0,
                    max: 50.0,
                    onChanged: (newValue) {
                      setState(() {
                        RegisterPage3.currentValue = newValue;
                      });
                    },
                  ),
                )

            ),
        ),


      ],
    ),
  );

  }
}