import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/user_model.dart';


class Page2 extends StatelessWidget {
  static String result="";
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage2(),
    );
  }
}
class RegisterPage2 extends StatefulWidget{
const RegisterPage2({Key? key}) : super(key: key);


@override
State<RegisterPage2> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage2> {
  int feet = 5;
  int inches = 6;
  int cm = 150;
  late String _selectedValue="";
  late TextEditingController  selectedHeight = TextEditingController();
  late TextEditingController  selectedWeight = TextEditingController();

  void initState() {
    super.initState();
    _loadPreferences(); // Load the preference when the widget is initialized
  }

void _loadPreferences() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? unitOfMeasure=sharedPreferences.getString('unitOfMeasure');
    setState(() {
      _selectedValue=unitOfMeasure!;
    });
}



  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF2C2A2A),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:70,left:16,bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: custom_widget.startTextWidget("Weight and Height"),
          ),

        ),
        Padding(
          padding: const EdgeInsets.only(bottom:60.0,left:16,right:16),
          child: Align(
            alignment: Alignment.centerLeft,
            child:custom_widget.customTextWidget("Entering your weight and height is essential for determining the bet workouts as well as tracking your progress.",15),
          ),// Add padding from the bottom only

        ),
         Padding(
          padding: const EdgeInsets.only(left: 20.0),
           child:Align(
             alignment: Alignment.centerLeft,
             child:custom_widget.customTextWidget("Height",20),
           )
        ),
    Padding(
    padding: EdgeInsets.all(15),
      child:  _selectedValue == 'imperial'
            ? _buildImperialPicker(context)
            : _buildMetricPicker(context),
    ),
        Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child:Align(
              alignment: Alignment.centerLeft,
              child:custom_widget.customTextWidget("Weight",20),
            )
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: _selectedValue == 'imperial'
              ? _buildImperialWeightPicker(context)
              :  _buildImperialWeightPicker(context),
        ),

      ],
    ),
  );
  }
  Widget _buildImperialWeightPicker (BuildContext context) {
    return custom_widget.textFormFieldWidget("Select Weight",  selectedWeight,context,"Pounds",_buildNumberPickerInPound);
  }
  Widget _buildMetricPicker(BuildContext context) {
    return custom_widget.textFormFieldWidget("Select Height ",  selectedHeight,context,"Centimeter",_buildNumberPickerInCm);
    }
  Widget _buildImperialPicker(BuildContext context) {
    return custom_widget.textFormFieldWidget("Select Height ",  selectedHeight,context,"Feet & Inches",_buildTwoNumberPicker);
  }
  Widget _buildTwoNumberPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(feet,"ft",0,10,47),
         SizedBox(width:20),
        _buildNumberPicker(inches,"in",5,12,47),
      ],
    );
  }
  Widget _buildNumberPickerInCm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(cm,"cm",100,200,80),
      ],
    );
  }
  Widget _buildNumberPickerInPound() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      ],
    );
  }





  Widget _buildNumberPicker(int x,String text,int minValue, int maxValue,double itemWidth){
   return  Row(
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
                  x=value;
                  selectedHeight.text=x.toString();
               });
             },
             selectedTextStyle: TextStyle(fontSize: 16, color: Colors.white),
             axis: Axis.vertical,
             decoration: const BoxDecoration(
               border: Border(
                 top: BorderSide(color: Colors.white, width: 3), // Color for top border
                 bottom: BorderSide(color: Colors.white, width: 3), // Color for bottom border
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

