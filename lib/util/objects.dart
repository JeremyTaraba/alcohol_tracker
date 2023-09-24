import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackBar(String text, context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class DrinksAndAmounts {
  List<String> drinks = [];
  List<int> drinkAmounts = [];
}

int partition(List<dynamic> drinkAmounts, List<dynamic> drinks, int low, int high) {
  var pivot = drinkAmounts[high];
  var temp;
  int largerNumIndex = low - 1; // index of the next num that is larger than the pivot

  for (int j = low; j < high; j++) {
    if (drinkAmounts[j] > pivot) {
      largerNumIndex = largerNumIndex + 1;
      temp = drinkAmounts[largerNumIndex];
      drinkAmounts[largerNumIndex] = drinkAmounts[j];
      drinkAmounts[j] = temp;
      temp = drinks[largerNumIndex];
      drinks[largerNumIndex] = drinks[j];
      drinks[j] = temp;
    }
  }
  //swap larger num and pivot at the end
  temp = drinkAmounts[largerNumIndex + 1];
  drinkAmounts[largerNumIndex + 1] = drinkAmounts[high];
  drinkAmounts[high] = temp;
  temp = drinks[largerNumIndex + 1];
  drinks[largerNumIndex + 1] = drinks[high];
  drinks[high] = temp;

  return largerNumIndex + 1;
}

void quicksort(List<dynamic> drinkAmounts, List<dynamic> drinks, int low, int high) {
  if (low < high) {
    int partitionNum = partition(drinkAmounts, drinks, low, high);
    quicksort(drinkAmounts, drinks, low, partitionNum - 1); //recursively go down left side of pivot
    quicksort(drinkAmounts, drinks, partitionNum + 1, high); //recursively go down right side of pivot
  }
}
