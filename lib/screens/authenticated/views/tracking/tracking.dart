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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: <Widget>[FilterBar(), OverallOverview(), DetailedOverview()],
        ),
        Positioned(
          bottom: 0,
          child: Center(widthFactor: 5.35, child: null),
        ),
      ],
    );
  }
}
