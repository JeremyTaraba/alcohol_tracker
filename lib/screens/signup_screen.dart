import 'package:alcohol_tracker/screens/home_screen.dart';
import 'package:alcohol_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../util/buttons.dart';
import '../util/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  int checkInputFields = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 25, top: 50),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value;
                    },
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    style: kTextFieldFont(),
                    decoration:
                        kTextFieldDecoration().copyWith(hintText: "Name"),
                    validator: (String? value) {
                      return (value != null && value.isNotEmpty
                          ? null
                          : "Enter your name");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 25),
                  child: TextFormField(
                    //textformfield is used to do any sort of validation
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    style: kTextFieldFont(),
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
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      autocorrect: false,
                      style: kTextFieldFont(),
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
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    autocorrect: false,
                    style: kTextFieldFont(),
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
                SignUpButton(onPressed: () async {
                  // need to check all fields are filled out if not show a snackbar to fix fields
                  if (_formKey.currentState!.validate()) {
                    // calls all validators and checks them

                    // creating new user can fail and so need to do try and catch
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        //we got a newUser back
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    } catch (e) {
                      print(e); //prints out error message
                    }
                  }
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
      ),
    );
    ;
  }
}
