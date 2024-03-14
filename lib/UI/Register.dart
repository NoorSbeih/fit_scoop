
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterPage(title: ''),
    );
  }
}


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int selectedRadio=0;

  @override
  void initState() {
    super.initState();
    // Initialize the selected radio button with a default value
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:Color(0xFF2C2A2A),
      body: Container(
    child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Join The Club ",style:
              TextStyle(
                color: Colors.white, // Change color to blue
                fontSize: 25, // Set font size to 18
                fontWeight: FontWeight.bold, // Make text bold
                fontFamily: 'Roboto', // Specify font family (optional)
              ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom:60.0), // Add padding from the bottom only
              child: Text(
                "The ultimate fitness application",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),


            const Padding(
              padding:EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(color:Colors.white)
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child:TextField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color:Colors.white)
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child:TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color:Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0), // Add horizontal padding

              child: Text(
                'Unit of Measure',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.all(20.0),
              child:ElevatedButton(
                onPressed: () {
                  // Corrected function body
                  print('Register button pressed');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)), // Change color to blue
                  fixedSize: MaterialStateProperty.all<Size>(const Size(300, 60)),
                ),
                child: const Text('Join Us',
                  style:
                  TextStyle(
                    fontSize: 20,
                    color:Color(0xFF2C2A2A),

                  ),),
              ),
            ),
          ],
        ),
      ),

     );





  }
}




