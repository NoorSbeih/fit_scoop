

import 'package:fit_scoop/Controllers/login_controller.dart';
import 'package:fit_scoop/Views/Screens/main_page_screen.dart';
import 'package:fit_scoop/Views/Screens/register_screen.dart';
import 'package:fit_scoop/Views/Screens/Registration%20pages/select_day_screen.dart';
import 'package:fit_scoop/Views/Screens/Registration%20pages/type_of_place_screen.dart';

import 'package:fit_scoop/Views/Screens/Workout/current_workout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controllers/body_metrics_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Services/Database Services/body_metrics_service.dart';
import '../Equipments/equipment_sceen.dart';
import 'Female_goals_screen.dart';
import 'Male_goals_screen.dart';
import 'birth_gender_screen.dart';
import 'body_fat_screen.dart';
import 'equipment_screen.dart';
import 'height_weight_screen.dart';
import 'package:fit_scoop/Controllers/register_controller.dart';
import '/Models/body_metrics_model.dart' as model;
 class CustomPageView extends StatefulWidget {
   static String Gender="";
   static String Goal="";
   @override
   _CustomPageViewState createState() => _CustomPageViewState();
 }

class _CustomPageViewState extends State<CustomPageView> {
  final controller = PageController();
  int currentPageIndex = 0;

  late String unit="";

  List<String> selectedEquipmentIds = [];

   @override
   void initState() {
     super.initState();
     controller.addListener(() {
       setState(() {
         currentPageIndex = controller.page!.round();
       });
     });
    _loadPreferences();
   }
  void _loadPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? unitOfMeasure = sharedPreferences.getString('unitOfMeasure');
    String? gender = sharedPreferences.getString('Gender');


    setState(() {
     //gender = sharedPreferences.getString('Gender');
      unit = unitOfMeasure ?? ""; // Assign default value if unitOfMeasure is null
      CustomPageView.Gender = gender ?? ""; // Assign default value if gender is null
    });
  }

  bool isDataFilled_Page1() {
    return RegisterPage1.selectedgender.isNotEmpty && RegisterPage1.formateddate.isNotEmpty;
  }
  bool isDataFilled2() {
    return RegisterPage2.heightresult.toString().isNotEmpty && RegisterPage2.weightresult.toString().isNotEmpty;
  }


  void nextPage(BuildContext context) {
    if (currentPageIndex < 5) {
        currentPageIndex = controller.page!.round();
        print(currentPageIndex);

        controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        _loadPreferences();
    }}

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         backgroundColor: Color(0xFF2C2A2A),
         body: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             if (currentPageIndex > 0)
           AppBar(
             backgroundColor: Colors.transparent, // Optional: To make the app bar transparent
             elevation: 0,
           leading: IconButton(
           onPressed: () {
         if (currentPageIndex > 0) {
           controller.previousPage(
             duration: Duration(milliseconds: 300),
             curve: Curves.ease,
           );
         }
       },
       icon: Icon(Icons.arrow_back),
       color: Color(0xFF0dbab4),
       ),
           ),
             SizedBox(
               height: 600,
               child: PageView(
                 controller: controller,
                 physics:  NeverScrollableScrollPhysics(),
                 children: [
                   RegisterPage1(),
                   RegisterPage2(),
                   RegisterPage3(),
                   CustomPageView.Gender == 'Male' ? RegisterPage4M() : RegisterPage4F(),
                   RegisterPage5(),
                 Page6(
                 onEquipmentSelected: (selectedEquipmentIds) {
                   setState(() {
                     this.selectedEquipmentIds = selectedEquipmentIds;
                   });
                 },
                 ),
                 ],
               ),
             ),

             ElevatedButton(

              onPressed: () {
                print(currentPageIndex);
                if (currentPageIndex == 0  && !isDataFilled_Page1()) {
                   showError(context);
                       }
                else if (currentPageIndex >= 5 ) {
                 // if(!RegisterPage6.daysSelected.isEmpty){
                   finishRegistration(context);
                //}
              }
                else if (currentPageIndex == 1 && !isDataFilled2()) {
                    showError(context);

                }

                else if (currentPageIndex == 3 && CustomPageView.Gender.compareTo("Male")==0) {

                  if ( RegisterPage4M.selectedGoal.isEmpty) {
                    showError(context);
                  }else{
                    CustomPageView.Goal=RegisterPage4M.selectedGoal;
                    nextPage(context);
                  }
                }
                else if (currentPageIndex == 3 && CustomPageView.Gender.compareTo("Female")==0) {
                  if ( RegisterPage4F.selectedGoal.isEmpty) {
                    showError(context);
                  }else{
                    CustomPageView.Goal=RegisterPage4F.selectedGoal;
                    nextPage(context);
                  }
                }
                else if (currentPageIndex == 4 && RegisterPage5.typeOfPlace.isEmpty) {
                    showError(context);
                }

                else if (currentPageIndex == 5 && selectedEquipmentIds.isEmpty) {
                   showError(context);
                    finishRegistration(context);
                  }
                else  {
                  nextPage(context);
                }
              },
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all<Color>(
                     const Color(0xFF00DBAB4)),
                 fixedSize: MaterialStateProperty.all<Size>(
                     const Size(190, 50)),
                 shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                       (Set<MaterialState> states) {
                     return RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(
                           10.0), // Border radius
                     );

                   },
                 ),
               ),


               child:  Text(
                 currentPageIndex < 5 ? 'Next' : 'Finish',
                 style:
                 const TextStyle(
                   fontSize: 20,
                   color: Colors.white,

                 ),),
             ),


           ],

         ),

       );
     }

  Future<void> finishRegistration(BuildContext context) async {
    List<String> workoutSchedule=[];
    //Page6.saveSelectedEquipment();
    UserController userController= UserController();

    userController.saveEquipments(RegisterController.userId, selectedEquipmentIds);
    BodyMetricsController _bodyMetricController=new BodyMetricsController();
    String id=RegisterController.userId;
    String dateString = RegisterPage1.formateddate;
    model.BodyMetrics bodyMetrics= model.BodyMetrics(userId:id,height: RegisterPage2.heightresult,weight: RegisterPage2.weightresult,birthDate: dateString ,
    bodyFat: RegisterPage3.currentValue,gender: RegisterPage1.selectedgender,fitnessGoal:CustomPageView.Goal,gymType: RegisterPage5.typeOfPlace, CurrentDay:0,workoutSchedule: workoutSchedule,unitOfMeasure: unit);
    await _bodyMetricController.addBodyMetrics(bodyMetrics);

   RegisterController controller=RegisterController();
    controller.getUserBodyMetric(id).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }).catchError((error) {
      print('Error navigating to HomePage: $error');
    });
  }

  void showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all required fields.'),
      ),
    );
  }
}




