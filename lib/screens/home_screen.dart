import 'package:alcohol_tracker/screens/camera_screen.dart';
import 'package:alcohol_tracker/util/bottom_nav.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        elevation: 0,
        title: Text("Alcohol Trackr", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage("images/logo1.png"), fit: BoxFit.contain),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                "Date and time picker but only for dates we have in the database"),
            Text("Graph for alcohol consumption"),
            Text("Alcohol consumption Assessment text box"),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(selectedIndex: selectedIndex),
    );
  }
}
