import 'package:fit_scoop/Views/Screens/height_weight_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../../Controllers/register_controller.dart';
import 'birth_gender_screen.dart';

class Goals extends StatelessWidget {
  static String result="";
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:GoalsPage(),
    );
  }
}
class GoalsPage extends StatefulWidget{
  const GoalsPage({Key? key}) : super(key: key);


  @override
  State<GoalsPage> createState() => _GoalsPageState();
}
class _GoalsPageState extends State<GoalsPage> {
  late String birthdate;
  late String gender;

  void initState() {
    super.initState();
    _loadPreferences(); // Load the preference when the widget is initialized
  }

  void _loadPreferences() async {
    RegisterController register=RegisterController();
    register.storeBodyMetrics(RegisterPage1.formateddate,RegisterPage1.selectedgender,RegisterPage2.heightresult,RegisterPage2.weightresult);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2A2A),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.startTextWidget("Goals"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () { _loadPreferences;},  child: Text("Press"),

                ),
              ),
            ),
          ]
      ),
    );
  }
}