import 'package:fit_scoop/Models/review_model.dart';
import 'package:fit_scoop/Views/Screens/Profile/editProfile_screen.dart';
import 'package:fit_scoop/Views/Screens/Profile/review_screen.dart';
import 'package:fit_scoop/Views/Screens/Profile/workout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Controllers/review_controller.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/drawer_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() => _profileState();
}

class _profileState extends State<ProfilePage> {
  String label = "";
  String num = "";
  late TextEditingController _controller;
  List<Workout> workouts = [];
  List<Review> reviews = [];
  late User_model user;
  String? imageUrl;
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

      String? imageUrl = user.imageLink;
      setState(() {
        this.imageUrl = imageUrl;
      });
        String userId = user.id;
        WorkoutController controller = WorkoutController();
        workouts = await controller.getWorkoutsByUserId(userId);

      ReviewController controller2=ReviewController();
      reviews = await controller2.getReviewsByUserId(userId);
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
        iconTheme: const IconThemeData(
          color: Color(0xFF0dbab4), // Change the drawer icon color here
        ),

      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
    child:Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 20,right:20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Stack(
                  children: [
                    imageUrl != null
                        ? CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(imageUrl!),
                    )
                        : CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        'images/profile-circle-svgrepo-com.svg',
                        width: 128,
                        height: 128,
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'BebasNeue'),
                          ),
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(user: user),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                'images/write-svgrepo-com.svg',
                                width: 24,
                                height: 24,
                                color: Color(0xFF0dbab4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        label,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
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
              height: 200,
              width:380,
              padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
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
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SelectableText(
                        _controller.text,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        maxLines: 5,
                      ),
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
                      height: MediaQuery.of(context).size.height * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.all(
                          width: 2.0,
                        ),
                      ),
                      child: WorkoutProfile(workouts: workouts, user: user),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
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
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.all(
                          width: 2.0,
                        ),
                      ),
                      child: reviewsProfile(user: user, reviews: reviews),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
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
                    Text(
                      '${reviews.length}',
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
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                        border: Border.all(
                          width: 2.0,
                        ),
                      ),
                      child: reviewsProfile(user: user, reviews: reviews),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text(
                      'FOLLOWERS',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BebasNeue',
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      '${user.followedUserIds.length}',
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
          ],
        ),
      ),
      ),
    );
  }
}