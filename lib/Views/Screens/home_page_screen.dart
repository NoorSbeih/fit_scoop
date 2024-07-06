import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          SizedBox(height: deviceWidth(context) * 0.5),
          Padding(
            padding: EdgeInsets.only(left: deviceWidth(context) * 0.004),
              child:SvgPicture.asset(
                'images/FITscoop2.svg',
                color: Color(0xFF0dbab4),
                height: deviceHeight(context) * 0.5, // Adjust the height as needed
                //fit: BoxFit.fitWidth,
              ),
          ),
          Padding(
            padding: EdgeInsets.only(left: deviceWidth(context) * 0.08),
            child: const Text(
              "Your Daily Dose of Fitness",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'BebasNeues',
              ),
            ),
          ),
          const SizedBox(height: 60),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
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
                padding: const EdgeInsets.all(10.0),
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
                        const Color(0xFF00DBAB4)), // Change color to blue
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 60)),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF2C2A2A),
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
