import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance; //for the database
final auth = FirebaseAuth.instance;
late User loggedInUser;
String username = "";
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
