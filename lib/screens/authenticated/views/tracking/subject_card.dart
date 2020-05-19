import 'package:animations/animations.dart';
import 'package:edusketch/screens/authenticated/views/tracking/edit_subject.dart';
import 'package:edusketch/widgets/open_container_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    Key key,
    @required this.index,
    @required this.snapshot,
    @required this.subjectBackgroundGrade,
  }) : super(key: key);

  final num subjectBackgroundGrade;
  final int index;
  final snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 65),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        // Container ->   decoration: BoxDecoration(
        //     color: subjectBackground(
        //         subjectBackgroundGrade),
        //     borderRadius: BorderRadius.all(
        //       const Radius.circular(40.0),
        //     )),

        child: OpenContainerWrapper(
          destinationRoute: EditSubject(snapshot: snapshot, index: index),
          transitionDuration: Duration(milliseconds: 700),
          transitionType: ContainerTransitionType.fade,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: openContainer,
              child: ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.flask,
                  size: 30,
                ),
                title: Align(
                  alignment: Alignment(-1.2, 0),
                  child: Text(snapshot.data.documents[index].data['name']),
                ),
                trailing: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) =>
                      Container(
                    constraints: BoxConstraints(
                      maxWidth: 60,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                              minHeight: constraints.constrainHeight()),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: FaIcon(
                                    FontAwesomeIcons.check,
                                    size: 20,
                                    color: Colors.green[600],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot
                                        .data.documents[index].data['average']
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ]),
                        ),
                        Positioned(
                          bottom: 7,
                          right: 0,
                          child: Text(
                            'Weight:' +
                                snapshot.data.documents[index].data['weight']
                                    .toString() +
                                '%',
                            // style: isDarkBackground(
                            //         subjectBackgroundGrade)
                            //     ? Theme.of(
                            //             context)
                            //         .textTheme
                            //         .subtitle2
                            //     : Theme.of(
                            //             context)
                            //         .textTheme
                            //         .subtitle2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
