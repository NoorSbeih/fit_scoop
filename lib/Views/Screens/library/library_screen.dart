import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Models/user_singleton.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import 'package:flutter/material.dart';

import '../../../Controllers/workout_controller.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/bottom_navbar.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LibraryScreen(),
    );
  }
}

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreen();
}

class _LibraryScreen extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Workout> workouts = [];
  List<Workout> savedWorkouts = [];
  late Future<List<Workout>> savedWorkoutsFuture;
  late TextEditingController _myWorkoutsSearchController;
  late TextEditingController _savedWorkoutsSearchController;
  late String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
    savedWorkoutsFuture = SavedWorkout();
    _myWorkoutsSearchController = TextEditingController();
    _savedWorkoutsSearchController = TextEditingController(); // Add this line
  }

  late List<Workout> filteredWorkouts = [];

  late List<Workout> filteredsavedWorkouts = [];

  void filterWorkouts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredWorkouts = List.from(workouts);
      } else {
        filteredWorkouts = workouts
            .where((workout) =>
                workout.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void filtersavedWorkouts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredsavedWorkouts = List.from(savedWorkouts);
      } else {
        filteredsavedWorkouts = savedWorkouts
            .where((workout) =>
                workout.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      User_model user = userSingleton.getUser();

      if (user != null && user.id != null) {
        String userId = user.id;
        WorkoutController controller = WorkoutController();
        workouts = await controller.getWorkoutsByUserId(userId);
        setState(() {
          filteredWorkouts = workouts;
        });
      } else {
        print('User or user ID is null.');
      }
    } catch (e) {
      print('Error getting workouts by user ID: $e');
      throw e;
    }
  }

  Future<List<Workout>> SavedWorkout() async {
    try {
      print("hii");
      UserSingleton userSingleton = UserSingleton.getInstance();
      User_model user = userSingleton.getUser();

      List<String> ids = user.savedWorkoutIds;
      if (user != null && user.id != null) {
        WorkoutController controller = WorkoutController();
        savedWorkouts.clear(); // Clear the list before adding new items
        for (int i = 0; i < ids.length; i++) {
          Workout? workout = await controller.getWorkout(ids[i]);
          print(workout?.id);
          savedWorkouts.add(workout!);
        }
        setState(() {
          filteredsavedWorkouts = savedWorkouts;
        });

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

  @override
  void dispose() {
    _tabController.dispose();
    _myWorkoutsSearchController.dispose();
    _savedWorkoutsSearchController.dispose();
    super.dispose();
  }

  int _selectedIndex = 3;

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF2C2A2A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2C2A2A),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            dividerColor: Color(0xFF2C2A2A),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicatorColor: Color(0xFF0dbab4),
            tabs: const [
              Tab(text: 'MY WORKOUTS'),
              Tab(text: 'SAVED WORKOUTS'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                    child: TextField(
                      controller: _savedWorkoutsSearchController,
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
                        filtersavedWorkouts(query);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredWorkouts.length,
                      itemBuilder: (context, index) {
                        Workout workout = filteredWorkouts[index];
                        return workout_widget.customcardWidget(
                          workout,
                          false,
                          context,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                    child: TextField(
                      controller: _savedWorkoutsSearchController,
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
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                          print(_searchQuery);
                        });
                        filtersavedWorkouts(query);
                      },
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Workout>>(
                      future: savedWorkoutsFuture,
                      // Use the savedWorkoutsFuture variable
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<Workout> filteredSavedWorkouts =
                              snapshot.data ?? [];
                          if (_searchQuery.isNotEmpty) {
                            filteredSavedWorkouts = filteredSavedWorkouts
                                .where((workout) => workout.name
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()))
                                .toList();
                          }
                          if (filteredSavedWorkouts.isEmpty) {
                            return Text('No saved workouts');
                          } else {
                            return ListView.builder(
                              itemCount: filteredSavedWorkouts.length,
                              itemBuilder: (context, index) {
                                Workout workout = filteredSavedWorkouts[index];
                                return workout_widget.customcardWidget(
                                  workout,
                                  false,
                                  context,
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: MyNavigationBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _onNavBarItemTapped,
        ),
      ),
    );
  }
}

class WorkoutSearchDelegate extends SearchDelegate<String> {
  final List<Workout> workouts;

  WorkoutSearchDelegate(this.workouts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results UI here
    return Center(
      child: Text('Search results for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Workout> suggestionList = query.isEmpty
        ? []
        : workouts
            .where((workout) =>
                workout.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final workout = suggestionList[index];
        return ListTile(
          title: Text(workout.name),
          onTap: () {
            close(context, workout.name);
          },
        );
      },
    );
  }
}
