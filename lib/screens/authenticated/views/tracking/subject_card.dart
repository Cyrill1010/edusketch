import 'package:animations/animations.dart';
import 'package:edusketch/screens/authenticated/views/tracking/edit_subject.dart';
import 'package:edusketch/screens/authenticated/views/tracking/read_subject.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    Key key,
    @required this.index,
    @required this.snapshot,
  }) : super(key: key);

  final int index;
  final snapshot;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedColor: Colors.white,
        closedElevation: 0.0,
        tappable: false,
        openBuilder: (BuildContext context, VoidCallback _) =>
            EditSubject(snapshot: snapshot, index: index),
        transitionDuration: Duration(milliseconds: 700),
        transitionType: ContainerTransitionType.fade,
        closedBuilder: (BuildContext _, VoidCallback openContainer) =>
            ReadSubject(
              data: snapshot.data.documents[index].data,
              openContainer: openContainer,
            ));
  }
}
