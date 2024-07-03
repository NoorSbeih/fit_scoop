import 'package:fit_scoop/Views/Screens/GenerateWorkout/sitUps_broadJump_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

class DiastolicSystolicScreen extends StatefulWidget {
  static late double diastolic;
  static late double systolic;
  const DiastolicSystolicScreen({Key? key}) : super(key: key);

  @override
  State<DiastolicSystolicScreen> createState() => _DiastolicSystolicScreen();
}

class _DiastolicSystolicScreen extends State<DiastolicSystolicScreen> {
  late TextEditingController selectedDiastolic = TextEditingController();
  late TextEditingController selectedSystolic = TextEditingController();
  @override
  void initState() {
    super.initState();
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
                child: custom_widget.startTextWidget("Diastolic and Systolic"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0, left: 16, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: custom_widget.customTextWidget(
                  "Entering your systolic and diastolic blood pressure is essential for generating the best workouts and ensuring they are safe and effective for your heart health.",
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
                    text: "Diastolic",
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
              child: _buildDiastolicPicker(context),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    text: "Systolic",
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
              child: _buildSystolicPicker(context),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (selectedDiastolic.text.isNotEmpty && selectedSystolic.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SitupsBroadjumpScreen(),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF0dbab4)), // Change color to blue
                fixedSize:
                MaterialStateProperty.all<Size>(const Size(190, 50)),
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
                'NEXT',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildDiastolicPicker(BuildContext context) {
    return custom_widget.textFormFieldWidget(
      "Select Diastolic",
      selectedDiastolic,
      context,
      "MM HG",
      _buildNumberPickerInDia,
    );
  }

  Widget _buildSystolicPicker(BuildContext context) {
    return custom_widget.textFormFieldWidget(
      "Select Systolic",
      selectedSystolic,
      context,
      "MM HG",
      _buildNumberPickerInSys,
    );
  }

  Widget _buildNumberPickerInDia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(80, "mm Hg", 80, 120, 80, selectedDiastolic,0),
      ],
    );
  }

  Widget _buildNumberPickerInSys() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(120, "mm Hg", 80, 120, 80, selectedSystolic,1),
      ],
    );
  }

  Widget _buildNumberPicker(int x, String text, int minValue, int maxValue, double itemWidth, TextEditingController controller,int flag) {
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
                  controller.text = value.toString();
                  if(flag==0){
                    DiastolicSystolicScreen.diastolic=value.toDouble();
                  }else{
                    DiastolicSystolicScreen.systolic=value.toDouble();
                  }
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
}

