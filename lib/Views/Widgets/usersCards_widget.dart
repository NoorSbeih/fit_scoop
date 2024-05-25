import 'package:fit_scoop/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../Controllers/workout_controller.dart';
import '../../Models/user_singleton.dart';
import '../../Models/workout_model.dart';
import '../Screens/Community/userProfile.dart';
import '../Screens/library/workout_detail_screen.dart';

class UsersCardsWidget {
  List<Workout> workouts = [];
    static Widget userWidget(User_model user, int num,BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileUser(user: user)),
        );
      },
      child:
      Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                        Stack(
                          children: [
                            user.imageLink != null
                                ? CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(user.imageLink!),
                            )
                                : CircleAvatar(
                              radius: 30,
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
                              Text(
                                user.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'BebasNeue'),
                              ),
                              Text(
                                '${num} workouts | ${user.followedUserIds.length} followers',
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
          ],
        ),
      ),
      ),
    );
  }
}
