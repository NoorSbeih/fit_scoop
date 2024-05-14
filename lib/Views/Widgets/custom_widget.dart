import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Screens/height_weight_screen.dart';


class custom_widget {
  static Widget customTextWidget(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white, // Change color to blue
        fontSize: fontSize, // Set font size to 18
        // Make text bold
        fontFamily: 'Montserrat', // Specify font family (optional)
      ),
    );
  }
  static Widget customTextWidgetForExersiceCard(String text, double fontSize) {
  return Text(
        text,
  style:  TextStyle(
  color: Colors.white,
  fontSize: fontSize,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
    ),
    );
  }
  static Widget startTextWidget(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white, // Change color to blue
        fontSize: 28, // Set font size to 18
        fontWeight: FontWeight.bold, // Make text bold
        fontFamily: 'Montserrat', // Specify font family (optional)
      ),
    );
  }
  static Widget WorkoutTitletWidget(String text,Color color) {
    return Text(
      text,
      style: TextStyle(
        color:color, // Change color to blue
        fontSize: 24, // Set font size to 18
        fontWeight: FontWeight.bold, // Make text bold
        fontFamily: 'bebas neue', // Specify font family (optional)
      ),
    );
  }
  static Widget WorkoutTexttWidget(String text,double font) {
    return Text(
      text,
      style:  TextStyle(
        color: Colors.white, // Change color to blue
        fontSize: font, // Set font size to 18
        fontWeight: FontWeight.bold, // Make text bold
        fontFamily: 'source sans pro', // Specify font family (optional)
      ),
    );
  }



  static Widget textFormFieldWidget(String hinttext,
      TextEditingController controller, BuildContext context, String text,
      Widget Function() buildTwoNumberPicker) {
      return GestureDetector(
      onTap: () {
        _showDialog(context, text, buildTwoNumberPicker,controller);
      },
      child: AbsorbPointer(
        absorbing: true, // Disable user interaction on the TextFormField
        child: TextFormField(
          controller: controller,
          readOnly: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: const TextStyle(
              color: Colors.white, // Change hint text color
              fontSize: 16.0,
            ),
            suffixIcon: const Icon(
                Icons.arrow_drop_down_outlined, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              // Change the color of the border
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              // Change the color of the focused border
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 20.0),
          ),
        ),
      ),
    );
  }

// Function to show the dialog
  static void _showDialog(BuildContext context, String text, Widget Function() buildPicker, TextEditingController controller) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: customTextWidget(text, 20),
          backgroundColor: Color(0xFF2C2A2A),
          content: Container(
            height: 240, // Adjust height of the dialog content
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(height: 35),
                    customTextWidget(text, 17),
                    Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
                  ],
                ),
                SizedBox(height: 40),
                buildPicker(),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // Align buttons to the right
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 100, right: 0),
                  // Adjust padding as needed
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: customTextWidget("CANCEL", 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0), // Adjust padding as needed
                  child: TextButton(
                    onPressed: () {
                      _textvalue(text,controller);

                      //controller.text = Page2.result; // Update the TextEditingController with the selected value
                      Navigator.of(context).pop();
                    },
                    child: customTextWidget("OK", 15),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
     static void _textvalue(String field,TextEditingController controller) {
        switch (field) {
         case 'Feet & Inches':
          controller.text=RegisterPage2.feet.toString()+"'"+RegisterPage2.inches.toString();
          int inches=(RegisterPage2.feet*12)+RegisterPage2.inches;
          double convertToinches=inches*2.54;
          RegisterPage2.textResultHeight=  controller.text;
          RegisterPage2.heightresult= convertToinches;
          break;
          case 'Kilograms':
            controller.text=RegisterPage2.kg.toString();
            RegisterPage2.textResultWeight=  controller.text;
            RegisterPage2.weightresult= double.parse(controller.text);
          break;

          case 'Pounds':
          controller.text=RegisterPage2.pound.toString();
          RegisterPage2.textResultWeight=  controller.text;
          double convertToKg=double.parse(controller.text)*0.453592;
          RegisterPage2.weightresult= convertToKg;
          break;
          case 'Centimeter':
            controller.text=RegisterPage2.cm.toString();
            RegisterPage2.textResultHeight=  controller.text;
            RegisterPage2.heightresult=double.parse(controller.text);
            break;
        default:
          break;
      }
  }

}
