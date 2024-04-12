import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_scoop/Controllers/register_controller.dart';
import 'package:fit_scoop/Views/Screens/register_screen.dart';
import 'package:fit_scoop/Views/Screens/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/login_controller.dart';
import '../../Models/user_model.dart';

import '../../Services/authentication_service.dart';
import '../../Services/email.dart';
import '../../Services/Database Services/user_data_service.dart';


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
  }


  @override
  Widget build(BuildContext context) {
    print("HHHH");
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
                  print("Forgot Password tapped");
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
                    print('Sign in button pressed');
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


                    if(eV.validateEmail(email)=="" && !password.isEmpty) {
                      LoginController loginController = LoginController();
                      loginController.signInWithEmailAndPassword(
                          email, password)
                          .then((user) {
                        if (user != null) {
                          print('User logged in successfully:');
                          // Proceed with your app logic after successful login
                          // loginController.getUserData(user.uid);
                          final UserDataService _userDataService = UserDataService();
                          _userDataService.getUserData(email);
                        } else {
                          print('User authentication failed.');
                          // Handle failed authentication
                        }
                      });
                    }
                  },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF0FE8040)),
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
                  'SIGN IN',
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
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  print("hi");
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF0316FF6)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      );
                    },
                  ),
                ),
                icon: const Icon(Icons.facebook,color: Colors.white),
                label: const Text('SIGN IN WITH FACEBOOK' ,style: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  print("SIGN IN WITH GOOGLE");
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
                icon: Image.asset('images/google.jpg', width: 24, height: 24),
                label: const Text(
                  'SIGN IN WITH GOOGLE',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
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
                  "Don't have an Account? SIGN UP",
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
