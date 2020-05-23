import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/widgets/detailed_subject.dart';
import 'package:edusketch/widgets/reorderable_firebase_list.dart';
import 'package:flutter/material.dart';
import 'read_subject.dart';

class DetailedOverview extends StatelessWidget {
  DetailedOverview({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.8),
      child: ReorderableFirebaseList(
        header: Text('Detailed Overview', style: Theme.of(context).textTheme.headline5),
        collection: Firestore.instance.collection('Subjects'),
        indexKey: 'order',
        itemBuilder: (BuildContext context, int index, DocumentSnapshot doc) {
          return OpenContainer(
              key: Key('$index'),
              closedColor: Colors.white,
              closedElevation: 0.0,
              tappable: false,
              openBuilder: (BuildContext context, VoidCallback _) => DetailedSubject(
                    createMode: false,
                    doc: doc,
                    index: index,
                  ),
              transitionDuration: Duration(milliseconds: 700),
              closedBuilder: (BuildContext _, VoidCallback openContainer) => ReadSubject(
                    doc: doc,
                    openContainer: openContainer,
                  ));
        },
      ),
    );
  }
}
