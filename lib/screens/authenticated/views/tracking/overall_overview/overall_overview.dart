import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/globals/globals.dart';
import 'package:edusketch/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// TODO
// Stream<QuerySnapshot> provideActivityStream() {
//     return Firestore.instance
//         .collection("users")
//         .document(widget.userId)
//         .collection('activities')
//         .orderBy('startDate', descending: true)
//         .snapshots();
//   }

class OverallOverview extends StatefulWidget {
  OverallOverview({Key key}) : super(key: key);

  static List<charts.Series<AverageAndGoalSeries, String>> createData(List<DocumentSnapshot> docs) {
    return [
      charts.Series(
          id: "Goal",
          data: getAll(docs, 'abbreviation')
              .map(
                (abbreviation) => AverageAndGoalSeries(
                  subject: abbreviation,
                  averageOrGoal: (getAll(docs, 'goal', true)[
                                  getAll(docs, 'abbreviation').indexOf(abbreviation)] -
                              getAll(docs, 'average')[
                                  getAll(docs, 'abbreviation').indexOf(abbreviation)]) >=
                          0
                      ? (getAll(docs, 'goal', true)[
                              getAll(docs, 'abbreviation').indexOf(abbreviation)] -
                          getAll(
                              docs, 'average')[getAll(docs, 'abbreviation').indexOf(abbreviation)])
                      : null,
                  barColor: charts.ColorUtil.fromDartColor(Colors.red),
                ),
              )
              .toList(),
          domainFn: (AverageAndGoalSeries series, _) => series.subject,
          domainLowerBoundFn: (datum, index) => '2',
          measureFn: (AverageAndGoalSeries series, _) => series.averageOrGoal,
          colorFn: (AverageAndGoalSeries series, _) => series.barColor),
      charts.Series(
          id: "Average",
          data: getAll(docs, 'abbreviation')
              .map(
                (abbreviation) => AverageAndGoalSeries(
                  subject: abbreviation,
                  averageOrGoal:
                      getAll(docs, 'average')[getAll(docs, 'abbreviation').indexOf(abbreviation)],
                  barColor: charts.ColorUtil.fromDartColor(Colors.blue),
                ),
              )
              .toList(),
          domainFn: (AverageAndGoalSeries series, _) => series.subject,
          measureFn: (AverageAndGoalSeries series, _) => series.averageOrGoal,
          measureUpperBoundFn: (datum, index) => 6,
          measureLowerBoundFn: (datum, index) => 1,
          colorFn: (AverageAndGoalSeries series, _) => series.barColor),
    ];
  }

  @override
  _OverallOverviewState createState() => _OverallOverviewState();
}

class _OverallOverviewState extends State<OverallOverview> {
  String dropdownValue = 'Subjects';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('Subjects').where('average', isGreaterThan: 0).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) return SizedBox();
        List<DocumentSnapshot> _docs = snapshot.data.documents;
        return _docs.isEmpty
            ? SizedBox()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Overall overview',
                        style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.grey),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Subjects', 'Grades']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('\u{2300}: ' +
                          getOverallAverage(getAll(_docs, 'average'), getAll(_docs, 'weight', true))
                              .toString()),
                      Text('plus points: ' +
                          getOverallPlusPoints(
                                  getAll(_docs, 'plusPoints'), getAll(_docs, 'weight', true))
                              .toString()),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Card(
                    child: Container(
                        height: 200,
                        child: charts.BarChart(OverallOverview.createData(_docs),
                            animate: true, barGroupingType: charts.BarGroupingType.stacked)),
                  )
                ],
              );
      },
    );
  }
}
