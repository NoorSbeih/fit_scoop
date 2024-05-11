import 'package:fit_scoop/Views/Screens/Workout/current_workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Profile/profile_screen.dart';
import 'Community/community_screen.dart';
import 'add/createworkout1.dart';
import 'library/library_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  final _pageOptions = [
    WorkoutPage(),
    CommunityPage(),
    createWorkout1(),
    LibraryPage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
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
                color: Color(0xFF0dbab4)
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
            icon: Center(
              child: SvgPicture.asset(
                'images/plus_unclicked.svg',
                width: 35,
                height: 35,
                color: Colors.white,
              ),
            ),
            activeIcon: Center(
              child: SvgPicture.asset(
                'images/plus_clicked.svg',
                width: 35,
                height: 35,
                color: Color(0xFF0dbab4),
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
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF2C2A2A),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFF0dbab4),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      )
      );
  }
}
