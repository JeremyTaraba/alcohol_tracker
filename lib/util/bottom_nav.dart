import 'package:alcohol_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/camera_screen.dart';

class bottomNav extends StatefulWidget {
  bottomNav({required this.selectedIndex});
  int selectedIndex;

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  void onItemTap(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    if (index == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CameraScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.indigo[800],
      selectedItemColor: Colors.white,
      currentIndex: widget.selectedIndex,
      onTap: onItemTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb),
          label: 'Tips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera),
          label: 'Camera',
        ),
      ],
    );
  }
}
