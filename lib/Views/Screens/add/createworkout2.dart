
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Widgets/bottom_navbar.dart';

class createWorkout2 extends StatefulWidget {

  @override
  _createWorkout2  createState() => _createWorkout2();
}

class _createWorkout2  extends State<createWorkout2> {

  int _selectedIndex = 2;
  bool isPrivate = true;
  double rating = 0;
  String label="Beginner";

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
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF0dbab4)),
          onPressed: () {
            // Handle menu icon pressed
          },
        ),
        title: const Text(
          'CREATE WORKOUT',
          style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'BebasNeue'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:16.0,left:20,right:20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
        padding: EdgeInsets.only(top:15,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Workout Intensity',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'BebasNeue'),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                RatingBar.builder(
                  direction: Axis.horizontal,
                  itemCount: 3,
                  tapOnlyMode: true,
                  itemPadding: EdgeInsets.all(0),
                  itemSize: 35.0,
                  itemBuilder: (context, _) => Transform.scale(
                    scale: 0.7,
                    child: const Icon(
                      Icons.star,
                      color: Color(0xFF0dbab4),
                    ),
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                      switch (newRating.toInt()) {
                        case 1:
                          label = 'Beginner';
                          break;
                        case 2:
                          label = 'Intermediate';
                          break;
                        case 3:
                          label = 'Advanced';
                          break;
                      }
                    });
                  },
                ),
              Text(
                label,
                style: TextStyle(color: Colors.white),
              )

              ],
          ),
              ],
            ),
        ),
            SizedBox(height: 16.0),
            const Text(
              'Add a Description:',
              style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'BebasNeue'),
            ),
            Padding(
              padding: EdgeInsets.only(top:15,bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15.0),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),


            const SizedBox(height: 16.0),
            SwitchListTile(
              title: const Text(
                'Private Workout',
                style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'BebasNeue'),
              ),
              value: isPrivate,
              onChanged: (value) {
                setState(() {
                  isPrivate = value;
                });
              },
              activeColor: Color(0xFF0dbab4),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView( // Wrap the Row with SingleChildScrollView
                scrollDirection: Axis.horizontal, // Allow horizontal scrolling
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print(label);
                        print(isPrivate);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
                        fixedSize: MaterialStateProperty.all<Size>(const Size(335, 50)),
                        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                              (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          },
                        ),
                      ),
                      child: const Text(
                        'Finish',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF2C2A2A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
            ),
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarItemTapped,
      ),
    );
  }
}