import 'package:alcohol_tracker/util/bottom_nav.dart';
import 'package:alcohol_tracker/util/firebase_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
String username = "";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  DateTime now = DateTime.now();

  final _auth = FirebaseAuth.instance;

  String _selectedDate = '';

  final DateRangePickerController _controller = DateRangePickerController();
  DateTime? confirmedDate;

  late List<double> weeklyLog;

  @override
  void initState() {
    super.initState();
    getCurrentUser(); //figure out whos logged in
    _controller.displayDate =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    _selectedDate = _controller.displayDate.toString().split(" ")[0];
  }

  void getCurrentUser() async {
    try {
      // make sure user is authenticated
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user; // gets the logged in user
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    int currentHour = int.parse(formattedDate.split(':')[0]);

    String welcomeMessage() {
      if (currentHour <= 12) {
        return "Good Morning";
      } else if (currentHour > 12 && currentHour <= 18) {
        return "Good Afternoon";
      } else {
        return "Good Evening";
      }
    }

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Text(
                welcomeMessage(),
                style: TextStyle(fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Week of $_selectedDate",
                        style: TextStyle(fontSize: 28),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => AlertDialog(
                                    scrollable: true,
                                    actionsAlignment:
                                        MainAxisAlignment.spaceAround,
                                    content: datePicker(),
                                  ));
                        },
                        icon: Icon(Icons.arrow_drop_down, size: 50),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: Colors.lightBlueAccent, width: 3)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.lightBlueAccent, width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Ounces:",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 5, right: 5),
                          child: SfSparkBarChart(
                            labelDisplayMode: SparkChartLabelDisplayMode.all,
                            axisLineColor: Colors.transparent,
                            data: <double>[
                              10,
                              6,
                              8,
                              5,
                              11,
                              5,
                              2,
                            ],
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Sun"),
                              Text("Mon"),
                              Text("Tue"),
                              Text("Wed"),
                              Text("Thur"),
                              Text("Fri"),
                              Text("Sat"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.lightBlueAccent, width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weekly Total",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Beer: 40oz",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          "Red Wine: 10oz",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          "White Wine: 8oz",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: bottomNav(selectedIndex: selectedIndex),
        ),
      ),
    );
  }

  Container datePicker() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: SfDateRangePicker(
        showActionButtons: true,
        headerHeight: 40,
        initialSelectedDate:
            DateTime.now().subtract(Duration(days: DateTime.now().weekday)),
        selectionMode: DateRangePickerSelectionMode.single,
        view: DateRangePickerView.month,
        selectableDayPredicate: (DateTime dateTime) {
          if (dateTime.weekday == 7) {
            return true;
          } else {
            return false;
          }
        },
        controller: _controller,
        onSubmit: (value) {
          _controller.displayDate = value as DateTime?;

          setState(() {
            _selectedDate = _controller.displayDate.toString().split(" ")[0];
          });
          getWeeklyLog(DateTime.now());
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
