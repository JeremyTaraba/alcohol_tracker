import 'package:alcohol_tracker/util/bottom_nav.dart';
import 'package:alcohol_tracker/util/firebase_info.dart';
import 'package:alcohol_tracker/util/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

//TODO: Make it so you can type in the drink name
//TODO: Update AI

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

  String _selectedDate = '';

  final DateRangePickerController _controller = DateRangePickerController();
  DateTime? confirmedDate;

  List<int> weeklyLog = [0, 0, 0, 0, 0, 0, 0]; //causes exception when its just 0's

  DrinksAndAmounts drinksInAWeek = DrinksAndAmounts();

  String monthDay = "";
  String todaysDate = "";

  @override
  void initState() {
    super.initState();
    //figure out whos logged in
    _controller.displayDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    _selectedDate = _controller.displayDate.toString().split(" ")[0];
    todaysDate = _controller.displayDate.toString().split(" ")[0];
    weeklyLog = user_Info_weeklyLog;
    drinksInAWeek = user_Info_drinksInAWeek;
    monthDay = weekOf();
  }

  String weekOf() {
    String month = "";
    String day = "";
    List<String> date = _selectedDate.split('-');
    day = date[2];
    month = date[1];
    Map<String, String> monthNumToText = {
      "01": "January",
      "02": "February",
      "03": "March",
      "04": "April",
      "05": "May",
      "06": "June",
      "07": "July",
      "08": "August",
      "09": "September",
      "10": "October",
      "11": "November",
      "12": "December",
    };

    return "${monthNumToText[month]} $day";
  }

  //this gets called every time and we make a read everytime

  getDrinkLog() async {
    weeklyLog = await getWeeklyLog(_selectedDate);
    setState(() {});
  }

  getWeeklyDrinks() async {
    drinksInAWeek = await getDrinksInWeek(_selectedDate);
    setState(() {});
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
      color: Colors.lightBlueAccent,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  welcomeMessage(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Merriweather'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.indigo, width: 3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Week of ${weekOf()}",
                        style: const TextStyle(fontSize: 24, fontFamily: 'Merriweather'),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.indigo, width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Ounces:",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Merriweather'),
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
                              labelStyle: const TextStyle(
                                fontFamily: 'Merriweather',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWithMerriweather('Sun'),
                              textWithMerriweather('Mon'),
                              textWithMerriweather('Tue'),
                              textWithMerriweather('Wed'),
                              textWithMerriweather('Thur'),
                              textWithMerriweather('Fri'),
                              textWithMerriweather('Sat'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    const Text(
                      "Weekly Totals:",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Merriweather'),
                    ),
                    Container(
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.indigo, width: 3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: ListView.builder(
                          itemCount: drinksInAWeek.drinks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              dense: true,
                              visualDensity: const VisualDensity(vertical: -4),
                              title: Text(
                                "${drinksInAWeek.drinks[index]}: ${drinksInAWeek.drinkAmounts[index]}",
                                style: const TextStyle(fontSize: 24),
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

          Navigator.pop(context);
          setState(() {
            _selectedDate = _controller.displayDate.toString().split(" ")[0];
          });
          await getWeeklyDrinks();
          await getDrinkLog();

          setState(() {});
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Text textWithMerriweather(String t) {
    return Text(
      t,
      style: const TextStyle(
        fontFamily: 'Merriweather',
      ),
    );
  }
}
