import 'package:flutter/material.dart';

class TrackingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[subjectContainer],
    ));
  }

  final Widget subjectContainer = Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[Text('Grade Control'), Text('')],
  ));
}
