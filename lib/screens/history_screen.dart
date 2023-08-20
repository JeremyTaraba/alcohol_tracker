import 'package:flutter/material.dart';

import '../util/bottom_nav.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("History of drinks here"),
      ),
      bottomNavigationBar: bottomNav(
        selectedIndex: 2,
      ),
    );
  }
}
