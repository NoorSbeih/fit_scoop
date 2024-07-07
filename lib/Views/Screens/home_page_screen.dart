import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

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
      backgroundColor: Color(0xFF2C2A2A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: deviceWidth(context) * 1.4),
          Padding(
            padding: EdgeInsets.only(
              left: deviceWidth(context) * 0.05,
              right: deviceWidth(context) * 0.05,
            ),
              child:Image.asset(
                'images/FITscoop2.png',
                height: deviceHeight(context) * 0.2, // Adjust the height as needed
                width: deviceWidth(context) * 0.8, // Adjust the width as needed
                fit: BoxFit.fitWidth,
              ),
          ),
          Padding(
            padding: EdgeInsets.only(left: deviceWidth(context) * 0.05),
            child: const Text(
              "Your Daily Dose of Fitness",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'BebasNeues',
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(

                  right: deviceWidth(context) * 0.08,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    //print('Sign up');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Register()), // Replace SecondPage() with the desired page widget
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF00DBAB4)), // Change color to blue
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust border radius here
                      ),
                    ),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 60)),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF2C2A2A),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(

                  left: deviceWidth(context) * 0.08
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Corrected function body
                    //print('Sign in');

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF2C2A2A)), // Change color to blue
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust border radius here
                      ),
                    ),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 60)),
                  ),
                  child: const Text(
                    'Sign in >',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
