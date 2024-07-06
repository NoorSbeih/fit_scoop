
import 'package:fit_scoop/Views/Screens/register_screen.dart';
import 'package:fit_scoop/Views/Screens/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Controllers/exercise_controller.dart';
import '../../Controllers/login_controller.dart';

import '../../Models/bodyPart.dart';
import '../../Models/user_singleton.dart';
import '../../Services/authentication_service.dart';
import '../../Services/email.dart';
import 'main_page_screen.dart';
import 'Workout/current_workout_screen.dart';


class Login extends StatelessWidget {
  const Login({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: ''),
    );
  }
}


class LoginPage extends StatefulWidget {

  const LoginPage({super.key, required this.title});
  final String title;
  static List<BodyPart> parts=[];


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String emailErrorText = '';
  String _passwordErrorText = '';
  bool passwordVisible=false;


  @override
  void initState() {
    super.initState();
    passwordVisible=false;
    fetchBodyParts();
  }



  Future<void> fetchBodyParts() async {
    try {
      ExerciseController controller = ExerciseController();
      List<BodyPart> equipments = await controller.getAllBoyImages();
      setState(() {
        LoginPage.parts = equipments;
      });

    } catch (e) {
      //print('Error fetching data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Welcome Back ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Text(
                "The ultimate fitness application",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                  errorText: emailErrorText.isNotEmpty ? emailErrorText : null,
                ),
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
                onChanged: (_) {
                  setState(() {
                    emailErrorText = '';
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 25,left: 8),
              child:TextField(
                obscureText: !passwordVisible,
                decoration:  InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color:Colors.white, fontSize: 14),
                  errorText: _passwordErrorText.isNotEmpty ? _passwordErrorText : null,
                  suffixIcon: IconButton(
                  icon: Icon(passwordVisible? Icons.visibility: Icons.visibility_off),
                  onPressed: () {
                   setState(() {
                   passwordVisible = !passwordVisible;
                   });
                   },
                  ),
    ),
                style: const TextStyle(color: Colors.white),
                controller: _passwordController,
                onChanged: (_) {
                  setState(() {
                 _passwordErrorText = '';
      });
    },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Add your navigation logic here
                  //print("Forgot Password tapped");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await refreshIdToken();
                    //print('Sign in button pressed');
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    if (password.isEmpty ||  email.isEmpty) {
                      if (password.isEmpty) {
                        setState(() {
                          _passwordErrorText = 'Please enter your password';
                        });
                      }
                      if(email.isEmpty){
                        setState(() {
                          emailErrorText = 'Please enter your email';
                        });
                      }
                    }

                    EmailValidator eV=new EmailValidator();
                    if (eV.validateEmail(email)!="") {
                      setState(() {
                        emailErrorText =eV.validateEmail(email);
                      });
                      return;
                    }


                    if (eV.validateEmail(email) == "" && !password.isEmpty) {
                      LoginController loginController = LoginController();
                      loginController.signInWithEmailAndPassword(email, password).then((user) async {
                        if (user != null) {
                          if (await loginController.getUserBodyMetric() == null) {
                            //print("empty");
                          } else {



                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()), // Replace HomePage() with the desired page widget
                            );
                          }
                        } else {
                          //print('User authentication failed.');
                          setState(() {
                            if (user == null) {
                              emailErrorText = 'Email not found';
                            } else {
                              _passwordErrorText = 'Incorrect password';
                            }
                          });
                        }
                      });
                    }
                  },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF00DBAB4)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      );
                    },
                  ),
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

            const Padding(padding:EdgeInsets.all(8.0),
                child:Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                )

            ),
            Padding(
              padding:const EdgeInsets.only(left:8,right:8,bottom:10),
              child:ElevatedButton(
                onPressed: () {
                  //print('Register button pressed');
                },

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0316FF6)), // Change color to blue
                  fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      );
                    },
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.facebook, // Add your icon here
                      color: Colors.white, // Color of the icon
                    ),
                    SizedBox(width: 8), // Adjust the spacing between the icon and text
                    Text('Sign up with facebook',
                      style:
                      TextStyle(
                        fontSize: 18,
                        color:Colors.white,
                      ),),
                  ],
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8,right:8),
              child: ElevatedButton(
                onPressed: () async {
                  //print("SIGN IN WITH GOOGLE");
                  AuthenticationService auth= AuthenticationService();
                  auth.signUpWithGoogle(context, mounted);

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      );
                    },
                  ),
                ),
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'images/icons8-google.svg',
                      width: 24,
                      height: 24,
                    ), // Add your icon here
                    const SizedBox(width: 8), // Adjust the spacing between the icon and text
                    const Text('Sign up with GOOGLE',
                      style:
                      TextStyle(
                        fontSize: 18,
                        color:Color(0xFF2C2A2A),

                      ),),
                  ],
                ),

              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },


              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Don't have account? Sign up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}


