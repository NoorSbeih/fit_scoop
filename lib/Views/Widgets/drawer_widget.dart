import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:fit_scoop/Models/bodyMetricsSingleton.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Models/user_singleton.dart';
import 'package:fit_scoop/Views/Screens/Equipments/equipment_sceen.dart';
import 'package:fit_scoop/Views/Screens/Update/femaleGoalsUpdate.dart';
import 'package:fit_scoop/Views/Screens/Update/goalsUpdate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/authentication_controller.dart';
import '../Screens/Update/gymType.dart';
import '../Screens/Update/maleGoalsUpdate.dart';
import '../Screens/Update/weight_HeightUpdate.dart';
import '../Screens/login_screen.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String typeOfPlace = "";
  String equipments="";
  String goal="";
  String gender="";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
        BodyMetrics metrics = singleton.getMetrices();
        typeOfPlace=metrics.gymType;
        goal=metrics.fitnessGoal;
        gender=metrics.gender;
        print(gender);
        UserSingleton usersingleton = UserSingleton.getInstance();
        User_model user = usersingleton.getUser();
        equipments=user.savedEquipmentIds.length.toString();

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

                    GestureDetector(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  EquipmentPage(
                              onUpdateEquipments: (newType) {
                                setState(() {
                                  equipments=newType;
                                 });
                                },
                            ),
                          ),
                        );
                      },
                      child: CustomUnderlineText(
                      text: 'AVAILABLE EQUIPMENT: ${equipments} SELECTED',

                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),
                    ),


                    SizedBox(height: 10),
                   GestureDetector(
                  onTap: () {
                    // Navigate to a new page when the text is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GymType(
                          onUpdateGymType: (newType) {
                          setState(() {
                            metrics.gymType = newType;
                            typeOfPlace=metrics.gymType;

                          });
                        },
                        ),
                      ),
                    );
                  },
                    child:CustomUnderlineText(
                      text: 'GYM TYPE: ${typeOfPlace}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),
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

                GestureDetector(
                  onTap: () {
                    // Navigate to a new page when the text is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Weight_HeightUpdate(
                          onUpdateWeightHeight: (weight,height) {
                            setState(() {
                              metrics.weight = weight;
                            });
                          },
                        ),
                      ),
                    );
                  },
                   child: CustomUnderlineText(
                      text: 'Weight: ${metrics.weight}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),
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

                GestureDetector(
                  onTap: () {
                    if(gender=="Female"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => femaleGoalsUpdate(
                          onUpdateGoal: (goal) {
                            setState(() {
                              metrics.fitnessGoal= goal;
                              goal=metrics.fitnessGoal;
                            });
                          },
                        ),
                      ),
                    );
                    }

                    else{
                      Navigator.push(
                          context,
                      MaterialPageRoute(
                        builder: (context) => maleGoalsUpdate(
                          onUpdateGoal: (goal) {
                            setState(() {
                              metrics.fitnessGoal= goal;
                              goal=metrics.fitnessGoal;
                            });
                          },
                        ),
                      ),
                      );
                    }
                  },

                    child:CustomUnderlineText(
                      text: 'Goal: ${goal}',
                      fontSize: 20,
                      textColor: Colors.white,
                      underlineColor: Colors.grey,
                      underlinePadding: 2.0,
                      underlineThickness: 2.0,
                    ),
                ),

                    SizedBox(height: 10),
                    // CustomUnderlineText(
                    //   text: 'Training Days: ${metrics.workoutSchedule
                    //       .length} Selected',
                    //   fontSize: 20,
                    //   textColor: Colors.white,
                    //   underlineColor: Colors.grey,
                    //   underlinePadding: 2.0,
                    //   underlineThickness: 2.0,
                    // ),

                    // SizedBox(height: 10),
                    // CustomUnderlineText(
                    //   text: 'UNIT OF MEASURE:${metrics.unitOfMeasure}',
                    //   fontSize: 20,
                    //   textColor: Colors.white,
                    //   underlineColor: Colors.grey,
                    //   underlinePadding: 2.0,
                    //   underlineThickness: 2.0,
                    // ),
                  ],
                ),
              ),
              Center(
              child:Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: 200, // Set the width of the Container
                height: 50, // Set the height of the Container
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red, width: 0),
                ),
                child:Center(
         child:ListTile(
                  leading: Icon(Icons.logout, color: Colors.black),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
             onTap: () async {
               try {
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                 await sharedPreferences.clear(); // Clear all shared preferences
                 print("Shared preferences cleared");
               } catch (e) {
                 // Handle error if needed
                 print("Error clearing shared preferences: $e");
               }
               Navigator.of(context).pop();
               AuthController controller=AuthController();
               controller.logout(context);
               Navigator.of(context).pushReplacement(
                 MaterialPageRoute(builder: (context) => Login()), // Navigate to the login screen
               );
             }

         ),
                ),
              ),
              ),

            ],
          ),
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

