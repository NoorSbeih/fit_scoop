import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Controllers/workout_controller.dart';
import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/follower_widget.dart';
import '../../Widgets/reviews_widget.dart';

class FollowersPage extends StatefulWidget {
  final ValueNotifier<int> followingsNotifier;
  final User_model user;

  const FollowersPage({super.key, required this.user,required this.followingsNotifier});

  @override
  State<FollowersPage> createState() => _FollowersScreen();
}

class _FollowersScreen extends State<FollowersPage> {
  bool isLoading = false;
  List<User_model> followers = [];

  @override
  void initState() {
    super.initState();
    fetchFollowers();
  }

  void removeFollower(User_model follower) async {
    UserController controller = UserController();
    await controller.unfollowUser( widget.user.id,follower.id);
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();
    user.followedUserIds.remove(follower.id);
    setState(() {
      user.followedUserIds.remove(follower.id);
      followers.remove(follower);
      widget.followingsNotifier.value = user.followedUserIds.length;
    });
  }


    // Add logic to update the database or API if needed

  Future<void> fetchFollowers() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<String> followersIds = widget.user.followedUserIds;
      List<User_model> fetchedFollowers = [];
      UserController controller = UserController();
      for (String id in followersIds) {
        User_model? followedUser = await controller.getUser(id);
        if (followedUser != null) {
          fetchedFollowers.add(followedUser);
        }
      }
      setState(() {
        followers = fetchedFollowers;
      });
    } catch (e) {
      //print('Error getting followers: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2A2A),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Color(0xFF0dbab4)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the page
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  Text("${widget.user.name}'s Followings").data ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'BebasNeue',
                  ),
                ),
              ),
            ),
            SizedBox(width: 48), // To balance the space taken by IconButton
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30),
            child: Text(
              '${followers.length} Followings',
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFF0dbab4),
                fontFamily: 'BebasNeue',
              ),
            ),
          ),
          SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              itemCount: followers.length,
              itemBuilder: (context, index) {
                User_model user = followers[index];
                return FollowersPageWidget.followersWidget(user, () => removeFollower(user));
              },
            ),
          ),
        ],
      ),
    );
  }
}
