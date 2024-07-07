
import 'package:fit_scoop/Models/bodyMetricsSingleton.dart';
import 'package:fit_scoop/Models/body_metrics_model.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Models/user_singleton.dart';
import 'package:fit_scoop/Views/Screens/Equipments/equipment_sceen.dart';
import 'package:fit_scoop/Views/Screens/add/addExercise.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controllers/authentication_controller.dart';
import '../Screens/GenerateWorkout/diastolic_systolic_screen.dart';
import '../Screens/Update/bodyFatUpdate.dart';
import '../Screens/Update/gymType.dart';
import '../Screens/Update/unitOfMeasureUpdate.dart';
import '../Screens/Update/weight_HeightUpdate.dart';
import '../Screens/home_page_screen.dart';
import '../Screens/login_screen.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String typeOfPlace = "";
  String equipments = "";
  String goal = "";
  String gender = "";
  double bodyfat = 0;

  @override
  void initState() {
    super.initState();
  }

  logut() async {
    AuthController controller = AuthController();
    addExercise.exercises.clear();
    await controller.logout(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MyHomePage(title: '',)),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
    BodyMetrics metrics = singleton.getMetrices();
    typeOfPlace = metrics.gymType;
    goal = metrics.fitnessGoal;
    gender = metrics.gender;
    //print(gender);
    UserSingleton usersingleton = UserSingleton.getInstance();
    User_model user = usersingleton.getUser();
    equipments = user.savedEquipmentIds.length.toString();
    bodyfat = metrics.bodyFat;

    return Drawer(
      backgroundColor: Color(0xFF2C2A2A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 200.0,
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Image.asset(
                    'images/FITscoop2.png',
                    height: 1000, // Adjust the height as needed
                    width: 1000,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const Divider( // Add a Divider below the image
                  color: Colors.grey,
                  thickness: 2,
                  height: 20,
                ),

              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 275,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF0dbab4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 0),
              ),
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.fitness_center, color: Color(0xFF2C2A2A)),
                  title: const Text(
                    'GENERATE WORKOUT',
                    style: TextStyle(
                      color: Color(0xFF2C2A2A),
                      fontSize: 25,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiastolicSystolicScreen()),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          ListTile(
            title: const Text(
              'GYM EQUIPMENT',
              style: TextStyle(
                  color: Colors.grey, fontSize: 25, fontFamily: 'BebasNeue'),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EquipmentPage(
                          onUpdateEquipments: (newType) {
                            setState(() {
                              equipments = newType;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: CustomUnderlineText(
                    text: 'AVAILABLE EQUIPMENT: ${equipments} SELECTED',
                    fontSize: 22,
                    textColor: Colors.white,
                    underlineColor: Colors.grey,
                    underlinePadding: 2.0,
                    underlineThickness: 2.0,
                  ),
                ),
                SizedBox(height: 20),
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
                              typeOfPlace = metrics.gymType;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: CustomUnderlineText(
                    text: 'GYM TYPE: ${typeOfPlace}',
                    fontSize: 22,
                    textColor: Colors.white,
                    underlineColor: Colors.grey,
                    underlinePadding: 2.0,
                    underlineThickness: 2.0,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'BODY METRICS',
              style: TextStyle(
                  color: Colors.grey, fontSize: 25, fontFamily: 'BebasNeue'),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to a new page when the text is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Weight_HeightUpdate(
                          initialWeight: metrics.weight,
                          initialHeight: metrics.height,
                          onUpdateWeightHeight: (weight, height) {
                            setState(() {
                              metrics.weight = weight;
                              metrics.height = height;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: CustomUnderlineText(
                    text: 'Weight: ${metrics.weight.toStringAsFixed(2)}',
                    fontSize: 22,
                    textColor: Colors.white,
                    underlineColor: Colors.grey,
                    underlinePadding: 2.0,
                    underlineThickness: 2.0,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navigate to a new page when the text is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Weight_HeightUpdate(
                          initialWeight: metrics.weight,
                          initialHeight: metrics.height,
                          onUpdateWeightHeight: (weight, height) {
                            setState(() {
                              metrics.weight = weight;
                              metrics.height = height;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: CustomUnderlineText(
                    text: 'Height: ${metrics.height.toStringAsFixed(2)}',
                    fontSize: 22,
                    textColor: Colors.white,
                    underlineColor: Colors.grey,
                    underlinePadding: 2.0,
                    underlineThickness: 2.0,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BodyfatUpdate(
                          onUpdateBodyFat: (bodyfat) {
                            setState(() {
                              metrics.bodyFat = bodyfat;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: CustomUnderlineText(
                    text:
                        'BODY FAT PERCENTAGE: ${metrics.bodyFat.toStringAsFixed(2)}',
                    fontSize: 22,
                    textColor: Colors.white,
                    underlineColor: Colors.grey,
                    underlinePadding: 2.0,
                    underlineThickness: 2.0,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'PREFERENCES',
              style: TextStyle(
                  color: Colors.grey, fontSize: 25, fontFamily: 'BebasNeue'),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to a new page when the text is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UnitOfMeasure(
                          onUpdateUnit: (unit) {
                            setState(() {
                              metrics.unitOfMeasure = unit;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: CustomUnderlineText(
                    text: 'UNIT OF MEASURE:${metrics.unitOfMeasure}',
                    fontSize: 22,
                    textColor: Colors.white,
                    underlineColor: Colors.grey,
                    underlinePadding: 2.0,
                    underlineThickness: 2.0,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 2),
              width: 275,
              // Set the width of the Container
              height: 50,
              // Set the height of the Container
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 0),
              ),
              child: Center(
                child: ListTile(
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
                    logut();
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
                  color: Color(0xFF0dbab4), // Value color is red
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
