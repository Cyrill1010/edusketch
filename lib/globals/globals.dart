import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool isGrade(int n) {
  return 1 <= n && n <= 6;
}

bool isPercent(int n) {
  return 0 <= n && n <= 1;
}

bool isGoalReached(int goal, int average) {
  return average >= goal;
}

double getPlusPoints(double average) {
  double roundedAverage = (average * 2).round() / 2;
  return roundedAverage >= 4 ? roundedAverage - 4 : 2 * (roundedAverage - 4);
}

List<double> getAllWeights(List<DocumentSnapshot> docs) {
  List<double> listOfWeights = <double>[];
  docs.forEach((element) => listOfWeights.add(double.parse(element.data['weight'])));
  return listOfWeights;
}

List<double> getAllAverages(List<DocumentSnapshot> docs) {
  List<double> listOfAverages = <double>[];
  docs.forEach((element) => listOfAverages.add(element.data['average'].toDouble()));
  return listOfAverages;
}

List<double> getAllPlusPoints(List<DocumentSnapshot> docs) {
  List<double> listOfPlusPoints = <double>[];
  docs.forEach(
      (element) => listOfPlusPoints.add(getPlusPoints(element.data['average'].toDouble())));
  return listOfPlusPoints;
}

double getOverallAverage(List<double> listOfAverages, List<double> listOfWeights) {
  List<double> listOfAveragesTimesWeights = [];
  for (var i = 0; i < listOfAverages.length; i++) {
    listOfAveragesTimesWeights.add(listOfAverages[i] * listOfWeights[i]);
  }

  return double.parse(
      (listOfAveragesTimesWeights.reduce((a, b) => a + b) / listOfWeights.reduce((a, b) => a + b))
          .toStringAsPrecision(3));
}

double getOverallPlusPoints(List<double> listOfPlusPoints) {
  return listOfPlusPoints.reduce((a, b) => a + b);
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
