import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:input_slider/input_slider.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage3(),
    );
  }
}

class RegisterPage3 extends StatefulWidget {
  static double currentValue = 12;

  RegisterPage3();

  @override
  State<RegisterPage3> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage3> {
  late Map<String, String> imagePaths;

  @override
  void initState() {
    super.initState();

    imagePaths = {
      'Underweight': 'images/underweight.JPG',
      'Normal': 'images/normal.JPG',
      'Overweight': 'images/overweight.JPG',
      'Obesity': 'images/obesity.JPG',
      'Extreme Obesity': 'images/extremeobesity.JPG',
    };
  }

  String getBodyType(double value) {
    if (value <= 8) {
      return 'Underweight';
    } else if (value <= 12) {
      return 'Normal';
    } else if (value <= 15) {
      return 'Overweight';
    } else if (value <= 25) {
      return 'Obesity';
    } else {
      return 'Extreme Obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2A2A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.startTextWidget("Body Fat Percentage"),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 40.0, left: 16, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.customTextWidget(
                    "Your body fat percentage helps us accurately determine your body type and give you the most fitting workout schedule.",
                    18),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 23.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  custom_widget.customTextWidget("Body Fat %: ", 20),
                  Text(
                  '${RegisterPage3.currentValue.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

    // Padding(
    // padding: const EdgeInsets.only(top:25),
    // child: Align(
    // alignment: Alignment.center,
    //       child:
    //       Image.asset(
    //         imagePaths[getBodyType(RegisterPage3.currentValue)]!,
    //         fit: BoxFit.contain,
    //         width: 250, // Adjust width as needed
    //         height: 250, // Adjust height as needed
    //       ),
    // ),
    // ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFF0dbab4),
                  inactiveTrackColor: const Color(0xFF04d4d4d),
                  thumbColor: const Color(0xFF00DBAB4),
                  overlayColor: const Color(0xFF0FF954D).withAlpha(32),
                  valueIndicatorColor: const Color(0xFF0FF954D),
                ),
                child: Slider(
                  value: RegisterPage3.currentValue,
                  min: 5,
                  max: 35,
                  onChanged: (newValue) {
                    setState(() {
                      RegisterPage3.currentValue = newValue;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
