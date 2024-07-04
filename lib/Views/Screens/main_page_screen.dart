import 'package:fit_scoop/Views/Screens/Workout/current_workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Community/community_screen.dart';
import 'Profile/profile_screen.dart';
import 'add/createworkout1.dart';
import 'library/library_screen.dart';


class HomePage extends StatefulWidget {

  final int initialIndex;

  HomePage({Key? key, this.initialIndex = 0}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedPage;

  final List<Widget> _pageOptions = [
    WorkoutPage(),
    CommunityPage(),
    createWorkout1(),
    LibraryPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedPage = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ClipRect(
        child: PreferredSize(
          preferredSize: const Size.fromHeight(60), // Adjust the height as needed
          child: BottomNavigationBar(
            currentIndex: selectedPage,
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
                  color: const Color(0xFF0dbab4),
                ),
              ),
              BottomNavigationBarItem(
                label: "Community",
                icon: SvgPicture.asset(
                  'images/community_unclicked.svg',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                activeIcon: SvgPicture.asset(
                  'images/community_clicked.svg',
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                  color: const Color(0xFF0dbab4),
                ),
              ),
              BottomNavigationBarItem(
                label: " ", // Space instead of an empty string
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0), // Adjust the top padding as needed
                  child: Center(
                    child: SvgPicture.asset(
                      'images/plus_unclicked.svg',
                      width: 35,
                      height: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8.0), // Adjust the top padding as needed
                  child: Center(
                    child: SvgPicture.asset(
                      'images/plus_clicked.svg',
                      width: 40,
                      height: 40,
                      color: const Color(0xFF0dbab4),
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
                  color: Colors.white,
                ),
                activeIcon: SvgPicture.asset(
                  'images/heart_clicked.svg',
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                  color: const Color(0xFF0dbab4),
                ),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: SvgPicture.asset(
                  'images/profile_unclicked.svg',
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                  color: Colors.white,
                ),
                activeIcon: SvgPicture.asset(
                  'images/profile_clicked.svg',
                  width: 24, // Adjust the width as needed
                  height: 24,
                  color: const Color(0xFF0dbab4),
                ),
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF605D5D),
            unselectedItemColor: Colors.white,
            selectedItemColor: const Color(0xFF0dbab4),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            iconSize: 24, // Adjust the icon size as needed
          ),
        ),
      ),
    );
  }
}



