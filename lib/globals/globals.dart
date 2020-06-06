import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool isGrade(int n) {
  return 1 <= n && n <= 6;
}

bool isWeight(double n) {
  return 0 <= n && n <= 10;
}

bool isGoalReached(int goal, int average) {
  return average >= goal;
}

String convertAbbreviation(String name) {
  return name.length > 3 ? name.substring(0, 3) : name;
}

double convertPlusPoints(double average) {
  double roundedAverage = (average * 2).round() / 2;
  return roundedAverage >= 4 ? roundedAverage - 4 : 2 * (roundedAverage - 4);
}

List<dynamic> getAll(List<DocumentSnapshot> docs, String whatToGet) {
  List<dynamic> li = <dynamic>[];
  docs.forEach(
      (el) => li.add(whatToGet == 'average' ? el.data[whatToGet].toDouble() : el.data[whatToGet]));
  return li;
}

// List<String> getAllAbbreviations(List<DocumentSnapshot> docs) {
//   List<String> listOfAbbrevations = <String>[];
//   docs.forEach((element) => listOfAbbrevations.add(element.data['abbreviation']));
//   return listOfAbbrevations;
// }

// List<String> getAllSubjectNames(List<DocumentSnapshot> docs) {
//   List<String> listOfSubjectNames = <String>[];
//   docs.forEach((element) => listOfSubjectNames.add(element.data['name']));
//   return listOfSubjectNames;
// }

// List<double> getAllGoals(List<DocumentSnapshot> docs) {
//   List<double> listOfGoals = <double>[];
//   docs.forEach((element) => listOfGoals.add(double.parse(element.data['goal'])));
//   return listOfGoals;
// }

// List<double> getAllWeights(List<DocumentSnapshot> docs) {
//   List<double> listOfWeights = <double>[];
//   docs.forEach((element) => listOfWeights.add(double.parse(element.data['weight'])));
//   return listOfWeights;
// }

// List<double> getAllAverages(List<DocumentSnapshot> docs) {
//   List<double> listOfAverages = <double>[];
//   docs.forEach((element) => listOfAverages.add(element.data['average'].toDouble()));
//   return listOfAverages;
// }

// List<double> getAllPlusPoints(List<DocumentSnapshot> docs) {
//   List<double> listOfPlusPoints = <double>[];
//   docs.forEach(
//       (element) => listOfPlusPoints.add(getPlusPoints(element.data['average'].toDouble())));
//   return listOfPlusPoints;
// }

double getOverallAverage(List<dynamic> listOfAverages, List<dynamic> listOfWeights) {
  List<dynamic> listOfAveragesTimesWeights = [];
  for (var i = 0; i < listOfAverages.length; i++) {
    listOfAveragesTimesWeights.add(listOfAverages[i] * listOfWeights[i]);
  }

  return double.parse(
      (listOfAveragesTimesWeights.reduce((a, b) => a + b) / listOfWeights.reduce((a, b) => a + b))
          .toStringAsPrecision(3));
}

double getOverallPlusPoints(List<dynamic> listOfPlusPoints, List<dynamic> listOfWeights) {
  List<dynamic> listOfPlusPointsTimesWeights = [];
  for (var i = 0; i < listOfPlusPoints.length; i++) {
    listOfPlusPointsTimesWeights.add(listOfPlusPoints[i] * listOfWeights[i]);
  }

  return listOfPlusPointsTimesWeights.reduce((a, b) => a + b);
}

bool isLightColor(int color, int limit) {
  return Color(color).red >= limit || Color(color).green >= limit || Color(color).blue >= limit;
}

int getOppositeColorComponent(int i, int limit) {
  return i > limit ? i - 2 * (i - limit) : i + 2 * (limit - i);
}

Color getOppositeColor(int color) {
  int red = getOppositeColorComponent(Color(color).red, 128);
  int green = getOppositeColorComponent(Color(color).green, 128);
  int blue = getOppositeColorComponent(Color(color).blue, 128);
  return Color.fromARGB(255, red, green, blue);
}
