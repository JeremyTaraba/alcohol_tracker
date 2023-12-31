import 'package:alcohol_tracker/screens/home_screen.dart';
import 'package:alcohol_tracker/screens/signup_screen.dart';
import 'package:alcohol_tracker/util/buttons.dart';
import 'package:alcohol_tracker/util/firebase_info.dart';
import 'package:alcohol_tracker/util/objects.dart';
import 'package:alcohol_tracker/util/user_info.dart';

import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../util/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";

  String password = "";

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool loadedScreen = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    loadedScreen = true;

    return Container(
      color: Colors.lightBlue,
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Hero(
                tag: 'bg',
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/blue_drink_pour.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.5),
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 5),
                child: AnimatedContainer(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)),
                  ),
                  duration: const Duration(seconds: 2),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 25, top: 50),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          style: kTextFieldFont(),
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration().copyWith(hintText: "Email"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 25.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                          },
                          style: kTextFieldFont(),
                          autocorrect: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: kTextFieldDecoration().copyWith(hintText: "Password"),
                        ),
                      ),
                      LoginButton(onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if (user == null) {
                            return;
                          }

                          user_Info_Name = await getCurrentUsername();
                          user_Info_Gender = await getGender();
                          String date = DateTime.now().subtract(Duration(days: DateTime.now().weekday)).toString().split(" ")[0];
                          user_Info_weeklyLog = await getWeeklyLog(date);
                          user_Info_drinksInAWeek = await getDrinksInWeek(date);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        } catch (e) {
                          mySnackBar(e.toString().split(']')[1], context);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }),
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
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
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
            ],
          ),
        ),
      ),
    );
  }
}
