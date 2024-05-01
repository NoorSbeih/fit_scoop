import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// class BottomNavbar extends StatefulWidget{
//
//   const BottomNavbar({Key? key}) : super(key: key);
//
//
//   @override
//   State<BottomNavbar> createState() => _BottomNavbar();
//
// }
//
// class _BottomNavbar extends State<BottomNavbar> {
//   int currentIndex=0;
//   List<Widget> body= [
//     SvgPicture.asset(
//         'images/home_unclicked.svg'),
//   SvgPicture.asset(
//   'images/community_unclicked.svg'),
//     SvgPicture.asset(
//         'images/plus_unclicked.svg'),
//     SvgPicture.asset(
//         'images/heart_unclicked.svg'),
//     SvgPicture.asset(
//         'images/profile_unclicked.svg'),
//
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return
//     BottomNavigationBar(
//     type: BottomNavigationBarType.fixed,
//     backgroundColor: Color(0xFF2C2A2A),
//     selectedItemColor: Color(0xFFC91212),
//     unselectedItemColor: Colors.white,
//     selectedFontSize: 14,
//     unselectedFontSize: 14,
//       onTap: (value) {
//       },
//       items:  [
//         BottomNavigationBarItem(
//           label: "Home",
//           icon: SvgPicture.asset(
//             'images/home_unclicked.svg',
//             width: 24, // Adjust the width as needed
//             height: 24, // Adjust the height as needed
//           ),
//         ),
//         BottomNavigationBarItem(
//           label: "Community",
//           icon: SvgPicture.asset(
//             'images/community_unclicked.svg',
//             width: 24, // Adjust the width as needed
//             height: 24, // Adjust the height as needed
//           ),
//         ),
//
//         BottomNavigationBarItem(
//           label: "",
//           icon: SvgPicture.asset(
//             'images/plus_unclicked.svg',
//             width: 24, // Adjust the width as needed
//             height: 24, // Adjust the height as needed
//           ),
//         ),
//
//         BottomNavigationBarItem(
//             label: "Library",
//           icon: SvgPicture.asset(
//             'images/heart_unclicked.svg',
//             width: 24, // Adjust the width as needed
//             height: 24, // Adjust the height as needed
//           ),
//         ),
//
//         BottomNavigationBarItem(
//           label: "Profile",
//           icon: SvgPicture.asset(
//             'images/profile_unclicked.svg',
//             width: 24, // Adjust the width as needed
//             height: 24, // Adjust the height as needed
//           ),
//         ),
//       ],
//     );
//   }
// }
//



class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar ({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Selected Index: $_selectedIndex'),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
                color: Color(0xFF1F6969)
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
                color: Color(0xFF1F6969)
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
                color: Color(0xFF1F6969),
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
                color: Color(0xFF1F6969)
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
              color: Color(0xFF1F6969)

            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF2C2A2A),
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFF1F6969),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}
