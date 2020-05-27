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

class OverallOverview extends StatelessWidget {
  OverallOverview({Key key}) : super(key: key);

  static List<charts.Series<AverageAndGoalSeries, String>> createData(List<DocumentSnapshot> docs) {
    return [
      charts.Series(
          id: "Goal",
          data: getAll(docs, 'abbreviation')
              .map(
                (abbreviation) => AverageAndGoalSeries(
                  subject: abbreviation,
                  averageOrGoal: (getAll(docs, 'goal', returnDouble: true)[
                                  getAll(docs, 'abbreviation').indexOf(abbreviation)] -
                              getAll(docs, 'average')[
                                  getAll(docs, 'abbreviation').indexOf(abbreviation)]) >=
                          0
                      ? (getAll(docs, 'goal', returnDouble: true)[
                              getAll(docs, 'abbreviation').indexOf(abbreviation)] -
                          getAll(
                              docs, 'average')[getAll(docs, 'abbreviation').indexOf(abbreviation)])
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
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) return SizedBox();
            List<DocumentSnapshot> _docs = snapshot.data.documents;
            return _docs.isEmpty
                ? SizedBox()
                : Column(
                    children: [
                      Row(
                        children: [
                          Text('\u{2300}: ' +
                              getOverallAverage(getAll(_docs, 'average'),
                                      getAll(_docs, 'weight', returnDouble: true))
                                  .toString()),
                          Text('plus points: ' +
                              getOverallPlusPoints(getAll(_docs, 'plusPoints'),
                                      getAll(_docs, 'weight', returnDouble: true))
                                  .toString()),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Card(
                        child: Container(
                            height: 250,
                            child: charts.BarChart(createData(_docs),
                                animate: true, barGroupingType: charts.BarGroupingType.stacked)),
                      )
                    ],
                  );
          },
        ),
      ],
    );
  }
}
