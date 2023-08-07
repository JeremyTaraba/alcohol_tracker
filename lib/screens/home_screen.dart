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
            Text("Date and time picker"),
            Text("Graph for alcohol consumption"),
            Text("Alcohol consumption Assessment text box"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo[800],
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
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
      ),
    );
  }

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
