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
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                )),
            Center(
              child: Image.file(picture),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Analyze"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
