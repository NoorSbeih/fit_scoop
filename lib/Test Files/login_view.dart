import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Models/signIn_versionControl.dart';
import '../Views/Screens/register_screen.dart';

GoogleSignIn _googleSignIn=GoogleSignIn(
    scopes: <String>[
      'email','https://www.googleapis.com/auth/contacts.readonly'
    ]
);


class login extends StatelessWidget {

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
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  GoogleSignInAccount? currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentUser=account;

      });
      if(currentUser!=null){
        print("User is already authenticated");
      }
    });
    _googleSignIn.signInSilently();

  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        currentUser = _googleSignIn.currentUser;
      });
    } catch (error) {
      print("Sign in error: $error");
    }
  }


  Future<void> handleSignOut() => _googleSignIn.signOut();


  Widget buildBody(){
    if(currentUser!=null){
      print("hello2");
      return Column(
        children: [
          SizedBox(height:90),
          GoogleUserCircleAvatar(identity: currentUser!),
          SizedBox(height:20),
          Center(
            child:Text(
              currentUser!.displayName ?? '', textAlign: TextAlign.center ,
              style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
          SizedBox(height:10),
          Center(
            child:Text(currentUser!.email,textAlign:TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 15),),
          ),
          SizedBox(height:60),
          const Center(
            child:Text('Welcome to FitSccop', style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center),
          ),
          SizedBox(height:40,),
          ElevatedButton(onPressed: handleSignOut, child: Text('Sign out')),
        ],
      );
    } else{
      return Column (
        children: [
          SizedBox(height: 90,),
          Center (
            child: Image.asset("assets/google_large.png", height: 200, width: 200,),
          ),
          const SizedBox(height: 40,),
          const Padding (padding: EdgeInsets.all(8.0), child: Text("Welcome to Google Authentication",
            textAlign: TextAlign.center, style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),), // Textstyle, Text, Padding
          SizedBox (height: 30),
          Center (
            child: Container (
              width: 250,
              child: ElevatedButton(
                  onPressed: handleSignIn, child:  Padding(padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Image.asset("assets/google_large.png", height: 20, width: 20,),
                      const SizedBox(width: 20,),
                      const Text("Google Sign in")
                    ],
                  ))),
            ),
          ),
        ],
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2A2A),
      body: Container(
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Add your navigation logic here
                  print("Forgot Password tapped");
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
                onPressed: () {
                  print('Sign in button pressed');
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
                //  onPressed: () {
                //    print("SIGN IN WITH GOOGLE");
                // // signInWithGoogle();
                //    handleSignIn();
                //    child:buildBody();
                //  },
                onPressed: () async {
                  print("SIGN IN WITH GOOGLE");
                  await handleSignIn();
                  setState(() {}); // This triggers a rebuild of the widget to reflect the new sign-in state
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


