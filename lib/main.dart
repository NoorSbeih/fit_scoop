import 'package:firebase_core/firebase_core.dart';
import 'package:fit_scoop/Views/Screens/main_page_screen.dart';
import 'package:flutter/material.dart';
import 'Views/Screens/home_page_screen.dart';
import 'Views/Screens/login_screen.dart';
import 'Views/Screens/register_screen.dart';
import 'Controllers/workout_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBXWcnXjHZZh_mOf-ecwAne3lMwFqihMS8',
      appId: '1:737437055403:android:dac3a4f9d5a141cf26baee',
      messagingSenderId: '737437055403',
      projectId: 'fitscoop-eac87',
      storageBucket: 'fitscoop-eac87.appspot.com',
  ),
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Define your custom behavior here
          // Returning true allows the app to be popped
          // Returning false prevents the app from being popped
          return await _onWillPop(context);
        },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitscoop',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '',),
    ),


    );
  }
}
Future<bool> _onWillPop(BuildContext context) async {
  // Show a dialog asking the user if they want to exit the app
  bool shouldExit = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Exit App'),
      content: const Text('Are you sure you want to exit the app?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  return shouldExit;
}

