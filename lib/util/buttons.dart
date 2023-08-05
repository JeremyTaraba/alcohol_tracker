import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.backgroundColor,
      required this.title,
      required this.onPressed,
      required this.textColor,
      this.horizontalPadding = 110});

  final Color? backgroundColor;
  final String title;
  final void Function() onPressed;
  final Color? textColor;
  double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 10,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 32,
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  SignUpButton({required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      backgroundColor: Colors.white,
      title: "Sign up",
      onPressed: onPressed,
      textColor: Colors.indigo[800],
      horizontalPadding: 95,
    );
  }
}

class LoginButton extends StatelessWidget {
  LoginButton({required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      backgroundColor: Colors.indigo[800],
      title: "Login",
      onPressed: onPressed,
      textColor: Colors.white,
    );
  }
}
