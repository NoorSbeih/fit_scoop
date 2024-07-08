import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_scoop/Views/Screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../Services/email.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: ResetPasswordForm(title: 'Reset Password'),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  final String title;
  const ResetPasswordForm({Key? key, required this.title});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  String emailErrorText = '';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2A2A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color(0xFF00DBAB4),

          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left:16.0,right:16.0,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                'Account Recovery',
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Text(
                'Enter the email address associated with your account '
                    'and we\'ll send you a link to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration:  InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                errorText: emailErrorText.isNotEmpty ? emailErrorText : null,
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (_) {
                setState(() {
                  emailErrorText = '';
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(

              onPressed: () async {
                String email = _emailController.text.trim();
                EmailValidator eV=new EmailValidator();
                if (eV.validateEmail(email)!="") {
                  setState(() {
                    emailErrorText =eV.validateEmail(email);
                  });
                  return;
                }
                if(eV.validateEmail(email)==""){
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password reset email sent. Check your inbox.'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to send password reset email: $e'),
                      ),
                    );
                  }
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
              child: const Text('Reset Password',
                style: TextStyle(fontSize: 20,color: Color(0xFF2C2A2A))),
            ),
          ],
        ),
      ),
    );
  }
}
