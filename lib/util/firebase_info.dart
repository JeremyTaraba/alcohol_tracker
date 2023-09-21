import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    var docRef = _firestore.collection('profile_info').doc(loggedInUser.email);
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

Future<String> getGender() async {
  try {
    // make sure user is authenticated
    final user = await auth.currentUser!;
    if (user != null) {
      loggedInUser = user; // gets the logged in user
    }

    //for getting the username
    var docRef = _firestore.collection('profile_info').doc(loggedInUser.email);
    DocumentSnapshot doc = await docRef.get();
    final data = await doc.data() as Map<String, dynamic>;

    if (data["gender"] != "") {
      return data["gender"];
    }
  } catch (e) {
    print(e);
  }
  return "Prefer not to say";
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
      } else {
        weeklyLog.add(0);
      }

      lookUpDate = incrementDay(lookUpDate);
    }

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
  if (monthAsNum == 4 || monthAsNum == 6 || monthAsNum == 9 || monthAsNum == 11) {
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

void setDrinkLogDatabase(Map<String, int> data) async {
  await _firestore.collection('drink_log').doc(auth.currentUser?.email).set(
    {DateTime.now().toString().split(" ")[0]: data},
    SetOptions(merge: true),
  );
}

Future<DrinksAndAmounts> getDrinksInWeek(String date) async {
  DrinksAndAmounts drinksInAWeek = DrinksAndAmounts();
  Map<String, int> drinksFixed = {};
  Set<String> drinksSeenSoFar = {};

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
        List<String> temp = data[lookUpDate].keys.toList();

        for (int i = 0; i < temp.length; i++) {
          if (temp[i] == "total") {
            //skip it
          } else if (drinksSeenSoFar.contains(temp[i])) {
            drinksFixed.update(temp[i], (value) => data[lookUpDate][temp[i]] + drinksFixed[temp[i]]!);
          } else {
            drinksSeenSoFar.add(temp[i]);
            drinksFixed[temp[i]] = data[lookUpDate][temp[i]];
          }
        }
      }

      lookUpDate = incrementDay(lookUpDate);
    }
  } catch (e) {
    print(e);
  }
  //Now we need to find duplicates of drinks and remove them while summing their drinkAmounts together

  drinksFixed.forEach((key, value) {
    drinksInAWeek.drinks.add(key);
    drinksInAWeek.drinkAmounts.add(value);
  });

  //print(drinksInAWeek.drinks);
  return drinksInAWeek;
}

class DrinksAndAmounts {
  List<String> drinks = [];
  List<int> drinkAmounts = [];
}
