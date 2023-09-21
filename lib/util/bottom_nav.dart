import 'package:alcohol_tracker/screens/history_screen.dart';
import 'package:alcohol_tracker/screens/home_screen.dart';

import 'package:alcohol_tracker/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../screens/camera_screen.dart';

class bottomNav extends StatefulWidget {
  bottomNav({required this.selectedIndex});
  final int selectedIndex;

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  void onItemTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
    }
    if (index == 3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CameraScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.lightBlueAccent,
      currentIndex: widget.selectedIndex,
      onTap: onItemTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt_outlined),
          label: 'Camera',
        ),
      ],
    );
  }
}
