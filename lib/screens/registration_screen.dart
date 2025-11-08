import 'package:flutter/material.dart';
import '../components/Btn.dart';
import '../constants.dart';
import '../components/pass_field.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(height: 48.0),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ), // Using kTextFieldDecoration for email input
            ),
            SizedBox(height: 8.0),
            PassField(), // Using the PassField component for password input
            SizedBox(height: 24.0),
            Hero(
              tag: 'register_btn',
              child: Btn(
                text: 'Register',
                onPressed: () {
                  //Implement registration functionality.
                },
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
