import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'UI/Register.dart';

void main() async {
  print("Ba70000");
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:Color(0xFF2C2A2A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 500),
            const Padding(padding:EdgeInsets.only(left:20),
              child:Text("FitScoop. ",style:
              TextStyle(
                color: Colors.white, // Change color to blue
                fontSize: 35, // Set font size to 18
                fontWeight: FontWeight.bold, // Make text bold
                fontFamily: 'Montserrat', // Specify font family (optional)
              ),
              ),
            ),

      const Padding(padding:EdgeInsets.only(left:20),
        child:Text(
                "Your Daily Dose of Fitness",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
      ),
            const SizedBox(height: 60),
          Row(
          children: <Widget>[
            Padding(
              padding:const EdgeInsets.all(15),
              child:ElevatedButton(
                onPressed: () {
                  print('Sign up');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()), // Replace SecondPage() with the desired page widget
                  );

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)), // Change color to blue
                  fixedSize: MaterialStateProperty.all<Size>(const Size(150, 60)),
                ),
                child: const Text('Sign up',
                  style:
                  TextStyle(
                    fontSize: 20,
                    color:Color(0xFF2C2A2A),

                  ),),
              ),
            ),
            Padding(
              padding:const EdgeInsets.all(10.0),
              child:ElevatedButton(
                onPressed: () {
                  // Corrected function body
                  print('Sign in');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)), // Change color to blue
                  fixedSize: MaterialStateProperty.all<Size>(const Size(150, 60)),
                ),

                child: const Text('Sign in',
                  style:
                  TextStyle(
                    fontSize: 20,
                    color:Color(0xFF2C2A2A),

                  ),),
              ),
            ),


          ],
         ),


          ],
        ),



    );
  }
}
