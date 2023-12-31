import 'package:alcohol_tracker/screens/login_register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AssetImage backgroundImage = const AssetImage("images/blue_drink_mixing.jpg");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alcohol Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: LoginRegisterScreen(
        backgroundImage: backgroundImage,
      ),
    );
  }
}
