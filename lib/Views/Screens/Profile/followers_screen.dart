import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Controllers/workout_controller.dart';
import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/reviews_widget.dart';


class FollowersPage extends StatefulWidget {
  final User_model user;

  const FollowersPage({super.key, required this.user});

  @override
  State<FollowersPage> createState() => _FollowersScreen();
}

class _FollowersScreen extends State<FollowersPage> {
  bool isLoading = false;

  late List<User_model> followers;

  @override
  void initState() {
    super.initState();
    fetchFollowers();
  }

  Future<void> fetchFollowers() async {
    try {
      List<String> followersIds=widget.user.followedUserIds;
      for(int i=0;i<followersIds.length;i++){
        UserController controller=UserController();
        User_model? followedUser= await controller.getUser(followersIds.toString());
        followers.add(followedUser!);
      }
    } catch (e) {
      print('Error getting equipments: $e');
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
                  Text("${widget.user?.name}'s Reviews").data ?? "",
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
            // Adjust the padding as needed
            child: Text(
              '${widget.user.followedUserIds.length} Followers',
              style: const TextStyle(
                fontSize: 20,
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
          // Add this variable to track loading state

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: followers.length,
          //     itemBuilder: (context, index) {
          //                   return ReviewsWidget.reviewsWidget(
          //                       workout, review, creator);
          //                 }
          //
          //   ),
          // ),
        ],
      ),
    );
  }

}
