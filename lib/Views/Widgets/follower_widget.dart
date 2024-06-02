import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Models/user_model.dart';

class FollowersPageWidget {
  static Widget followersWidget(User_model follower, VoidCallback onRemove) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    follower.imageLink != null
                        ? CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(follower.imageLink!),
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
                  child: Text(
                    follower.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: onRemove,
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
    );
  }
}
