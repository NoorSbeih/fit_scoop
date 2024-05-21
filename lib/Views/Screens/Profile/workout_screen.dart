import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:fit_scoop/Views/Widgets/workout_widget.dart';

import '../../../Controllers/workout_controller.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';

class WorkoutProfile extends StatefulWidget {
  final List<Workout> workouts;
  final User_model user;

  const WorkoutProfile({super.key, required this.workouts, required this.user});

  @override
  State<WorkoutProfile> createState() => _WorkoutScreen();
}

class _WorkoutScreen extends State<WorkoutProfile> {
  late TextEditingController _myWorkoutsSearchController;
  late String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _myWorkoutsSearchController = TextEditingController();
  }

  late List<Workout> filteredWorkouts = widget.workouts;
  List<Workout> savedWorkouts = [];

  void filterWorkouts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredWorkouts = List.from(widget.workouts);
      } else {
        filteredWorkouts = widget.workouts
            .where((workout) =>
            workout.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<List<Workout>> SavedWorkout() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      User_model user = userSingleton.getUser();

      List<String> ids = user.savedWorkoutIds;
      if (user != null && user.id != null) {
        WorkoutController controller = WorkoutController();
        List<Workout> newSavedWorkouts =
        []; // Create a new list to store the workouts
        for (int i = 0; i < ids.length; i++) {
          Workout? workout = await controller.getWorkout(ids[i]);
          print("ffff");
          print(workout?.id);
          // Check if the workout already exists in savedWorkouts
          if (!widget.user.savedWorkoutIds.contains(workout?.id.toString())) {
            newSavedWorkouts.add(workout!);
          }
        }
        savedWorkouts.addAll(newSavedWorkouts);

        return savedWorkouts;
      } else {
        print('User or user ID is null.');
        return [];
      }
    } catch (e) {
      print('Error getting workouts by user ID: $e');
      throw e;
    }
  }

  bool isSaved(String? id) {

    // Check if any workout in the list has the given id
    return savedWorkouts.any((workout) => workout.id == id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2A2A),
        automaticallyImplyLeading: false,
        title: _isSearching
            ? TextField(
          controller: _myWorkoutsSearchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
              filterWorkouts(_searchQuery);
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                setState(() {
                  _myWorkoutsSearchController.clear();
                  _searchQuery = '';
                  filterWorkouts('');
                });
              },
            ),
          ),
          style: const TextStyle(color: Colors.white),
        )
            : Row(
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
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.cancel : Icons.search,
              color: Color(0xFF0dbab4),
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _myWorkoutsSearchController.clear();
                  _searchQuery = '';
                  filterWorkouts('');
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top:30),
            // Adjust the padding as needed
            child: Text(
              '${filteredWorkouts.length} WORKOUTS',
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFF0dbab4),
                fontFamily: 'BebasNeue',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredWorkouts.length,
              itemBuilder: (context, index) {
                Workout workout = filteredWorkouts[index];
                return workout_widget.customcardWidget(
                  workout,
                  isSaved(workout.id),
                  context,
                      (Workout workout, bool liked) {
                    setState(() {
                      if (liked) {
                        savedWorkouts.add(workout);
                      } else {
                        savedWorkouts.remove(workout);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


