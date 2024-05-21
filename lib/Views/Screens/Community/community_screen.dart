//create am empty screen for now

import 'package:flutter/material.dart';
import '../main_page_screen.dart';


class  CommunityPage extends StatefulWidget {

  @override
  _communityPage createState() => _communityPage();
}

class _communityPage  extends State< CommunityPage> {

  @override
  void initState() {
    super.initState();
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
    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
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
   // _searchQuery = query;
    });
  //  filterWorkouts(query);
    },
    ),
    ),
    /*Expanded(
    child: ListView.builder(
    itemCount: filteredWorkouts.length,
    itemBuilder: (context, index) {
    Workout workout = filteredWorkouts[index];
    return workout_widget.customcardWidget(
    workout,
    false,
    context,
    (Workout workout, bool liked) {
    setState(() {
    if (liked) {
    savedWorkouts.add(workout);
    } else {
    savedWorkouts.remove(workout);
    }
    filteredsavedWorkouts = List.from(savedWorkouts);
    }
    );
    },
    );
    },
    ),
    ),*/
    ],
    ),


    );
  }
}