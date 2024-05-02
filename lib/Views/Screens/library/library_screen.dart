import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                  onPressed: () {
                    // Add functionality for the first search icon
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
                itemCount: 5, // Replace with the actual number of items
                itemBuilder: (context, index) {
                  // Replace the values below with your actual data
                  return workout_widget.customcardWidget(
                      1, "WORKOUT NAME", "2", "5",
                      false); // Use context and setState from your widget
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