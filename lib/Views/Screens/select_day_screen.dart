import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:input_slider/input_slider.dart';

class Page6 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage6(),
    );
  }
}


class RegisterPage6 extends StatefulWidget {
  static double _currentValue=50 ;
  const RegisterPage6({Key? key}) : super(key: key);


  @override
  State<RegisterPage6> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage6> {
  List<bool> isSelected = [false, false, false, false, false, false, false];
  List<String> _daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(top:40,right:25),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0FE8040),
                  ),
                ),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:20,left:16,bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.startTextWidget("One more step!"),
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(bottom:60.0,left:16,right:16),
            child: Align(
              alignment: Alignment.centerLeft,
              child:custom_widget.customTextWidget("Finally, choose the days of the week you wish to work out in.",15),
            ),// Add padding from the bottom only

          ),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 17.0,
              childAspectRatio: 4.0,
            ),
            itemCount: 7, // Number of days in a week
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSelected[index] = !isSelected[index];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                     foregroundColor: Colors.white, backgroundColor: Colors.black,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: isSelected[index] ? const Color(0xFF0FE8040):Colors.white,
                        width:1,
                      )
                    ),
                  ),
                  child: Text(
                    _daysOfWeek[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  String _getSelectedDays() {
    List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    List<String> selectedDays = [];
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        selectedDays.add(days[i]);
      }
    }
    return selectedDays.join(', ');
  }
}
