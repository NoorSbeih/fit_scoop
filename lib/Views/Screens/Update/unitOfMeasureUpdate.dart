import 'package:fit_scoop/Controllers/body_metrics_controller.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Views/Widgets/card_widget.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controllers/user_controller.dart';
import '../../../Models/bodyMetricsSingleton.dart';
import '../../../Models/user_singleton.dart';
import '../main_page_screen.dart';

class UnitOfMeasure extends StatefulWidget {
  final Function(String) onUpdateUnit;

  UnitOfMeasure({Key? key, required this.onUpdateUnit}) : super(key: key);

  @override
  createState() => _unitState();
}

class _unitState extends State<UnitOfMeasure> {
  String _selectedUnitMeasure = "";

  @override
  void initState() {
    super.initState();
    BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
    BodyMetrics metrics = singleton.getMetrices();
    _selectedUnitMeasure = metrics.unitOfMeasure;
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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.startTextWidget("Unit of measure"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, left: 16, right: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.customTextWidget(
                  "Choosing the correct unit of measure for weight and height is essential "
                  "for precise calculations and a better understanding of your fitness metrics",
                  18),
            ), // Add padding from the bottom only
          ),
          Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                children: [
                  Radio(
                    value: "metric",
                    groupValue: _selectedUnitMeasure,
                    onChanged: (value) async {
                      setState(() {
                        _selectedUnitMeasure = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fillColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color(0xFF0dbab4); // Change the selected color
                        }
                        return Colors.white; // Change the unselected color
                      },
                    ),
                  ),

                  const Text(
                    'Metric',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(width: 20), // Adjust as needed for spacing
                  Radio(
                    value: "imperial",
                    groupValue: _selectedUnitMeasure,
                    onChanged: (value) async {
                      setState(() {
                        _selectedUnitMeasure = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fillColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color(0xFF0dbab4); // Change the selected color
                        }
                        return Colors.white;
                      },
                    ),
                  ),

                  const Text(
                    'Imperial',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              )),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
              BodyMetrics metrics = singleton.getMetrices();
              BodyMetricsController controller = BodyMetricsController();
              UserSingleton userSingleton = UserSingleton.getInstance();
              User_model user = userSingleton.getUser();
               metrics.unitOfMeasure = _selectedUnitMeasure;
               widget.onUpdateUnit(_selectedUnitMeasure);
              controller.updateBodyMetrics(user.bodyMetrics!, metrics);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF0dbab4)), // Change color to blue
              fixedSize: MaterialStateProperty.all<Size>(const Size(250, 30)),
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (Set<MaterialState> states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0), // Border radius
                  );
                },
              ),
            ),
            child: const Text(
              'UPDATE',
              style: TextStyle(fontSize: 20, color: Color(0xFF2C2A2A)),
            ),
          ),
        ],
      ),
    );
  }
}
