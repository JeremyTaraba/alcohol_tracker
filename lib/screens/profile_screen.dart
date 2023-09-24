import 'package:alcohol_tracker/util/firebase_info.dart';
import 'package:alcohol_tracker/util/user_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/bottom_nav.dart';

final _firestore = FirebaseFirestore.instance;

const List<String> list = <String>[
  'Prefer not to say',
  'Male',
  'Female',
];

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String dropdownValue = user_Info_Gender;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileData("Name", user_Info_Name),
                //profileData("Age", "22"),
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.indigo, width: 3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 0,
                          style: const TextStyle(fontSize: 24, color: Colors.black),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                              _firestore.collection('profile_info').doc(auth.currentUser?.email).update({
                                'gender': value,
                              });
                              user_Info_Gender = value;
                            });
                          },
                          items: list.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                profileData("Email", auth.currentUser?.email),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          auth.signOut();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(fontSize: 24),
                        )),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: bottomNav(
            selectedIndex: 0,
          ),
        ),
      ),
    );
  }

  Widget profileData(String title, String? Data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              "$title",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo, width: 3),
              ),
              child: Center(
                child: Text(
                  "$Data",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
