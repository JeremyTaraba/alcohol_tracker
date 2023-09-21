import 'package:alcohol_tracker/screens/login_screen.dart';
import 'package:alcohol_tracker/screens/signup_screen.dart';
import 'package:alcohol_tracker/util/buttons.dart';
import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key, required this.backgroundImage});
  final AssetImage backgroundImage;

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("images/blue_drink_mixing_background.jpg"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/blue_drink_mixing_background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Hello",
                        style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Welcome to Drink Trackr",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 400,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoginButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SignUpButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
