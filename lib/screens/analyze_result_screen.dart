import 'package:flutter/material.dart';

class AnalyzeResultsScreen extends StatefulWidget {
  AnalyzeResultsScreen({super.key, required this.classification});

  Map<String, double> classification;

  @override
  State<AnalyzeResultsScreen> createState() => _AnalyzeResultsScreenState();
}

class _AnalyzeResultsScreenState extends State<AnalyzeResultsScreen> {
  List<String> sortClassification() {
    sortedResults = widget.classification.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    List<String> topResults = [];
    for (int i = sortedResults.length - 1; i >= 0; i--) {
      topResults.add(sortedResults[i].key);
      //print(sortedResults[i].value);
    }
    print(widget.classification.entries);
    return topResults;
  }

  late List<String> topResults;
  late List<MapEntry<String, double>> sortedResults;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topResults = sortClassification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "${topResults[0]}",
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
