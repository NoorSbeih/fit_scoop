import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/workout_controller.dart';
import '../../Models/review_model.dart';
import '../../Models/user_model.dart';
import '../../Models/user_singleton.dart';
import '../../Models/workout_model.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';

class reviewsProfile extends StatefulWidget {
  final List<Review> reviews;
  final User_model user;

  const reviewsProfile({super.key, required this.reviews, required this.user});

  @override
  State<reviewsProfile> createState() => _ReviewsScreen();
}

class _ReviewsScreen extends State<reviewsProfile> {
  late TextEditingController _myWorkoutsSearchController;
  late String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
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
            SizedBox(width: 4),
            Text(
              '${widget.user.name} WORKOUTS',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'BebasNeue',
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            // Adjust the padding as needed
            child: Text(
              '${widget.reviews.length} WORKOUTS',
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFF0dbab4),
                fontFamily: 'BebasNeue',
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: widget.reviews.length,
          //     itemBuilder: (context, index) {
          //       Review review = widget.reviews[index];
          //       return reviewsWidget(review);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
