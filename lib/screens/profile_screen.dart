import 'package:flutter/material.dart';

import '../util/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Your profile here"),
      ),
      bottomNavigationBar: bottomNav(
        selectedIndex: 0,
      ),
    );
  }
}
