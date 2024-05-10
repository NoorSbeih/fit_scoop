
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/bottom_navbar.dart';

class createWorkout2 extends StatefulWidget {

  @override
  _createWorkout2  createState() => _createWorkout2();
}

class _createWorkout2  extends State<createWorkout2> {

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
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarItemTapped,
      ),
    );
  }
}