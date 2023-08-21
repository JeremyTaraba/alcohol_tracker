import 'package:alcohol_tracker/screens/camera_screen.dart';
import 'package:alcohol_tracker/util/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: Text("Drink Trackr", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: Colors.lightBlueAccent, width: 3)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Date and time picker but only for dates we have in the database",
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 350,
                width: 350,
                color: Colors.lightBlueAccent,
                child: Text("Graph for alcohol consumption"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 150,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: Colors.lightBlueAccent, width: 3)),
                child: Text("Alcohol consumption assessment text box"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(selectedIndex: selectedIndex),
    );
  }
}
