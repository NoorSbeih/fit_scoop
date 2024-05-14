import 'package:flutter/material.dart';

import '../../Models/user_model.dart';
import '../../Models/user_singleton.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() => _profileState();
}

class _profileState extends State<ProfilePage> {
  String label = "";
  String num = "";
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    fetchData();
  }

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      User_model user = userSingleton.getUser();
      label = user.name;
      num = 'workouts|${user.followedUserIds.length} followers';
      print(num);
      print(user.followedUserIds.toString());
      setState(() {
        _controller.text = user.bio ?? '';
        print(user.bio);
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error if needed
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF0dbab4),
                        size: 60,
                      ),
                    ),
                    SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'BebasNeue'),
                        ),
                        Text(
                          label,
                          style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'BebasNeue'),
                        ),
                        Text(
                          num,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'BebasNeue'),
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Container(
                      height: 10,
                      width: 36,
                      child: const Icon(
                        Icons.phone_enabled,
                        color: Color(0xFF0dbab4),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top:10,left:20.0,right:20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BIO',
                    style: TextStyle(fontSize: 30, color: Color(0xFF0dbab4), fontFamily: 'BebasNeue'),
                  ),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(
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
