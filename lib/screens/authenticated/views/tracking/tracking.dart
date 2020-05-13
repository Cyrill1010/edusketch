import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'subject_card.dart';

class TrackingView extends StatefulWidget {
  final db;
  TrackingView(this.db);

  @override
  _TrackingViewState createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  Color subjectBackground(index) => Colors.redAccent[index];
  isDarkBackground(i) {
    return i > 400;
  }

  num subjectBackgroundGrade = 100;

  void reorderSubjects(snapshot, int n, int o, bool isNBiggerThanO) {
    if (isNBiggerThanO ? n > o : n < o) {
      for (var i = isNBiggerThanO ? o : n;
          isNBiggerThanO ? i < n : i < o;
          i++) {
        widget.db.runTransaction((myTransaction) async {
          final doc = snapshot.data.documents[i];
          await myTransaction
              .update(doc.reference, {'order': isNBiggerThanO ? i - 1 : i + 1});
        });
      }
      widget.db.runTransaction((myTransaction) async {
        final doc = snapshot.data.documents[o];
        await myTransaction.update(doc.reference, {'order': n});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        filterBar,
        overallOverview,
        Expanded(
          child: StreamBuilder(
            stream:
                widget.db.collection('Subjects').orderBy('order').snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                      constraints: BoxConstraints(maxHeight: 200),
                      child: ReorderableListView(
                          header: Text('Detailed Overview',
                              style: Theme.of(context).textTheme.headline5),
                          onReorder: (int oldIndex, int newIndex) {
                            reorderSubjects(snapshot, newIndex, oldIndex,
                                newIndex > oldIndex);
                            // if (newIndex < oldIndex) {
                            //   for (var i = newIndex; i < oldIndex; i++) {
                            //     widget.db
                            //         .runTransaction((myTransaction) async {
                            //       final doc = snapshot.data.documents[i];
                            //       await myTransaction.update(
                            //           doc.reference, {'order': i + 1});
                            //     });
                            //   }
                            //   widget.db
                            //       .runTransaction((myTransaction) async {
                            //     final doc =
                            //         snapshot.data.documents[oldIndex];
                            //     await myTransaction.update(
                            //         doc.reference, {'order': newIndex});
                            //   });
                            // }
                            // if (newIndex > oldIndex) {
                            //   for (var i = oldIndex; i < newIndex; i++) {
                            //     widget.db
                            //         .runTransaction((myTransaction) async {
                            //       final doc = snapshot.data.documents[i];
                            //       await myTransaction.update(
                            //           doc.reference, {'order': i - 1});
                            //     });
                            //   }
                            //   widget.db
                            //       .runTransaction((myTransaction) async {
                            //     final doc =
                            //         snapshot.data.documents[oldIndex];
                            //     await myTransaction.update(
                            //         doc.reference, {'order': newIndex});
                            //   });
                            // }
                          },
                          scrollDirection: Axis.vertical,
                          children: List.generate(
                              snapshot.data.documents.length,
                              (index) => SubjectCard(
                                  key: Key('$index'),
                                  index: index,
                                  snapshot: snapshot,
                                  subjectBackgroundGrade:
                                      subjectBackgroundGrade))),
                    )
                  : SizedBox();
            },
          ),
        )
      ],
    );
  }

  final Widget filterBar = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [TextFieldSemester()],
  );

  final Widget overallOverview = Container(
      child: Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text('Overall Overview')],
      ),
    ],
  ));
}

class TextFieldSemester extends StatefulWidget {
  @override
  _TextFieldSemesterState createState() => _TextFieldSemesterState();
}

class _TextFieldSemesterState extends State<TextFieldSemester> {
  final textFieldSemesterController = TextEditingController(text: '4.1');

  @override
  void dispose() {
    textFieldSemesterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: TextField(
        controller: textFieldSemesterController,
        decoration: InputDecoration(border: InputBorder.none),
        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[1-9-.]"))],
        keyboardType: TextInputType.number,
      ),
    );
  }
}
