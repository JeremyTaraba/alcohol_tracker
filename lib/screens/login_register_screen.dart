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
    double height = MediaQuery.of(context).size.height;
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
            Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height / 12),
                        child: const Text(
                          "Hello",
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Merriweather',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const Text(
                        "Welcome to Drink Trackr",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Merriweather',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Center(
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
