import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Screens/library/library_screen.dart';
import '../Screens/test_screen.dart';



class MyNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  MyNavigationBar({required this.selectedIndex, required this.onItemSelected});

  // void _onItemTapped(int index) {
  //     selectedIndex = index;
  //     if (index == 3) { // Assuming 3 is the index of the "Library" icon
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => LibraryPage()),
  //       );
  //     }
  // }

  void _handleItemTapped(BuildContext context,int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Test()),
        );
        break;
      case 1:
      // Handle Search item tap
        break;
      case 2:
      // Handle Profile item tap
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LibraryPage()),
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: (index) {
      onItemSelected(index);
      _handleItemTapped(context,index);
    },
        items:  <BottomNavigationBarItem>[
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF2C2A2A),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFF0dbab4),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),

      );
  }
}
