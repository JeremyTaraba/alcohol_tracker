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

Future<List<double>> getWeeklyLog(DateTime date) async {
  late List<double> weeklyLog;
  try {
    final user = await auth.currentUser!;
    if (user != null) {
      loggedInUser = user; // gets the logged in user
    }

    var docRef = _firestore.collection('drink_log').doc(loggedInUser.email);
    DocumentSnapshot doc = await docRef.get();
    final data = await doc.data() as Map<String, dynamic>;

    for (int i = 0; i < 7; i++) {
      if (data.values.contains("2023-09")) {
        //weeklyLog.add(data.entries.);
      }
    }

    print(data);
  } catch (e) {
    print(e);
  }

  return [];
}
