import 'package:flutter/material.dart';

InputDecoration kTextFieldDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[200],
    hintText: "Password",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
