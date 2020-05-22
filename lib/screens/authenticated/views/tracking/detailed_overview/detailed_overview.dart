import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/widgets/detailed_subject.dart';
import 'package:flutter/material.dart';

import 'read_subject.dart';

class DetailedOverview extends StatelessWidget {
  DetailedOverview({Key key}) : super(key: key);
  final db = Firestore.instance;
  void reorderSubjects(snapshot, int n, int o, bool isNBiggerThanO) {
    if (isNBiggerThanO ? n > o : n < o) {
      for (var i = isNBiggerThanO ? o : n; isNBiggerThanO ? i < n : i < o; i++) {
        db.runTransaction((myTransaction) async {
          await myTransaction.update(
              snapshot.data.documents[i].reference, {'order': isNBiggerThanO ? i - 1 : i + 1});
        });
      }
      db.runTransaction((myTransaction) async {
        await myTransaction.update(snapshot.data.documents[o].reference, {'order': n});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: db.collection('Subjects').orderBy('order').snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2,
                  ),
                  child: ReorderableListView(
                      header:
                          Text('Detailed Overview', style: Theme.of(context).textTheme.headline5),
                      onReorder: (int oldIndex, int newIndex) {
                        reorderSubjects(snapshot, newIndex, oldIndex, newIndex > oldIndex);
                      },
                      children: List.generate(
                          snapshot.data.documents.length,
                          (index) => OpenContainer(
                              key: Key('$index'),
                              closedColor: Colors.white,
                              closedElevation: 0.0,
                              tappable: false,
                              openBuilder: (BuildContext context, VoidCallback _) =>
                                  DetailedSubject(
                                    createMode: false,
                                    snapshot: snapshot,
                                    index: index,
                                  ),
                              transitionDuration: Duration(milliseconds: 700),
                              closedBuilder: (BuildContext _, VoidCallback openContainer) =>
                                  ReadSubject(
                                    data: snapshot.data.documents[index].data,
                                    openContainer: openContainer,
                                  )))),
                )
              : SizedBox();
        },
      ),
    );
  }
}
