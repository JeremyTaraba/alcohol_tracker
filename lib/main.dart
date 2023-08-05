import 'package:alcohol_tracker/home_screen.dart';
import 'package:alcohol_tracker/launch_screen.dart';
import 'package:alcohol_tracker/screens/login_register_screen.dart';
import 'package:alcohol_tracker/screens/login_screen.dart';
import 'package:alcohol_tracker/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alcohol Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: LoginRegisterScreen(),
    );
  }
}
