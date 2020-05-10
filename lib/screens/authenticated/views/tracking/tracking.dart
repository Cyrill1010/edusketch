import 'package:edusketch/screens/authenticated/views/tracking/edit_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        filterBar,
        Expanded(
          child: ListView(
            children: <Widget>[
              overallOverview,
              StreamBuilder(
                stream: widget.db
                    .collection('Subjects')
                    .orderBy('order')
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Container(
                          constraints: BoxConstraints(maxHeight: 200),
                          child: ReorderableListView(
                              header: Text('Detailed Overview',
                                  style: Theme.of(context).textTheme.headline5),
                              onReorder: (int oldIndex, int newIndex) {
                                if (newIndex < oldIndex) {
                                  for (var i = newIndex; i < oldIndex; i++) {
                                    widget.db
                                        .runTransaction((myTransaction) async {
                                      final doc = snapshot.data.documents[i];
                                      await myTransaction.update(
                                          doc.reference, {'order': i + 1});
                                    });
                                  }
                                  widget.db
                                      .runTransaction((myTransaction) async {
                                    final doc =
                                        snapshot.data.documents[oldIndex];
                                    await myTransaction.update(
                                        doc.reference, {'order': newIndex});
                                  });
                                }
                                if (newIndex > oldIndex) {
                                  for (var i = oldIndex; i < newIndex; i++) {
                                    widget.db
                                        .runTransaction((myTransaction) async {
                                      final doc = snapshot.data.documents[i];
                                      await myTransaction.update(
                                          doc.reference, {'order': i - 1});
                                    });
                                  }
                                  widget.db
                                      .runTransaction((myTransaction) async {
                                    final doc =
                                        snapshot.data.documents[oldIndex];
                                    await myTransaction.update(
                                        doc.reference, {'order': newIndex});
                                  });
                                }
                              },
                              scrollDirection: Axis.vertical,
                              children: List.generate(
                                  snapshot.data.documents.length,
                                  (index) => Hero(
                                        tag: 'edit subject',
                                        key: Key('$index'),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.white70,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          // Container ->   decoration: BoxDecoration(
                                          //     color: subjectBackground(
                                          //         subjectBackgroundGrade),
                                          //     borderRadius: BorderRadius.all(
                                          //       const Radius.circular(40.0),
                                          //     )),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            onTap: () => Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return EditSubject();
                                            })),
                                            child: ListTile(
                                              leading: FaIcon(
                                                FontAwesomeIcons.flask,
                                                size: 30,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.2, 0),
                                                child: Text(snapshot
                                                    .data
                                                    .documents[index]
                                                    .data['title']),
                                              ),
                                              trailing: LayoutBuilder(
                                                builder: (BuildContext context,
                                                        BoxConstraints
                                                            constraints) =>
                                                    Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 60,
                                                  ),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        constraints: BoxConstraints(
                                                            minHeight: constraints
                                                                .constrainHeight()),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .check,
                                                                  size: 20,
                                                                  color: Colors
                                                                          .green[
                                                                      600],
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .documents[
                                                                          index]
                                                                      .data[
                                                                          'average']
                                                                      .toString(),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle1,
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      Positioned(
                                                        bottom: 7,
                                                        right: 0,
                                                        child: Text(
                                                          'Weight:' +
                                                              snapshot
                                                                  .data
                                                                  .documents[
                                                                      index]
                                                                  .data[
                                                                      'weight']
                                                                  .toString() +
                                                              '%',
                                                          style: isDarkBackground(
                                                                  subjectBackgroundGrade)
                                                              ? Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))),
                        )
                      : SizedBox();
                },
              ),
            ],
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
