
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/bottom_navbar.dart';
import 'createworkout2.dart';

class createWorkout1 extends StatefulWidget {

  @override
  _createWorkout1  createState() => _createWorkout1();
}

class _createWorkout1  extends State<createWorkout1> {
  int _selectedIndex = 2;
  @override
  void initState() {
    super.initState();
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        // Match with scaffold background color
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF0dbab4),),
          onPressed: () {
            // Handle settings icon pressed
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF0dbab4),),
            onPressed: () {
              // Handle menu icon pressed
            },
          ),
        ],
      ),
    body:
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
    Padding(
    padding: const EdgeInsets.only(bottom: 10,left:16,right:16),
       child: TextField(
         decoration: InputDecoration(
           hintText: 'Workout Name ', // Your hint text goes here
           border: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.transparent), // Transparent color to hide border
           ),
           focusedBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.white), // Transparent color to hide border
           ),
         ),
       )




    ),
          Padding(
            padding: const EdgeInsets.only(left:16.0,right: 10),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => createWorkout2()),
                );


              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
                fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Border radius
                    );
                  },
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2C2A2A),
                ),
              ),
            ),
          ),
      ],
    ),








      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarItemTapped,
      ),
    );
  }
}