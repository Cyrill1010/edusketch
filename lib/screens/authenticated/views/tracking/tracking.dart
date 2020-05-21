import 'package:animations/animations.dart';
import 'package:edusketch/screens/authenticated/views/tracking/detailed_overview/detailed_overview.dart';
import 'package:edusketch/screens/authenticated/views/tracking/filter_bar/filter_bar.dart';
import 'package:edusketch/screens/authenticated/views/tracking/overall_overview/overall_overview.dart';
import 'package:edusketch/widgets/detailed_subject.dart';
import 'package:edusketch/widgets/speed_dial.dart';
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
          child: Center(
            widthFactor: 5.35,
            child: SpeedDial(controller: widget.animationController, widgetList: <Widget>[
              OpenContainer(
                  closedColor: Colors.white,
                  closedElevation: 0.0,
                  tappable: false,
                  openBuilder: (BuildContext context, VoidCallback _) => DetailedSubject(
                        createMode: false,
                      ),
                  transitionDuration: Duration(milliseconds: 700),
                  closedBuilder: (BuildContext _, VoidCallback openContainer) => null),
              OpenContainer(
                closedColor: Colors.white,
                closedElevation: 0.0,
                tappable: false,
                openBuilder: (BuildContext context, VoidCallback _) => DetailedSubject(
                  createMode: false,
                ),
                transitionDuration: Duration(milliseconds: 700),
                closedBuilder: (BuildContext _, VoidCallback openContainer) => FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Theme.of(context).cardColor,
                    mini: true,
                    child: Icon(Icons.playlist_add, color: Theme.of(context).accentColor),
                    onPressed: openContainer),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
