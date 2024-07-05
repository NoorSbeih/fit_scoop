
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:fit_scoop/Views/Widgets/card_widget.dart';

import '../../../Controllers/body_metrics_controller.dart';
import '../../../Models/body_metrics_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../WorkoutScheduling/Schedule.dart';

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage4F(),
    );
  }
}

class RegisterPage4F extends StatefulWidget {
  static String selectedGoal = '';

  const RegisterPage4F({Key? key}) : super(key: key);

  @override
  State<RegisterPage4F> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage4F> {
  BodyMetrics? metrics;

  @override
  void initState() {
    super.initState();
    fetchBodyMetrics();
  }

  Future<void> fetchBodyMetrics() async {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();
    String? bodyMetricId = user.bodyMetrics;

    if (bodyMetricId != null) {
      BodyMetricsController bodyMetricsController = BodyMetricsController();
      metrics =
      await bodyMetricsController.fetchBodyMetrics(user.bodyMetrics);
      setState(() {});
    }
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
              padding: const EdgeInsets.only(top: 10, left: 16, bottom: 10),
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
              ),
            ),
            if (metrics != null) ..._buildGoalCards(metrics!.performanceLevel),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (metrics != null) {
                  metrics!.fitnessGoal = RegisterPage4F.selectedGoal;
                  BodyMetricsController bodyMetricsController =
                  BodyMetricsController();
                  UserSingleton userSingleton = UserSingleton.getInstance();
                  bodyMetricsController.updateBodyMetrics(
                      userSingleton.getUser().bodyMetrics!, metrics!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchedulePage(),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
                fixedSize:
                MaterialStateProperty.all<Size>(const Size(190, 50)),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    );
                  },
                ),
              ),
              child: const Text(
                'FINISH',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGoalCards(dynamic performanceLevel) {
    List<Widget> widgets = [];

    widgets.add(_buildCardWidget(
  "Toning/Shaping",
  "Focus on improving muscle definition and achieving a more sculpted appearance.",
      performanceLevel >= 0,
    ));
    widgets.add(_buildCardWidget(
  "Muscle Gain","Focus on progressive resistance training, and adequate rest for effective muscle gain.",
      performanceLevel == 0 || performanceLevel == 1 || performanceLevel == 2,
    ));
    widgets.add(_buildCardWidget(
    "Strength Training","Focus on increasing muscle strength and lifting heavy weights.",
      performanceLevel == 0|| performanceLevel == 1|| performanceLevel == 2 ,
    ));

    return widgets;
  }

  Widget _buildCardWidget(String title, String description, bool isEnabled) {
    String selectedGoal = RegisterPage4F.selectedGoal;
    bool isSelected = title == selectedGoal;


    return GestureDetector(
      onTap: isEnabled
          ? () {
        setState(() {
          RegisterPage4F.selectedGoal = title;
        });
      }
          : null,
      child: Card(
        color: isEnabled ? Color(0xFF2C2A2A) : Colors.grey[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? Colors.white : Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: isEnabled ? Colors.white  : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
