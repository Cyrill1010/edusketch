import 'package:flutter/material.dart';

class OverallOverview extends StatelessWidget {
  const OverallOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text('Overall Overview')],
          ),
        ],
      )),
    );
  }
}
