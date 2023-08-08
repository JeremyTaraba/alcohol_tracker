import 'package:flutter/material.dart';

InputDecoration kTextFieldDecoration() {
  return InputDecoration(
    contentPadding: EdgeInsets.all(10),
    filled: true,
    fillColor: Colors.grey[200],
    hintText: "Password",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

TextStyle kTextFieldFont() {
  return const TextStyle(fontSize: 22);
}
