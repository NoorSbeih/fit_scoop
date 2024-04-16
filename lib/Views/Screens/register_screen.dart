
import 'package:fit_scoop/Controllers/register_controller.dart';
import 'package:fit_scoop/Views/Screens/page_view.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/user_model.dart';
import '../../Services/email.dart';

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
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String emailErrorText = '';
  String nameErrorText = '';
  String passwordErrorText = '';
  bool passwordVisible=false;
  String? _selectedUnitMeasure;


  @override
  void initState() {
    super.initState();
    passwordVisible=false;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
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

           Padding(
              padding: EdgeInsets.only( bottom: deviceHeight(context) * 0.06,), // Add padding from the bottom only
              child: const Text(
                "The ultimate fitness application",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),


            Padding(
              padding:EdgeInsets.all(8),
              child: TextField(
                decoration:  InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color:Colors.white,fontSize: 14),
                    errorText: nameErrorText.isNotEmpty ? nameErrorText : null,
                ),
                style: const TextStyle(color: Colors.white),
                controller: _fullNameController,
                onChanged: (_) {
                  setState(() {
                    nameErrorText = '';
                  });
                },
              ),
            ),
             Padding(
              padding: EdgeInsets.all(8.0),
              child:TextField(
                decoration:  InputDecoration(
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
                obscureText: true,
                decoration:  InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color:Colors.white, fontSize: 14),
                  errorText: passwordErrorText.isNotEmpty ? passwordErrorText : null,
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
                    passwordErrorText = '';
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                 child: Text(
                    'Unit of Measure', // Add your hint text here
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                    ),
                  ),

              ),

            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0),
               child: Row(
                  children: [
                    Radio(
                      value: "imperial",
                      groupValue:  _selectedUnitMeasure,
                      onChanged: (value) {
                        setState(() {
                          _selectedUnitMeasure= value!;
                        });
                      },
               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
               fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white; // Change the selected color
                  }
                  return Colors.transparent; // Change the unselected color
                },
              ),

                    ),

                    const Text('Imperial', style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                    ),),
                    const SizedBox(width: 20), // Adjust as needed for spacing
                    Radio(
                      value:"metric",
                      groupValue:  _selectedUnitMeasure,
                      onChanged: (value) {
                        setState(() {
                          _selectedUnitMeasure = value!;
                        });
                      },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                  return Colors.white; // Change the selected color
                  }
                    return Colors.transparent;
    },
                    ),
                    ),

                    const Text('Metric', style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                    ),),
                  ],
                )
                ),
              ],
            ),
            Padding(
              padding:const EdgeInsets.all(20.0),
              child:ElevatedButton(
                onPressed: () async {
                  String fullName=_fullNameController.text;
                  String email=_emailController.text;
                  String password=_passwordController.text;

                  if (password.isEmpty ||  email.isEmpty || fullName.isEmpty) {
                    if (password.isEmpty) {
                      setState(() {
                        passwordErrorText = 'Please enter your password';
                      });
                    }
                    if (email.isEmpty) {
                      setState(() {
                        emailErrorText = 'Please enter your email';
                      });
                    }
                    if (fullName.isEmpty) {
                      setState(() {
                        nameErrorText = 'Please enter your name';
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


                   if(eV.validateEmail(email)=="" && !password.isEmpty && !fullName.isEmpty) {
                    try {
                      SharedPreferences prefs =await SharedPreferences.getInstance() ;
                     prefs.setString('unitOfMeasure', _selectedUnitMeasure!);

                   } catch (e) {
                      print('Error initializing SharedPreferences: $e');
                        }
                        RegisterController register=RegisterController();
                         register.storeRegisterData(fullName, email, password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CustomPageView()), // Replace SecondPage() with the desired page widget
                        );
                        print('Register button pressed');
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CustomPageView()), // Replace SecondPage() with the desired page widget
                        );


                },

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0FE8040)), // Change color to blue
                  fixedSize: MaterialStateProperty.all<Size>(const Size(400, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      );
                    },
                  ),
                ),

                child: const Text('Join Us',
                  style:
                  TextStyle(
                    fontSize: 20,
                    color:Color(0xFF2C2A2A),

                  ),),
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
                  print('Register button pressed');
                },

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0316FF6)), // Change color to blue
                  fixedSize: MaterialStateProperty.all<Size>(const Size(400, 50)),
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
              padding:const EdgeInsets.only(left:8,right:8),
              child:ElevatedButton(
                onPressed: () {
                  // Corrected function body
                  print('Register button pressed');
                },

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)), // Change color to blue
                  fixedSize: MaterialStateProperty.all<Size>(const Size(400, 50)),
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
                    Text('Sign up with GOOGLE',
                      style:
                      TextStyle(
                        fontSize: 18,
                        color:Color(0xFF2C2A2A),

                      ),),
                  ],
                ),

              ),
            ),

          ],
        ),
      ),

     );

  }
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}




