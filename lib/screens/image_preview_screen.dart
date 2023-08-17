import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  ImagePreviewScreen({super.key, required this.file});
  XFile file;
  @override
  Widget build(BuildContext context) {
    File picture = File(file.path);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text("Image Preview"),
                )
              ],
            ),
            Center(
              child: Image.file(picture),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[800],
                ),
                child: const Text(
                  "Analyze",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
