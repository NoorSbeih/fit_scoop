import 'package:firebase_core/firebase_core.dart';
import 'package:fit_scoop/Views/Screens/home_page_screen.dart';
import 'package:flutter/material.dart';

import 'Views/Screens/login_screen.dart';
import 'Views/Screens/register_screen.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: '',),

    );
  }
}