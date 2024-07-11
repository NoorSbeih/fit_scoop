
import 'package:fit_scoop/Controllers/register_controller.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/user_model.dart';

class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage1(),
    );
  }
}
class RegisterPage1 extends StatefulWidget {

  static String selectedgender="Male";
  static String formateddate="";

  static void clearData() {
    selectedgender = " ";
    formateddate= "";
  }

  const RegisterPage1({Key? key}) : super(key: key);


  @override
  State<RegisterPage1> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage1> {
  TextEditingController _dateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _dateController.text = RegisterPage1.formateddate;

  }

  DateTime? _selectedDate; // Initialize with null or another default value

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
      textColor: Colors.white,
      backgroundColor: Color(0xFF2C2A2A), // Set the background color here
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        RegisterPage1.formateddate =
            DateFormat('dd/MM/yyyy').format(_selectedDate!);
        _dateController.text = RegisterPage1.formateddate;
      });
    } else {
      //print("Date selection canceled");
    }
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:const Color(0xFF2C2A2A),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:60,left:16,bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.startTextWidget("Lets get started!"),
            ),

          ),

          Padding(
            padding: const EdgeInsets.only(top:10,bottom:25.0,left:16),
            child: Align(
              alignment: Alignment.centerLeft,
              child:custom_widget.customTextWidget("Please Enter Your Birth date and Gender ",15),
            ),// Add padding from the bottom only
          ),
           Padding(
             padding: EdgeInsets.only(left: 20.0,top:30),
            child: Align(
             alignment: Alignment.centerLeft,
             child:RichText(
            textAlign: TextAlign.left,
            text: const TextSpan(
              text: "Birth Date",
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
           ),
           ),
          Padding(
              padding: EdgeInsets.all(15),
              child :TextFormField(
                controller: _dateController,
                readOnly: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY',
                  hintStyle: const TextStyle(
                    color: Colors.white, // Change hint text color
                    fontSize: 16.0, // Change hint text font size
                    fontStyle: FontStyle.italic, // Change hint text font style
                  ),
                  prefixIcon: IconButton(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xff00DBAB4), // Change the color of the icon
                    ),
                  ),


                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Change the color of the border
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Change the color of the focused border
                    borderRadius: BorderRadius.circular(10.0),
                  ),


                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              )
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 20.0,top:20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(
                  text: "Gender",
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
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0,left:16),
                  child: Row(
                    children: [
                      Radio(
                        value:"Male",
                        groupValue: RegisterPage1.selectedgender,
                        onChanged: (value) async {
                          setState(()  {
                            RegisterPage1.selectedgender= value!;
                          });
                               SharedPreferences prefs =await SharedPreferences.getInstance() ;
                               prefs.setString('Gender', 'Male');
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        fillColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.white; // Change the selected color
                            }
                            return Colors.white; // Change the unselected color
                          },
                        ),

                      ),
                      custom_widget.customTextWidget("Male",18),

                      const SizedBox(width: 20), // Adjust as needed for spacing
                      Radio(
                        value: "Female",
                        groupValue: RegisterPage1.selectedgender,
                        onChanged: (value) async {
                          setState(() {
                            RegisterPage1.selectedgender = value!;
                          });

                          SharedPreferences prefs =await SharedPreferences.getInstance() ;
                          prefs.setString('Gender', 'Female');
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        fillColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.white; // Change the selected color
                            }
                            return Colors.white;
                          },
                        ),
                      ),

                      custom_widget.customTextWidget("Female",18),
                    ],
                  )
              ),
            ],
          ),

        ],
      ),

    );

  }

}



