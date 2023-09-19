import 'package:alcohol_tracker/util/bottom_nav.dart';
import 'package:alcohol_tracker/util/firebase_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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

  List<int> weeklyLog = [0, 0, 0, 0, 0, 0, 0];

  DrinksAndAmounts drinksInAWeek = DrinksAndAmounts();

  List<Map<String, int>> drinksInAWeek2 = [];

  @override
  void initState() {
    super.initState();
    //figure out whos logged in
    _controller.displayDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    _selectedDate = _controller.displayDate.toString().split(" ")[0];
    getDrinkLog();
    getWeeklyDrinks();
  }

  //this gets called every time and we make a read everytime
  //TODO: make it so when you log in these values are saved so we don't read every time unless something changed
  getDrinkLog() async {
    weeklyLog = await getWeeklyLog(_selectedDate);
    setState(() {});
  }

  getWeeklyDrinks() async {
    drinksInAWeek = await getDrinksInWeek(_selectedDate);
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  welcomeMessage(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.lightBlueAccent, width: 3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Week of $_selectedDate",
                        style: const TextStyle(fontSize: 28),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => AlertDialog(
                                    scrollable: true,
                                    actionsAlignment: MainAxisAlignment.spaceAround,
                                    content: datePicker(),
                                  ));
                        },
                        icon: const Icon(Icons.arrow_drop_down, size: 50),
                      )
                    ],
                  ),
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
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          //this Expanded is here to stop an exception with dart:paint from happening
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 5, right: 5),
                            child: SfSparkBarChart(
                              labelDisplayMode: SparkChartLabelDisplayMode.all,
                              axisLineColor: Colors.transparent,
                              data: weeklyLog,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
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
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Text(
                      "Weekly Totals:",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.lightBlueAccent, width: 3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: ListView.builder(
                          itemCount: drinksInAWeek.drinks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              dense: true,
                              visualDensity: VisualDensity(vertical: -4),
                              title: Text(
                                "${drinksInAWeek.drinks[index]}: ${drinksInAWeek.drinkAmounts[index]}",
                                style: TextStyle(fontSize: 24),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
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
        initialSelectedDate: DateTime.now().subtract(Duration(days: DateTime.now().weekday)),
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
        onSubmit: (value) async {
          _controller.displayDate = value as DateTime?;

          drinksInAWeek = await getDrinksInWeek(_selectedDate);

          Navigator.pop(context);
          setState(() {
            _selectedDate = _controller.displayDate.toString().split(" ")[0];
          });

          weeklyLog = await getWeeklyLog(_selectedDate);

          setState(() {});
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
