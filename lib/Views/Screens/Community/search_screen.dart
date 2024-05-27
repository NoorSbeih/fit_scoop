//create am empty screen for now

import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:fit_scoop/Views/Screens/Community/community_workout_widget.dart';
import 'package:fit_scoop/Views/Widgets/usersCards_widget.dart';
import 'package:flutter/material.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/searchWorkoutWidget.dart';
import 'community_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  _searchPage createState() => _searchPage();
}

class _searchPage extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<User_model> users = [];
  List<Workout> workouts = [];
  UserSingleton userSingleton = UserSingleton.getInstance();
  UserController userController = UserController();
   List<String> likedWorkoutIds = [];
  late String _searchQuery = '';

  Map<String, List<Workout>> workoutForUsers = {};


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
    fetchAllWorkout();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  void fetchData() async {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model currentUser = userSingleton.getUser();
    UserController controllor = UserController();
    users = await controllor.getAllUsers();
    users.removeWhere((user) => user.id == currentUser.id);
    for (User_model user in users) {
      workoutForUsers[user.id] =   [];
    }

  }
  Future<User_model?> fetchUser(Workout activity) async {
    UserController controller = UserController();
    User_model? user = await controller.getUser(activity.creatorId);
    return user;
  }

  void fetchAllWorkout() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      User_model currentUser = userSingleton.getUser();
      likedWorkoutIds=currentUser.savedWorkoutIds;
      WorkoutController controller = WorkoutController();
      workouts = await controller.getAllWorkouts();
      workouts.removeWhere((workout) => workout.creatorId == currentUser.id);
      for (Workout workout in workouts) {
        String creatorId = workout.creatorId;
        if (workoutForUsers.containsKey(creatorId)) {
          workoutForUsers[creatorId]!.add(workout);
        }
      }

    } catch (e) {
      print('Error fetching data: $e');
      // Handle error if needed
    }
  }

  late List<User_model> filteredUsers = [];

  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = [];
      } else {
        filteredUsers = users
            .where((users) =>
                users.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  late List<Workout> filteredWorkouts = [];

  void filterWorkouts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredWorkouts = [];
      } else {
        filteredWorkouts = workouts
            .where((workouts) =>
                workouts.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> saveWorkout(Workout activity) async {
    User_model user = userSingleton.getUser();
    await userController.saveWorkout(user.id, activity.id);
  }

  Future<void> unsaveWorkout(Workout activity) async {
    User_model user = userSingleton.getUser();
    await userController.unsaveWorkout(user.id, activity.id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFF2C2A2A),
          appBar: AppBar(
            backgroundColor: Color(0xFF2C2A2A),
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              dividerColor: Color(0xFF2C2A2A),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              indicatorColor: Color(0xFF0dbab4),
              tabs: const [
                Tab(text: 'USERS'),
                Tab(text: ' WORKOUTS'),
              ],
            ),
            iconTheme: const IconThemeData(
              color: Color(0xFF0dbab4), // Change the drawer icon color here
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                      child: TextField(
                        //controller: _savedWorkoutsSearchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search...',
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
                            _searchQuery = query;
                          });
                          filterUsers(query);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          User_model user = filteredUsers[index];
                          int? num=workoutForUsers[user.id]?.length;
                          return UsersCardsWidget.userWidget(
                                    user, num!, context);

                        },
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                      child: TextField(
                        //controller: _savedWorkoutsSearchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search...',
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
                            _searchQuery = query;
                          });
                          filterWorkouts(query);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredWorkouts.length,
                        itemBuilder: (context, index) {
                          Workout workout = filteredWorkouts[index];
                              String creatorID=workout.creatorId;
                          User_model user = users.firstWhere(
                                (user) => user.id == creatorID,
                            orElse: () => User_model(id: '', name: 'Unknown User', email: ''),
                          );

                          return CommunitySearchWorkoutWidget(
                                  workout: workout,
                                  context: context,
                                  user: user,
                                  isLiked: likedWorkoutIds.contains(workout.id), // Initialize with a default value or fetch the actual value
                                  onLikedChanged: (isLiked) {
                                    setState(() {
                                      if (isLiked) {
                                        saveWorkout(workout);
                                        ++workout.numberOfSaves;
                                        WorkoutController workoutController = WorkoutController();
                                        workoutController.updateWorkout(workout);
                                      } else {
                                        unsaveWorkout(workout);
                                        --workout.numberOfSaves;
                                        WorkoutController workoutController = WorkoutController();
                                        workoutController.updateWorkout(workout);
                                      }
                                    });
                                  },
                                );
                              },
                                ),
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
