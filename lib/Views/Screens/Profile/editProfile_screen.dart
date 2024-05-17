import 'package:fit_scoop/Models/review_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Models/user_model.dart';



class EditProfile extends StatefulWidget {
  final User_model user;

  const EditProfile({super.key, required this.user});

  @override
  createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color(0xFF0dbab4),
          ),
          onPressed: () {
            // Handle settings icon pressed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Container(
              height: 65,
              width: 65,
              child: SvgPicture.asset(
                'images/profile-circle-svgrepo-com.svg',
                width: 24, // Adjust the width as needed
                height: 24, // Adjust the height as needed
                color: Color(0xFF0dbab4),
              ),
            ),
            SizedBox(width: 20),
            const Text(
              'Profile',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'BebasNeue'),
            ),
            SizedBox(width: 190.0),
            SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                'images/write-svgrepo-com.svg',
                width: 24, // Adjust the width as needed
                height: 24, // Adjust the height as needed
                color: Color(0xFF0dbab4),
              ),
            ),
            const Text(
              'jj',
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'BebasNeue'),
            ),
            const Text(
              'fgfg',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'BebasNeue'),
            ),
            SizedBox(height: 10.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            SizedBox(height: 10.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BIO',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF0dbab4),
                        fontFamily: 'BebasNeue'),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
