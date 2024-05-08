

import 'package:fit_scoop/Views/Screens/register_screen.dart';
import 'package:fit_scoop/Views/Screens/select_day_screen.dart';
import 'package:fit_scoop/Views/Screens/test_screen.dart';
import 'package:fit_scoop/Views/Screens/type_of_place_screen.dart';
import 'package:fit_scoop/Views/Screens/goals_screen.dart';
import 'package:fit_scoop/Views/Screens/current_workout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Controllers/body_metrics_controller.dart';
import '../../Services/Database Services/body_metrics_service.dart';
import 'birth_gender_screen.dart';
import 'body_fat_screen.dart';
import 'goals_screen.dart';
import 'height_weight_screen.dart';
import 'package:fit_scoop/Controllers/register_controller.dart';
import '/Models/body_metrics_model.dart' as model;
 class CustomPageView extends StatefulWidget {
   @override
   _CustomPageViewState createState() => _CustomPageViewState();
 }

class _CustomPageViewState extends State<CustomPageView> {
  final controller = PageController();
  int currentPageIndex = 0;


   @override
   void initState() {
     super.initState();
     controller.addListener(() {
       setState(() {
         currentPageIndex = controller.page!.round();
       });
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
       color: Colors.orange,
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
                   RegisterPage4(),
                   RegisterPage5(),
                   RegisterPage6(),
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
                  if(!RegisterPage6.daysSelected.isEmpty){
                   finishRegistration(context);
                }}
                else if (currentPageIndex == 1 && !isDataFilled2()) {
                    showError(context);

                }
                else if (currentPageIndex == 3 && RegisterPage4.selectedGoals.isEmpty) {
                    showError(context);
                }
                else if (currentPageIndex == 4 && RegisterPage5.typeOfPlace.isEmpty) {
                    showError(context);
                }
                else if (currentPageIndex == 5&& RegisterPage6.daysSelected.isEmpty) {
                   showError(context);
                   // finishRegistration(context);
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
                   color: Color(0xFF2C2A2A),

                 ),),
             ),


           ],

         ),

       );
     }

  void finishRegistration(BuildContext context) {
    List<String> workoutSchedule=[];
    BodyMetricsController _bodyMetricController=new BodyMetricsController();
    String id=RegisterController.userId;
    String dateString = RegisterPage1.formateddate;
 //   List<String> parts = dateString.split('/');
   // String formattedDate = '${parts[2]}-${parts[0]}-${parts[1]}T00:00:00';
   // DateTime dateTime = DateTime.parse(formattedDate);
    model.BodyMetrics bodyMetrics= model.BodyMetrics(userId:id,height: RegisterPage2.heightresult,weight: RegisterPage2.weightresult,birthDate: dateString ,
    bodyFat: RegisterPage3.currentValue,gender: RegisterPage1.selectedgender,fitnessGoal:RegisterPage4.selectedGoals,gymType: RegisterPage5.typeOfPlace,workoutSchedule: workoutSchedule);
    _bodyMetricController.addBodyMetrics(bodyMetrics);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutPagee()), // Replace SecondPage() with the desired page widget
    );
  }


  void showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all required fields.'),
      ),
    );
  }
}




