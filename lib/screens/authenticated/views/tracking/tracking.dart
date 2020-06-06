import 'package:edusketch/screens/authenticated/views/tracking/detailed_overview/detailed_overview.dart';
import 'package:edusketch/screens/authenticated/views/tracking/filter_bar/filter_bar.dart';
import 'package:edusketch/screens/authenticated/views/tracking/overall_overview/overall_overview.dart';
import 'package:flutter/material.dart';

class TrackingView extends StatefulWidget {
  TrackingView({this.animationController});
  final AnimationController animationController;

  @override
  _TrackingViewState createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  String dropdownValue = 'Subjects';

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FilterBar(),
      Divider(
        thickness: 1,
      ),
      OverallOverview(),
      Divider(
        thickness: 1,
      ),
      Row(
        children: [
          Text('Detailed overview',
              style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.grey)),
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
            items: <String>['Subjects', 'Grades'].map<DropdownMenuItem<String>>((String value) {
              //TODO subdropdown
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      DetailedOverview(dropdownValue: dropdownValue)
    ]);
  }
}
