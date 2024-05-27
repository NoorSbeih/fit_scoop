import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Models/review_model.dart';
import '../../../Models/user_model.dart';
import '../../../Models/workout_model.dart';


class communityReviewsWidget {
  static Widget CommunityreviewsWidget(
      Workout workout, Review review, User_model creator, String time) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Row(
                children: [
                  Stack(
                    children: [
                      creator.imageLink != null
                          ? CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(creator.imageLink!),
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
                  SizedBox(width: 5), // Add spacing between icon and text
                  Text(
                    '${creator.name} has reviewed a workout',
                    style: const TextStyle(
                      color: Color(0xFF0dbab4),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF0dbab4),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // Add some spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      workout.name,
                      style: const TextStyle(
                        color: Color(0xFF0dbab4),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Created by: ${creator.name}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < review.rating ? Color(0xFF0dbab4) : Colors.grey,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            review.comment,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 10.0),
          const Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ],
      ),
    );
  }



}


