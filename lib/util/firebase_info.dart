import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance; //for the database
final auth = FirebaseAuth.instance;
late User loggedInUser;

String? userEmail = "";

void getCurrentUserInfo() async {
  try {
    // make sure user is authenticated
    final user = await auth.currentUser!;
    if (user != null) {
      loggedInUser = user; // gets the logged in user
      userEmail = loggedInUser.email;
    }
  } catch (e) {
    print(e);
  }
}

Future<String> getCurrentUsername() async {
  try {
    // make sure user is authenticated
    final user = await auth.currentUser!;
    if (user != null) {
      loggedInUser = user; // gets the logged in user
    }

    //for getting the username
    var docRef = _firestore.collection('names').doc(loggedInUser.email);
    DocumentSnapshot doc = await docRef.get();
    final data = await doc.data() as Map<String, dynamic>;

    if (data["name"] != "") {
      return data["name"];
    }
  } catch (e) {
    print(e);
  }
  return "";
}

Future<List<int>> getWeeklyLog(String date) async {
  List<int> weeklyLog = [];
  try {
    final user = await auth.currentUser!;
    if (user != null) {
      loggedInUser = user; // gets the logged in user
    }

    var docRef = _firestore.collection('drink_log').doc(loggedInUser.email);
    DocumentSnapshot doc = await docRef.get();
    final data = await doc.data() as Map<String, dynamic>;
    String lookUpDate = date;
    for (int i = 0; i < 7; i++) {
      if (data.keys.contains(lookUpDate)) {
        weeklyLog.add(data[lookUpDate]["total"]);
        print(data[lookUpDate]["total"]);
      } else {
        weeklyLog.add(0);
      }
      print(lookUpDate);
      lookUpDate = incrementDay(lookUpDate);
    }
    print(weeklyLog);
    return weeklyLog;
  } catch (e) {
    print(e);
  }

  return [];
}

String incrementDay(String date) {
  List<String> separatedDate = date.split("-");
  //increment the day according to how many days are in the month
  int monthAsNum = int.parse(separatedDate[1]);
  int dayAsNum = int.parse(separatedDate[2]);
  int yearAsNum = int.parse(separatedDate[0]);
  if (monthAsNum == 4 ||
      monthAsNum == 6 ||
      monthAsNum == 9 ||
      monthAsNum == 11) {
    //months with 30 days
    if (dayAsNum == 30) {
      monthAsNum++;
      dayAsNum = 1;
    } else {
      dayAsNum++;
    }
  } else if (monthAsNum == 2) {
    //28 but sometimes 29 on leap years
    if (isLeapYear(yearAsNum)) {
      if (dayAsNum == 28) {
        dayAsNum = 29;
      }
      if (dayAsNum == 29) {
        dayAsNum = 1;
      }
    } else {
      if (dayAsNum == 28) {
        dayAsNum == 1;
      } else {
        dayAsNum++;
      }
    }
  } else {
    //months with 31 days
    if (dayAsNum == 31) {
      if (monthAsNum == 12) {
        monthAsNum = 1;
        yearAsNum = yearAsNum++;
      }
      dayAsNum = 1;
    } else {
      dayAsNum++;
    }
  }

  separatedDate[0] = yearAsNum.toString();
  separatedDate[1] = monthAsNum.toString();
  if (monthAsNum < 10) {
    //need to add leading 0
    separatedDate[1] = "0" + separatedDate[1];
  }

  separatedDate[2] = dayAsNum.toString();
  if (dayAsNum < 10) {
    //need to add leading 0
    separatedDate[2] = "0" + separatedDate[2];
  }
  return separatedDate.join("-");
}

bool isLeapYear(int year) {
  if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
    return true;
  }
  return false;
}
