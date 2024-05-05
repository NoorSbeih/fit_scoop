import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:input_slider/input_slider.dart';

class Page6 extends StatelessWidget {

  const Page6({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: RegisterPage6(),
    );
  }
}


class RegisterPage6 extends StatefulWidget {
  static String daysSelected= "";
  static List<bool> isSelected = [false, false, false, false, false, false, false];
  const RegisterPage6({Key? key}) : super(key: key);


  @override
  State<RegisterPage6> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage6> {

  final List<String> _daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];


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
            padding: const EdgeInsets.only(top:10,left:16,bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.startTextWidget("One more step!"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:20.0,left:16,right:16),
            child: Align(
              alignment: Alignment.centerLeft,
              child:custom_widget.customTextWidget("Finally, choose the days of the week you wish to work out in.",15),
            ),
          ),
        const Padding(
            padding: EdgeInsets.only(top:10,left:16,bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
            'Please choose at least one day!',
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Montserrat',
              color: Colors.red,
             ),
            ),
          ),
          ),

          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 17.0,
              childAspectRatio: 3.0,
            ),
            itemCount: 7, // Number of days in a week
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      RegisterPage6.isSelected[index] = !RegisterPage6.isSelected[index];
                    });
                    _getSelectedDays();
                  },
                  style: ElevatedButton.styleFrom(
                     foregroundColor: Colors.white, backgroundColor:Color(0xFF383838),
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: RegisterPage6.isSelected[index] ?  Color(0xFF00DBAB4):Colors.white,
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
    for (int i = 0; i < RegisterPage6.isSelected.length; i++) {
      if (RegisterPage6.isSelected[i]) {
        selectedDays.add(days[i]);
      }
    }
    RegisterPage6.daysSelected=selectedDays.join(', ');
    return selectedDays.join(', ');
  }
}
