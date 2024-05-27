//create am empty screen for now

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_scoop/Controllers/workout_controller.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Views/Screens/Community/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Controllers/community_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../Models/review_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/reviews_widget.dart';
import 'community_workout_widget.dart';
import 'community_review_widget.dart';



class  CommunityPage extends StatefulWidget {

  static List<String> likedWorkoutIds = [];
  @override
  _communityPage createState() => _communityPage();
}

class _communityPage  extends State< CommunityPage> {
   late Future<List<dynamic>> activities; // Declare _activitiesFuture as a Future<List<dynamic>>
   UserController userController = UserController();
   WorkoutController workoutController = WorkoutController();
   UserSingleton userSingleton = UserSingleton
       .getInstance();
   String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    fetchAndSetActivities();
  }

  Future<void> fetchAndSetActivities() async {
    activities = fetchActivities(); // Assign the result of fetchActivities() to _activitiesFuture
  }

   Future<List<dynamic>> fetchActivities() async {
     CommunityPageController controller = CommunityPageController();
     UserSingleton userSingleton = UserSingleton.getInstance();
     User_model user = userSingleton.getUser();
     List<dynamic> allActivities = await controller.getRecentActivities(user.id);
     CommunityPage.likedWorkoutIds=user.savedWorkoutIds;// Get all activities
  /*   if (_searchQuery.isNotEmpty) {
       allActivities = allActivities.where((activity) {
         if (activity is Workout) {
           return activity.name.toLowerCase().contains(_searchQuery.toLowerCase());
         } else if (activity is Review) {
           return activity.comment.toLowerCase().contains(_searchQuery.toLowerCase());
         }
         return false;
       }).toList();
     }*/
     return allActivities;
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xFF2C2A2A),
     appBar: AppBar(
   backgroundColor: Color(0xFF2C2A2A),
    leading: IconButton(
    icon: const Icon(Icons.menu, color: Color(0xFF0dbab4)),
    onPressed: () {
    },
    )
     ),
      body: Column(
    children: [
    Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          );
        },
        child: AbsorbPointer(
          child: TextField(
    //controller: _savedWorkoutsSearchController,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
    hintText: 'Search for users,workouts...',
    hintStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide:
    BorderSide(color: Colors.white, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide:
    BorderSide(color: Colors.white, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide:
    BorderSide(color: Colors.white, width: 1.0),
    ),
    contentPadding: const EdgeInsets.symmetric(
    horizontal: 16.0, vertical: 12.0),
    prefixIcon: const Icon(
    Icons.search,
    color: Colors.white,
    ),
    ),
    onChanged: (query) {
    setState(() {

      //_searchQuery = query;
      //fetchAndSetActivities();
    });
    },
    ),
    ),
      ),

    ),
      Expanded(
          child:displayLatestActivities()
      ),
    ],
    ),
    );
  }
   FutureBuilder<List<dynamic>> displayLatestActivities() {
     return FutureBuilder<List<dynamic>>(
       future: activities,
       builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(
             child: CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
             ),
           );
         } else if (snapshot.hasError) {
           return Text('Error: ${snapshot.error}');
         } else {
           List<dynamic> activityList = snapshot.data ?? [];
           return ListView.builder(
             itemCount: activityList.length,
             itemBuilder: (context, index) {
               var activity = activityList[index];
               if (activity is Review) {
                 if (DateTime.now().difference(activity.timestamp).inDays >= 7) {
                   return SizedBox.shrink(); // Return an empty widget if older than 7 days
                 }
                 return FutureBuilder<Widget>(
                   future: fetchReview(activity),
                   builder: (context, snapshot) {
                     if (snapshot.hasError) {
                       return Text('Error: ${snapshot.error}');
                     } else {
                       return snapshot.data ?? SizedBox.shrink();
                     }
                   },
                 );
               } if (activity is Workout) {
                 if (DateTime.now().difference(activity.timestamp).inDays >= 7) {
                   return SizedBox.shrink(); // Return an empty widget if older than 7 days
                 }
                 return FutureBuilder<Widget>(
                   future: fetchWorkout(activity),
                   builder: (context, snapshot) {
                     if (snapshot.hasError) {
                       return Text('Error: ${snapshot.error}');
                     } else {
                       return snapshot.data ?? SizedBox.shrink();
                     }
                   },
                 );
               }


               else {
                 return SizedBox.shrink();
               }
             },
           );
         }
       },
     );
   }


   Future<Widget> fetchReview(Review activity) async {

    Workout? workout = await workoutController.getWorkout(activity.workoutId);
    User_model? user =await  userController.getUser(activity.reviewingUserId) ;

    return communityReviewsWidget.CommunityreviewsWidget(workout!, activity, user!,formatTimestamp(activity.timestamp));
  }




  Future<Widget> fetchWorkout(Workout activity) async {
    User_model? user = await  userController.getUser(activity.creatorId);

    return communityWorkoutWidget.communityCardWidget(
      activity,
      context,
      user!.name,
      CommunityPage.likedWorkoutIds.contains(activity.id),
          (isLiked) {
           setState(() {
          if (isLiked) {
            CommunityPage.likedWorkoutIds.add(activity.id!);
            saveWorkout(activity);
            ++activity.numberOfSaves;
            workoutController.updateWorkout(activity);
          } else {
            CommunityPage.likedWorkoutIds.remove(activity.id);
            unsaveWorkout(activity);
            --activity.numberOfSaves;
            workoutController.updateWorkout(activity);
          }
        });
      },
        formatTimestamp(activity.timestamp)
    );

  }

Future<void> saveWorkout(Workout activity) async {
  User_model user = userSingleton.getUser();
  await userController.saveWorkout(
      user.id, activity.id);
}
Future<void> unsaveWorkout(Workout activity) async {
  User_model user = userSingleton.getUser();
  await userController.unsaveWorkout(
      user.id, activity.id);
}

   String formatTimestamp(DateTime postTime) {
     DateTime currentTime = DateTime.now();
     Duration difference = currentTime.difference(postTime);

     if (difference.inSeconds < 60) {
       return 'Just now';
     } else if (difference.inMinutes < 60) {
       return '${difference.inMinutes} m';
     } else if (difference.inHours < 24) {
       return '${difference.inHours} h';
     } else if (difference.inDays < 7) {
       return '${difference.inDays} d';
     } else {
       return DateFormat.yMd().format(postTime);
     }
   }





}
