
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/bodyMetricsSingleton.dart';
import '../../../Models/body_metrics_model.dart';


class Weight_HeightUpdate extends StatefulWidget {
  static int feet = 5;
  static int inches = 6;
  static int cm = 150;
  static int pound = 100;
  static int kg= 50;
  static double heightresult=0;
  static double weightresult=0;
  static String textResultHeight="";
  static String textResultWeight="";

  final Function(double,double) onUpdateWeightHeight;
  Weight_HeightUpdate({Key? key, required this.onUpdateWeightHeight}) : super(key: key);

  @override
  createState() => _Weight_HeightUpdate();
}
class _Weight_HeightUpdate extends State<Weight_HeightUpdate> {
  late String _selectedValue="";
  late TextEditingController  selectedHeight = TextEditingController();
  late TextEditingController  selectedWeight = TextEditingController();

  void initState() {
    super.initState();
    BodyMetricsSingleton singleton = BodyMetricsSingleton.getInstance();
    BodyMetrics metrics = singleton.getMetrices();
     selectedHeight.text=metrics.height.toString();
     selectedWeight.text=metrics.weight.toString();
    //_selectedValue=metrics.unitOfMeasure;

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
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10,left:16,bottom: 10),
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
                child:RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    text: "Height",
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
              )
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child:  _selectedValue == 'imperial'
                ? _buildImperialPicker(context)
                : _buildMetricPicker(context),
          ),
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child:Align(
                alignment: Alignment.centerLeft,
                child:RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    text: "Weight",
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
              )
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: _selectedValue == 'imperial'
                ? _buildImperialWeightPicker(context)
                :  _buildMetricWeightPicker(context),
          ),

        ],
      ),
    );
  }
  Widget _buildImperialWeightPicker (BuildContext context) {
    return custom_widget.textFormFieldWidget("Select Weight",selectedWeight,context,"Pounds",_buildNumberPickerInPound);
  }
  Widget _buildMetricWeightPicker (BuildContext context) {
    return custom_widget.textFormFieldWidget("Select Weight",selectedWeight,context,"Kilograms",_buildNumberPickerInKg);
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
        _buildNumberPicker(Weight_HeightUpdate.feet,"ft",0,10,47),
        SizedBox(width:20),
        _buildNumberPicker(Weight_HeightUpdate.inches,"in",5,12,47),
      ],
    );
  }
  Widget _buildNumberPickerInCm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(Weight_HeightUpdate.cm,"cm",100,200,80),
      ],
    );
  }
  Widget _buildNumberPickerInKg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(Weight_HeightUpdate.kg,"kg",30,200,80),
      ],
    );
  }
  Widget _buildNumberPickerInPound() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberPicker(Weight_HeightUpdate.pound,"lbs",100,200,80),
      ],
    );
  }

  void updateValue(String field, int value) {
    setState(() {
      switch (field) {
        case 'ft':
          Weight_HeightUpdate.feet = value;
          print(Weight_HeightUpdate.feet);
          break;
        case 'cm':
          Weight_HeightUpdate.cm = value;
          break;
        case 'in':
          Weight_HeightUpdate.inches = value;
          break;
        case 'lbs':
          Weight_HeightUpdate.pound = value;
          break;
        case 'kg':
          Weight_HeightUpdate.kg = value;
          break;
        default:
          break;
      }
    });
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
                  updateValue(text, value);
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

