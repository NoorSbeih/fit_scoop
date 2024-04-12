

import 'package:fit_scoop/Views/Screens/register_screen.dart';
import 'package:fit_scoop/Views/Screens/select_day_screen.dart';
import 'package:fit_scoop/Views/Screens/type_of_place_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'birth_gender_screen.dart';
import 'body_fat_screen.dart';
import 'goals_screen.dart';
import 'height_weight_screen.dart';
 class CustomPageView extends StatelessWidget {
   final controller = PageController();
   int currentPageIndex = 0;

   void nextPage(BuildContext context) {
     currentPageIndex = controller.page!.round();
     print(currentPageIndex);
     controller.nextPage(
       duration: Duration(milliseconds: 300),
       curve: Curves.ease,
     );
   }

   void skipToNextPage() {
     print("fgvfgbfbhh");
     controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
   }



     @override
     Widget build(BuildContext context) {
       return Scaffold(
         backgroundColor: Color(0xFF2C2A2A),
         body: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             SizedBox(
               height: 600,
               child: PageView(
                 controller: controller,
                 children: [
                   RegisterPage1(),
                   RegisterPage2(),
                   RegisterPage3(skipToNextPage: skipToNextPage,),
                   RegisterPage4(skipToNextPage: skipToNextPage,),
                   RegisterPage5(skipToNextPage: skipToNextPage,),
                 ],
               ),
             ),
             SmoothPageIndicator(
               controller: controller
               , count: 6,
               effect: SwapEffect(
                   activeDotColor: Color(0xFF0FE8040),
                   dotColor: Colors.deepOrangeAccent.withOpacity(0.5),
                   dotHeight: 15,
                   dotWidth: 15
               ),
             ),

             ElevatedButton(

               onPressed: () => nextPage(context),
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all<Color>(
                     const Color(0xFF0FE8040)),
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


               child: const Text('Next',
                 style:
                 TextStyle(
                   fontSize: 20,
                   color: Color(0xFF2C2A2A),

                 ),),
             ),


           ],

         ),

       );
     }
   }




