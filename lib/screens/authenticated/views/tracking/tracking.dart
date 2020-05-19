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
                          },
                          children: List.generate(
                              snapshot.data.documents.length,
                              (index) => SubjectCard(
                                  key: Key('$index'),
                                  index: index,
                                  snapshot: snapshot,
                                  subjectBackgroundGrade:
                                      subjectBackgroundGrade))),
                    )
                  //           ...List<Widget>.generate(10, (int index) {
                  //   return OpenContainer(
                  //     transitionType: _transitionType,
                  //     openBuilder: (BuildContext _, VoidCallback openContainer) {
                  //       return _DetailsPage();
                  //     },
                  //     tappable: false,
                  //     closedShape: const RoundedRectangleBorder(),
                  //     closedElevation: 0.0,
                  //     closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  //       return ListTile(
                  //         leading: Image.asset(
                  //           'assets/avatar_logo.png',
                  //           width: 40,
                  //         ),
                  //         onTap: openContainer,
                  //         title: Text('List item ${index + 1}'),
                  //         subtitle: const Text('Secondary text'),
                  //       );
                  //     },
                  //   );
                  // }),
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
