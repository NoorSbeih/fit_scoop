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
     List<Workout> workouts=[];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

    late List<Workout> filteredWorkouts = [];

    void filterWorkouts(String query) {
      setState(() {
        filteredWorkouts = workouts
            .where((workout) =>
            workout.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }


    void fetchData() async {
      try {
        UserSingleton userSingleton = UserSingleton.getInstance();
        User_model user = userSingleton.getUser();
        String userId = user.id;
        WorkoutController controller = WorkoutController();
        List<Workout> filteredWorkouts = await controller.getWorkoutsByUserId(userId); // Await the result here
        setState(() {
          workouts = filteredWorkouts;

        });
      } catch (e) {
        // Handle error
        print('Error getting workouts by user ID: $e');
        throw e;
      }
    }
  @override
  void dispose() {
    _tabController.dispose();
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
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list_alt),
                  color: Color(0xFF0dbab4),
                  onPressed: () async {
                    final String? query = await showSearch(
                      context: context,
                      delegate: WorkoutSearchDelegate(workouts),
                    );
                    if (query != null && query.isNotEmpty) {
                      filterWorkouts(query);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Color(0xFF0dbab4),
                  onPressed: () {
                    // Add functionality for the second search icon
                  },
                ),
              ],
            ),
          ],
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
          children: [
            Visibility(
              visible: _tabController.index == 0,
              maintainState: true,
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                 // var workout = workouts[index];
                  var workout = workouts[index];
                  int intensity=0;
                  if( workout.intensity=="Low"){
                    intensity=1;
                  } else  if(  workout.intensity=="Medium"){
                    intensity=2;
                  }else  if(  workout.intensity=="High"){
                    intensity=3;
                  }
                  return workout_widget.customcardWidget(
                    intensity ,
                    workout.name,
                    workout.duration,
                    workout.exercises.length.toString(),
                    false,
                  );
                },
              ),
            ),
            Center(child: Text('Tab 2 Content')),
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
