import 'package:fit_scoop/Views/Screens/Workout/current_workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Community/search_screen.dart';
import 'Profile/profile_screen.dart';
import 'add/createworkout1.dart';
import 'library/library_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  final List <Widget> _pageOptions = [
    WorkoutPage(),
    createWorkout1(),
    LibraryPage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],

      bottomNavigationBar: SizedBox(
        height: 83,
        child: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            print("Selected page: $index");
            selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              'images/home_unclicked.svg',
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
              color: Colors.white,
            ),

            activeIcon: SvgPicture.asset(
              'images/home_clicked.svg',
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
                color: const Color(0xFF0dbab4)
            ),
          ),
          BottomNavigationBarItem(
            label: "Community",
            icon: SvgPicture.asset(
              'images/community_unclicked.svg',
              width: 24,
              height: 24,
                color: Colors.white
            ),
            activeIcon: SvgPicture.asset(
              'images/community_clicked.svg',
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
               color: Color(0xFF0dbab4)
            ),
          ),
          BottomNavigationBarItem(
            label: "",

            icon: Padding(
              padding: EdgeInsets.only(top: 8.0), // Adjust the top padding as needed
              child: Center(
                child: SvgPicture.asset(
                  'images/plus_unclicked.svg',
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 8.0), // Adjust the top padding as needed
              child: Center(
                child: SvgPicture.asset(
                  'images/plus_clicked.svg',
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          BottomNavigationBarItem(
            label: "Library",
            icon: SvgPicture.asset(
              'images/heart_unclicked.svg',
              width: 24,
              height: 24,
                color: Colors.white
            ),
            activeIcon: SvgPicture.asset(
              'images/heart_clicked.svg',
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
                color: Color(0xFF0dbab4),
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: SvgPicture.asset(
              'images/profile_unclicked.svg',
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
                color: Colors.white
            ),
            activeIcon: SvgPicture.asset(
              'images/profile_clicked.svg',
              width: 24, // Adjust the width as needed
              height: 24,
              color: Color(0xFF0dbab4)

            ),
          ),
        ],


        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF605D5D),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFF0dbab4),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      )
      )
    );
  }
}
