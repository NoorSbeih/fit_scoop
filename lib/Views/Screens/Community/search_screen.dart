//create am empty screen for now

import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:fit_scoop/Views/Widgets/usersCards_widget.dart';
import 'package:flutter/material.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../../../Models/workout_model.dart';


class SearchPage extends StatefulWidget {
  @override
  _searchPage createState() => _searchPage();
}

class _searchPage extends State<SearchPage>
    with SingleTickerProviderStateMixin {
    late TabController _tabController;
     List<User_model> users=[];
    late String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void fetchData() async {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model currentUser = userSingleton.getUser();
    UserController controllor=UserController();
     users= await controllor.getAllUsers();
     users.removeWhere((user) => user.id == currentUser.id);
    // setState(() {
    //   filteredUsers= users;
    //
    // });
  }

    Future<int> fetchWorkouts(String id) async {
      int num = 0;
      try {
        WorkoutController controller = WorkoutController();
        List<Workout> workouts = await controller.getWorkoutsByUserId(id);
        num = workouts.length; // Set num to the number of workouts fetched
      } catch (e) {
        print('Error fetching data: $e');
        // Handle error if needed
      }
      return num;
    }

    late List<User_model> filteredUsers = [];

    void filterWorkouts(String query) {
      setState(() {
        if (query.isEmpty) {
          filteredUsers =[];
        } else {
          filteredUsers = users
              .where((users) =>
              users.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      });
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
              child: TextField(
                //controller: _savedWorkoutsSearchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
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
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  User_model user = filteredUsers[index];
                  return FutureBuilder<int>(
                    future: fetchWorkouts(user.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return UsersCardsWidget.userWidget(
                          user,
                          0,context // Placeholder value while loading
                        );
                      } else if (snapshot.hasError) {
                        return UsersCardsWidget.userWidget(
                          user,
                          0, context// Placeholder value in case of error
                        );
                      } else {
                        int num = snapshot.data ?? 0;
                        return UsersCardsWidget.userWidget(
                          user,
                          num,
                          context
                        );
                      }
                    },
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}


