import 'package:alcohol_tracker/screens/home_screen.dart';
import 'package:alcohol_tracker/liquid_loader.dart';
import 'package:flutter/material.dart';

class launchScreen extends StatefulWidget {
  const launchScreen({super.key});

  @override
  State<launchScreen> createState() => _launchScreenState();
}

class _launchScreenState extends State<launchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2, milliseconds: 5),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return liquidLoader(animation.value);
  }
}
