import 'package:alcohol_tracker/screens/signup_screen.dart';
import 'package:alcohol_tracker/util/buttons.dart';

import 'package:flutter/material.dart';

import '../util/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 25, top: 50),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      kTextFieldDecoration().copyWith(hintText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 25.0),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration:
                      kTextFieldDecoration().copyWith(hintText: "Password"),
                ),
              ),
              LoginButton(onPressed: () {}),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
