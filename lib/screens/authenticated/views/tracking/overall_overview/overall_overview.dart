import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/globals/globals.dart';
import 'package:edusketch/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OverallOverview extends StatelessWidget {
  OverallOverview({Key key}) : super(key: key);

  static List<charts.Series<AverageAndGoalSeries, String>> createData(List<DocumentSnapshot> docs) {
    return [
      charts.Series(
          id: "Goal",
          data: getAllAbbreviations(docs)
              .map(
                (subjectName) => AverageAndGoalSeries(
                  subject: subjectName,
                  averageOrGoal:
                      (getAllGoals(docs)[getAllAbbreviations(docs).indexOf(subjectName)] -
                                  getAllAverages(
                                      docs)[getAllAbbreviations(docs).indexOf(subjectName)]) >=
                              0
                          ? (getAllGoals(docs)[getAllAbbreviations(docs).indexOf(subjectName)] -
                              getAllAverages(docs)[getAllAbbreviations(docs).indexOf(subjectName)])
                          : null,
                  barColor: charts.ColorUtil.fromDartColor(Colors.red),
                ),
              )
              .toList(),
          domainFn: (AverageAndGoalSeries series, _) => series.subject,
          measureFn: (AverageAndGoalSeries series, _) => series.averageOrGoal,
          measureUpperBoundFn: (datum, index) => 6,
          colorFn: (AverageAndGoalSeries series, _) => series.barColor),
      charts.Series(
          id: "Average",
          data: getAllAbbreviations(docs)
              .map(
                (subjectName) => AverageAndGoalSeries(
                  subject: subjectName,
                  averageOrGoal:
                      getAllAverages(docs)[getAllAbbreviations(docs).indexOf(subjectName)],
                  barColor: charts.ColorUtil.fromDartColor(Colors.blue),
                ),
              )
              .toList(),
          domainFn: (AverageAndGoalSeries series, _) => series.subject,
          measureFn: (AverageAndGoalSeries series, _) => series.averageOrGoal,
          measureUpperBoundFn: (datum, index) => 6,
          colorFn: (AverageAndGoalSeries series, _) => series.barColor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Overall overview',
          style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.grey),
        ),
        StreamBuilder(
          stream: Firestore.instance
              .collection('Subjects')
              .where('average', isGreaterThan: 0)
              .snapshots(includeMetadataChanges: true),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> _docs = snapshot.data.documents;
              if (_docs.length != 0) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text('\u{2300}: ' +
                            getOverallAverage(getAllAverages(_docs), getAllWeights(_docs))
                                .toString()),
                        Text('plus points: ' +
                            getOverallPlusPoints(getAllPlusPoints(_docs), getAllWeights(_docs))
                                .toString()),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Container(
                        height: 400,
                        child: charts.BarChart(createData(_docs),
                            animate: true, barGroupingType: charts.BarGroupingType.stacked))
                  ],
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
