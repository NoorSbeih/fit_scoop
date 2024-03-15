
import 'package:fit_scoop/Models/userRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Classes/Register.dart';

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
  UnitMeasure _selectedUnitMeasure = UnitMeasure.imperial;
 int _selectedValue = 0;

  @override
  void initState() {
    super.initState();
     _selectedValue = 0;
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


            Padding(
              padding:EdgeInsets.all(8),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(color:Colors.white,fontSize: 18)
                ),
                style: const TextStyle(color: Colors.white),
                controller: _fullNameController,
              ),
            ),
             Padding(
              padding: EdgeInsets.all(8.0),
              child:TextField(
                decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color:Colors.white,fontSize: 18)
                ),
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 25,left: 8),
              child:TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color:Colors.white, fontSize: 18),
                ),
                style: const TextStyle(color: Colors.white),
                controller: _passwordController,
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
                      fontSize: 18,
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
                      value: UnitMeasure.imperial,
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
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),),
                    const SizedBox(width: 20), // Adjust as needed for spacing
                    Radio(
                      value: UnitMeasure.metric,
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
                      fontSize: 18,
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
                onPressed: () {
                  String fullName=_fullNameController.text;
                  String email=_emailController.text;
                  String password=_passwordController.text;
                  userRegister register=userRegister();
                  register.storeRegisterData(fullName, email, password, _selectedUnitMeasure);
                  print('Register button pressed');
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
}




