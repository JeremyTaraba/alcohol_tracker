import 'package:alcohol_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../util/buttons.dart';
import '../util/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 25, top: 50),
                child: TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: kTextFieldDecoration().copyWith(hintText: "Name"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 25),
                child: TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration:
                      kTextFieldDecoration().copyWith(hintText: "Email"),
                  validator: (String? value) {
                    return (value != null &&
                            value.contains('@') &&
                            value.contains('.'))
                        ? null
                        : "Enter a valid email";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 25.0),
                  child: TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: kTextFieldDecoration(),
                    validator: (String? value) {
                      return (value != null && value.length > 5)
                          ? null
                          : "Must be at least 6 characters";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 25.0),
                child: TextFormField(
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: kTextFieldDecoration()
                      .copyWith(hintText: "Confirm Password"),
                  validator: (String? value) {
                    return (value == password)
                        ? null
                        : "Passwords do not match";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SignUpButton(onPressed: () {
                print(password);
                print(confirmPassword);
              }),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text(
                            "Login",
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
    ;
  }
}
