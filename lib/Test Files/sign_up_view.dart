import 'package:flutter/material.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController _controller = SignUpController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _controller.signUpUser(_emailController.text, _passwordController.text, context);
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}