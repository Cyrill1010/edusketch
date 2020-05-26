import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Grade:
// grade: 5,
//         topic: `Dog`,
//         type: `normal`,
//         gradeWeight: 1,
//         notes: ``,
//         remember: ``,
//         semester: 4.2,
//         date: ``,

class Subject {
  String name;
  double goal;
  String weight;
  List grades;
  double average;
  String background;
  String icon;

  Subject(this.name, this.goal, this.weight, this.grades, this.average, this.background, this.icon);
}

class AverageAndGoalSeries {
  final String subject;
  final double averageOrGoal;
  final charts.Color barColor;

  AverageAndGoalSeries(
      {@required this.subject, @required this.averageOrGoal, @required this.barColor});
}
