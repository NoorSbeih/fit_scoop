import 'package:fit_scoop/Views/Profile/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Controllers/workout_controller.dart';
import '../../Models/user_model.dart';
import '../../Models/user_singleton.dart';
import '../../Models/workout_model.dart';
import '../Screens/Workout/current_workout_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() => _profileState();
}

class _profileState extends State<ProfilePage> {
  String label = "";
  String num = "";
  late TextEditingController _controller;
  List<Workout> workouts = [];
  late User_model user;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    fetchData();
  }

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
     user = userSingleton.getUser();
      label = user.name;

      print(num);
      print(user.followedUserIds.toString());
      setState(() {
        _controller.text = user.bio ?? '';
        print(user.bio);
      });
        String userId = user.id;
        WorkoutController controller = WorkoutController();
        workouts = await controller.getWorkoutsByUserId(userId);
        print("hhh");
        print(workouts.length);

      setState(() {
        num = '${workouts.length} workouts|${user.followedUserIds.length} followers';
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'BebasNeue'),
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
                          ],
                        ),
                        Text(
                          label,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'BebasNeue'),
                        ),
                        Text(
                          num,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'BebasNeue'),
                        ),
                      ],
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
              padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BIO',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF0dbab4),
                        fontFamily: 'BebasNeue'),
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
            SizedBox(height: 20.0),

            InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.95,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(25)),
                            border: Border.all(
                              width: 2.0, // Border width
                            ),
                          ),
                          child: WorkoutProfile(workouts: workouts, user: user),
                        );
                      },
                    );
                  },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.0),
                child:  Row(
                  children: [
                    const Text(
                      'WORKOUT',
                      style: TextStyle(
                        fontSize: 30.0,
                          fontFamily: 'BebasNeue',
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                    Expanded(child: Container()),
                     Text(
                       '${workouts.length}',
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BebasNeue',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

            InkWell(
              onTap: () {
                // Add your onPressed logic here
                print('Button pressed');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.0),
                child:  Row(
                  children: [
                    const Text(
                      'REVIEWS',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BebasNeue',
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                    Expanded(child: Container()),
                    const Text(
                      '5',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BebasNeue',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
