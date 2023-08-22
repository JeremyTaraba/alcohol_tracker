import 'dart:io';

import 'package:alcohol_tracker/image_helper/image_classification_helper.dart';
import 'package:alcohol_tracker/screens/analyze_result_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image/image.dart' as img;

class ImagePreviewScreenTest extends StatefulWidget {
  ImagePreviewScreenTest({super.key, required this.file});
  XFile file;

  @override
  State<ImagePreviewScreenTest> createState() => _ImagePreviewScreenTestState();
}

class _ImagePreviewScreenTestState extends State<ImagePreviewScreenTest> {
  late final Interpreter interpreter;

  late Tensor inputTensor;

  late Tensor outputTensor;

  late final List<String> labels;

  img.Image? image;

  bool _isProcessing = false;

  late Map<String, double> classification;

  late ImageClassificationHelper imageClassificationHelper;

  @override
  void dispose() {
    super.dispose();
    imageClassificationHelper.close();
    interpreter.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTensorFlow();
    _loadLabels();
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper.initHelper();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
                    child: Center(child: Text("Image Preview")),
                  ),
                ],
              ),
              Center(
                child: Image.file(picture),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      await processImage(picture);
                      //print(classification);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnalyzeResultsScreen(
                                  classification: classification)));
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
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

  Future<void> imageAnalysis(CameraImage cameraImage) async {
    // if image is still analyze, skip this frame
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;
    classification =
        await imageClassificationHelper.inferenceCameraFrame(cameraImage);
    _isProcessing = false;
    if (mounted) {
      setState(() {});
    }
  }

  // Process picked image
  Future<void> processImage(File imagePath) async {
    final imageData = imagePath.readAsBytesSync();

    // Decode image using package:image/image.dart (https://pub.dev/image)
    image = img.decodeImage(imageData);
    setState(() {});
    classification = await imageClassificationHelper.inferenceImage(image!);
    setState(() {});
  }
}