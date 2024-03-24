// home_view.dart
import 'package:flutter/material.dart';
import 'home_controller.dart'; // Import the controller

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController(); // Instance of the controller

  void _logoutUser(BuildContext context) async {
    await _controller.logout(); // Use the controller to handle logic
    Navigator.of(context).pushReplacementNamed('/sign_up_view'); // Navigate after logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logoutUser(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 20),
            ),
            // Your UI components here
          ],
        ),
      ),
    );
  }
}