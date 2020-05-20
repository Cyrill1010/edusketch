import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'subject_card.dart';

class TrackingView extends StatefulWidget {
  final db = Firestore.instance;

  @override
  _TrackingViewState createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
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
        StreamBuilder(
          stream: widget.db.collection('Subjects').orderBy('order').snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2,),
                    child: ReorderableListView(
                        header: Text('Detailed Overview',
                            style: Theme.of(context).textTheme.headline5),
                        onReorder: (int oldIndex, int newIndex) {
                          reorderSubjects(snapshot, newIndex, oldIndex,
                              newIndex > oldIndex);
                        },
                        children: List.generate(
                            snapshot.data.documents.length,
                            (index) => SubjectCard(
                                  key: Key('$index'),
                                  index: index,
                                  snapshot: snapshot,
                                ))),
                  )
                : SizedBox();
          },
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
