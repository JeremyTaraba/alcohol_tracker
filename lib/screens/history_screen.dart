import 'dart:collection';

import 'package:alcohol_tracker/util/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:alcohol_tracker/util/calendar_utils.dart';

import '../util/firebase_info.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([Event("")]);
  bool didGetDrinks = false;

  var kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  getDrinkHistory() async {
    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(await getDrinks());
    didGetDrinks = true;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  getDrinks() async {
    return await getHistoryOfDrinks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: getDrinkHistory(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    eventLoader: (day) {
                      return _getEventsForDay(day);
                    },
                    availableCalendarFormats: const {CalendarFormat.month: "Month"},
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    pageJumpingEnabled: true,
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay; // update `_focusedDay` here as well
                        });
                        _selectedEvents.value = _getEventsForDay(selectedDay);
                      }
                    },
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        final text = DateFormat.E().format(day);
                        return Center(
                          child: Text(
                            text,
                            style: const TextStyle(color: Colors.lightBlue),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                onTap: () => print('${value[index]}'),
                                title: Text('${value[index]}'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: bottomNav(
            selectedIndex: 2,
          ),
        ),
      ),
    );
  }
}
