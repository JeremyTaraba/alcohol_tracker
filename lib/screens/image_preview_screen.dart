import 'dart:io';

import 'package:alcohol_tracker/image_helper/image_classification_helper.dart';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image/image.dart' as img;

import '../util/firebase_info.dart';
import '../util/objects.dart';
import '../util/user_info.dart';

final _firestore = FirebaseFirestore.instance; //for the database

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({super.key, required this.file});
  final XFile file;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late final Interpreter interpreter;

  late Tensor inputTensor;

  late Tensor outputTensor;

  late final List<String> labels;

  img.Image? image;

  bool _isProcessing = false;

  late Map<String, double> classification;

  late ImageClassificationHelper imageClassificationHelper;

  late List<String> topResults;
  late List<MapEntry<String, double>> sortedResults;

  late Map<String, int> submittedInfo;
  Map<String, int> totalUpdate = {"total": 0};

  int ouncesEntered = 0;

  List<String> sortClassification() {
    sortedResults = classification.entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    List<String> topResults = [];
    for (int i = sortedResults.length - 1; i >= 0; i--) {
      topResults.add(sortedResults[i].key);
      //print(sortedResults[i].value);
    }

    return topResults;
  }

  @override
  void dispose() {
    super.dispose();
    imageClassificationHelper.close();
    interpreter.close();
  }

  @override
  void initState() {
    super.initState();
    initTensorFlow();
    _loadLabels();
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper.initHelper();
  }

  bool showSpinner = false;
  int count = 0;
  String drinkType = "";
  String originalDrinkType = "";

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            centerTitle: true,
            title: Text("Image Preview"),
          ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Image.file(picture),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  color: Colors.lightBlueAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await processImage(picture);
                          originalDrinkType = sortClassification()[0];
                          drinkType = originalDrinkType;
                          _dialogBuilder(context);
                        } catch (e) {
                          print(e);
                          setState(() {
                            showSpinner = false;
                          });
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      backgroundColor: Colors.white,
                      child: const Text(
                        "Analyze",
                        style: TextStyle(fontSize: 24, color: Colors.indigo),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initTensorFlow() async {
    interpreter = await Interpreter.fromAsset('assets/model.tflite');

    // Get tensor input shape [1, 224, 224, 3]
    inputTensor = interpreter.getInputTensors().first;
    // Get tensor output shape [1, 1001]
    outputTensor = interpreter.getOutputTensors().first;
    image = imageLib.decodeImage(await File(widget.file.path).readAsBytes());
  }

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString('assets/labels.txt');
    labels = labelTxt.split('\n');
  }

  // Process picked image
  Future<bool> processImage(File imagePath) async {
    final imageData = imagePath.readAsBytesSync();

    // Decode image using package:image/image.dart (https://pub.dev/image)
    image = img.decodeImage(imageData);
    setState(() {});
    classification = await imageClassificationHelper.inferenceImage(image!);
    setState(() {});
    return true;
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.spaceAround,
              title: TextFormField(
                style: const TextStyle(fontSize: 24),
                initialValue: drinkType,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  drinkType = value;
                },
                onTapOutside: (value) {
                  if (drinkType.isEmpty) {
                    drinkType = originalDrinkType;
                  }
                  drinkType = drinkType.trim();
                  drinkType = drinkType.split(' ').map((word) => word.capitalize()).join(' '); //capitalize everyword
                },
              ),
              content: TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  ouncesEntered = int.parse(value);
                },
                keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  hintText: 'Enter oz',
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: (() async {
                      submittedInfo = {drinkType: ouncesEntered};
                      try {
                        //see if drink already exists first
                        var docRef = _firestore.collection('drink_log').doc(loggedInUser.email);
                        DocumentSnapshot doc = await docRef.get();
                        final data = doc.data() as Map<String, dynamic>;

                        totalUpdate["total"] = submittedInfo.values.first;
                        //if date already exists
                        if (data[DateTime.now().toString().split(" ")[0]] != null) {
                          //if drink we are trying to submit already exists
                          if (data[DateTime.now().toString().split(" ")[0]][submittedInfo.keys.first] != null) {
                            //update that data by adding to it
                            totalUpdate["total"] = submittedInfo.values.first + data[DateTime.now().toString().split(" ")[0]]["total"] as int;
                            submittedInfo[submittedInfo.keys.first] =
                                submittedInfo.values.first + data[DateTime.now().toString().split(" ")[0]][submittedInfo.keys.first] as int;
                          } else {
                            //if the drink does not exist, just update the total
                            totalUpdate["total"] = submittedInfo.values.first + data[DateTime.now().toString().split(" ")[0]]["total"] as int;
                          }
                        }
                        String date = DateTime.now().subtract(Duration(days: DateTime.now().weekday)).toString().split(" ")[0];  //gets the sunday for the current week
                        setDrinkLogDatabase(submittedInfo);
                        setDrinkLogDatabase(totalUpdate);
                        user_Info_weeklyLog = await getWeeklyLog(date);
                        user_Info_drinksInAWeek = await getDrinksInWeek(date);
                        mySnackBar("Submitted", context);
                      } catch (e) {
                        print(e);
                        mySnackBar("$e", context);
                        Navigator.pop(context);
                      }

                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    }),
                    child: const Text("Submit"))
              ],
            ),
        context: context);
  }
}
