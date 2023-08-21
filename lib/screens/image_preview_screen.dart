import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as imageLib;

class ImagePreviewScreen extends StatefulWidget {
  ImagePreviewScreen({super.key, required this.file});
  XFile file;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late final Interpreter interpreter;

  late Tensor inputTensor;

  late Tensor outputTensor;

  late final List<String> labels;

  late final image;

  @override
  void dispose() {
    super.dispose();
    interpreter.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTensorFlow();
    _loadLabels();
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

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
                onPressed: () {
                  // if output tensor shape [1,2] and type is float32
                  var output;

// inference
                  interpreter.run(picture, output);

// print the output
                  print(output);
                },
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

  Future<void> initTensorFlow() async {
    interpreter =
        await Interpreter.fromAsset('assets/mobilenet_v1_1.0_224_quant.tflite');

    // Get tensor input shape [1, 224, 224, 3]
    inputTensor = interpreter.getInputTensors().first;
    // Get tensor output shape [1, 1001]
    outputTensor = interpreter.getOutputTensors().first;
    image = imageLib.decodeImage(await File(widget.file.path).readAsBytes());
  }

  Future<void> _loadLabels() async {
    final labelTxt =
        await rootBundle.loadString('assets/labels_mobilenet_quant_v1_224.txt');
    labels = labelTxt.split('\n');
  }
}
