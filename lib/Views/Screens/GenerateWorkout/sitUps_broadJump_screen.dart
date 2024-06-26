import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

import '../../../Controllers/body_metrics_controller.dart';
import '../../../Models/body_metrics_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Services/tensorflow_service.dart';
import 'diastolic_systolic_screen.dart';

class SitupsBroadjumpScreen extends StatefulWidget {

  const SitupsBroadjumpScreen({Key? key}) : super(key: key);


  @override
  State<SitupsBroadjumpScreen> createState() => _SitupsBroadjumpScreen();
}

class _SitupsBroadjumpScreen extends State<SitupsBroadjumpScreen> {
  TensorFlowService predictTensor=TensorFlowService();
  late TextEditingController selectedSitUp = TextEditingController();
  late TextEditingController selectedBroadJump= TextEditingController();
  @override
  void initState() {
    super.initState();

    // Initialize text controllers or perform other setup if needed
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
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.startTextWidget("Sit Up and Broad Jump"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0, left: 16, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.customTextWidget(
                  "By measuring broad jump and sit-up count, we tailor workouts for improved lower body power and core strength.",
                  15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    text: "Sit Up Count",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: _buildSitUpPicker(context),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    text: "Broad Jump",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: _buildBroadJumpPicker(context),
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
                  setState(()  {
                    metrics?.diastolic=DiastolicSystolicScreen.diastolic;
                    metrics?.systolic=DiastolicSystolicScreen.systolic;
                    metrics?.sitUpCount=double.parse(selectedSitUp.text);
                    metrics?.broadJumpCm=double.parse(selectedBroadJump.text);
                  });
                  double age=calculateAge(metrics!.birthDate);

                    int x= await predictTensor.predict(age:age,gender:metrics!.gender,
                    height :metrics.height,
                    weight:metrics.weight,
                        bodyFat: metrics.bodyFat,
                        diastolic :DiastolicSystolicScreen.diastolic,
                        systolic:DiastolicSystolicScreen.systolic,
                        sitUps:double.parse(selectedSitUp.text),
                    broadJump:double.parse(selectedBroadJump.text)
                    );
                    print("predictttt");
                    print(x);
                  metrics.performanceLevel=x;
                   bodyMetricsController.updateBodyMetrics(user.bodyMetrics, metrics!);

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
          ],
        ),
      ),
    );
  }

  Widget _buildSitUpPicker(BuildContext context) {
    return custom_widget.textFormFieldWidget(
      "Select Sit Up Count",
      selectedSitUp,
      context,
      "Count",
      _buildNumberPickerInDia,
    );
  }

  Widget _buildBroadJumpPicker(BuildContext context) {
    return custom_widget.textFormFieldWidget(
      "Select Broad Jump",
      selectedBroadJump,
      context,
      "cm",
      _buildNumberPickerInSys,
    );
  }

  Widget _buildNumberPickerInDia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(80, "", 25, 80, 120, selectedSitUp),
      ],
    );
  }

  Widget _buildNumberPickerInSys() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(80, "cm", 25, 80, 120, selectedBroadJump),
      ],
    );
  }

  Widget _buildNumberPicker(int x, String text, int minValue, int maxValue, double itemWidth, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return NumberPicker(
              value: x,
              minValue: minValue,
              maxValue: maxValue,
              itemHeight: 50,
              itemWidth: itemWidth,
              onChanged: (value) {
                setState(() {
                  x = value;
                  controller.text = value.toString(); // Update the text in the controller
                });
              },
              selectedTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
              axis: Axis.vertical,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white, width: 3),
                  bottom: BorderSide(color: Colors.white, width: 3),
                ),
              ),
            );
          },
        ),
        custom_widget.customTextWidget(text, 15),
      ],
    );
  }
  double calculateAge(String dateString) {
    String dateFormat = "dd/MM/yyyy";
    DateFormat format = DateFormat(dateFormat);
    DateTime birthDate = format.parse(dateString);
    DateTime today = DateTime.now();
    double age = (today.year - birthDate.year).toDouble();
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}

