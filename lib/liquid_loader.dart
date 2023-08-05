import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

Widget liquidLoader(double ticker) {
  return LiquidLinearProgressIndicator(
    value: ticker, // Defaults to 0.5.
    valueColor: AlwaysStoppedAnimation(
        Colors.lightBlueAccent), // Defaults to the current Theme's accentColor.
    backgroundColor:
        Colors.yellow, // Defaults to the current Theme's backgroundColor.
    borderColor: Colors.yellow,
    borderWidth: 5.0,
    borderRadius: 12.0,
    direction: Axis
        .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
    center: Hero(
      tag: "logo",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("images/logo1.png"), fit: BoxFit.fill),
            ),
          ),
          Text("${(ticker * 100).toInt()}%"),
        ],
      ),
    ),
  );
}
