import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/globals/globals.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OverallOverview extends StatelessWidget {
  OverallOverview({Key key}) : super(key: key);
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
              return Row(
                children: [
                  Text('Overall average: ' +
                      getOverallAverage(getAllAverages(_docs), getAllWeights(_docs)).toString()),
                  Text('Overall plus points: ' +
                      getOverallPlusPoints(getAllPlusPoints(_docs), getAllWeights(_docs))
                          .toString())
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        Container(
            height: 400,
            child: charts.BarChart(series,
                animate: true, barGroupingType: charts.BarGroupingType.stacked))
      ],
    );
  }
}

List<charts.Series<SubscriberSeries, String>> series = [
  charts.Series(
      id: "Subscribers",
      data: data,
      domainFn: (SubscriberSeries series, _) => series.year,
      measureFn: (SubscriberSeries series, _) => series.subscribers,
      colorFn: (SubscriberSeries series, _) => series.barColor)
];

class SubscriberSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries({@required this.year, @required this.subscribers, @required this.barColor});
}

final List<SubscriberSeries> data = [
  SubscriberSeries(
    year: "2008",
    subscribers: 10000000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  SubscriberSeries(
    year: "2009",
    subscribers: 11000000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  SubscriberSeries(
    year: "2010",
    subscribers: 12000000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  SubscriberSeries(
    year: "2011",
    subscribers: 10000000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  SubscriberSeries(
    year: "2012",
    subscribers: 8500000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  SubscriberSeries(
    year: "2013",
    subscribers: 7700000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  SubscriberSeries(
    year: "2014",
    subscribers: 7600000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  SubscriberSeries(
    year: "2015",
    subscribers: 5500000,
    barColor: charts.ColorUtil.fromDartColor(Colors.red),
  ),
];
