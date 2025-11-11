import 'package:flutter/material.dart';
import '../components/btn.dart';
import '../constants.dart';
import '../components/pass_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String? email;
  String? password;
  FirebaseAuth get _auth =>
      FirebaseAuth.instance; // Firebase Auth instance (lazy)

  Future<void> loginUser(String email, String password) async {
    try {
      if (isValidEmail(email) && isValidPassword(password)) {
        print('Valid email and password');
      } else {
        logInFailed();
        return;
      }
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Navigate to chat screen or other screen after successful login
        Navigator.pushNamed(context, 'chat_screen');
      }
    } catch (error) {
      logInFailed();
      print('Login Error: $error');
    }
  }

  void logInFailed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Login Failed',
            style: TextStyle(color: Colors.red.shade400),
          ),
          content: Text(
            'Please check your email and password.',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.red.shade400)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> isEmptyFields(String? email, String? password) async {
    if (email == null ||
        email.isEmpty ||
        password == null ||
        password.isEmpty) {
      logInFailed();
    } else {
      await loginUser(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        //change spinner color
        progressIndicator: CircularProgressIndicator(color: Colors.black),
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(height: 48.0),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email.',
                ),
              ),
              SizedBox(height: 8.0),
              PassField(
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
              ),
              SizedBox(height: 24.0),
              Hero(
                tag: 'login_btn',
                child: Btn(
                  text: 'Log In',
                  onPressed: () async {
                    //Implement login functionality.
                    setState(() {
                      showSpinner = true;
                    });
                    await isEmptyFields(email, password);
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  color: Colors.lightBlueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Basic email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    // Password must be at least 6 characters long
    return password.length >= 6;
  }
}
