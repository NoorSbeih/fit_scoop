import 'package:fit_scoop/Models/bodyMetricsSingleton.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        SharedPreferences sharedPreferences = snapshot.data!;
        String? unitOfMeasure = sharedPreferences.getString('unitOfMeasure');
        BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
        BodyMetrics metrics = singleton.getMetrices();


        return Drawer(
          backgroundColor: Color(0xFF2C2A2A),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
               const DrawerHeader(
                child: Text(
                  'FitScoop',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                      fontFamily: 'BebasNeue')
                  ),
                ),
              ListTile(
                title: const Text(
                  'GYM EQUIPMENT',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'BebasNeue'),
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    const CustomUnderlineText(
                      text: 'AVAILABLE EQUIPMENT: 5 SELECTED',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),


                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'GYM TYPE: ${metrics.gymType}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),

                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'UNIT OF MEASURE: ${unitOfMeasure}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'BODY METRICS',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'BebasNeue'),
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'Weight: ${metrics.weight}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),


                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'Height: ${metrics.height}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),

                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'BODY FAT PERCENTAGE: ${metrics.bodyFat}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),
                  ],
                ),
              ),

              ListTile(
                title: const Text(
                  'PREFERENCES',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'BebasNeue'),
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'Goal: ${metrics.gymType}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),


                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'Training Days: ${metrics.workoutSchedule
                          .length} Selected',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),

                    SizedBox(height: 10),
                    CustomUnderlineText(
                      text: 'UNIT OF MEASURE:${unitOfMeasure}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.contact_page),
                title: Text('Contact'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


class CustomUnderlineText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final Color underlineColor;
  final double underlinePadding;
  final double underlineThickness;

  const CustomUnderlineText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.underlineColor,
    required this.underlinePadding,
    required this.underlineThickness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Split the text into two parts: the word and the value
    final parts = text.split(':');
    final word = parts[0];
    final value = parts.sublist(1).join(':').trim();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: underlinePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                word,
                style: TextStyle(
                  color: Colors.white, // Word color is white
                  fontSize: fontSize,
                  fontFamily: 'BebasNeue',
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color:  Color(0xFF0dbab4), // Value color is red
                  fontSize: fontSize,
                  fontFamily: 'BebasNeue',
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: underlineThickness,
            color: underlineColor,
          ),
        ),
      ],
    );
  }
}

