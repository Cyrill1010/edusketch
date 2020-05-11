import 'package:animations/animations.dart';
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
    return Card(
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

      child: _OpenContainerWrapper(
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
                child: Text(snapshot.data.documents[index].data['title']),
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
                                  snapshot.data.documents[index].data['average']
                                      .toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
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
      // child: InkWell(
      //   borderRadius:
      //       BorderRadius.circular(25),
      //   onTap: () => OpenContainer(
      //     transitionType:
      //         ContainerTransitionType.fade,
      //     closedBuilder:
      //         (BuildContext context,
      //             void Function()
      //                 openContainer) {
      //       return
      //     },
      //     openBuilder:
      //         (BuildContext context,
      //             VoidCallback _) {
      //       return
      //     },
      //     tappable: false,
      //   ),

      //() => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (_) =>
      //             EditSubject())),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    this.closedBuilder,
    this.transitionType,
  });

  final OpenContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: Duration(seconds: 3),
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return _DetailsPage();
      },
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class _DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details page')),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black38,
            height: 250,
            child: Padding(
                padding: const EdgeInsets.all(70.0), child: Text('kjdskdklf')),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black54,
                        fontSize: 30.0,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  '_loremIpsumParagraph',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.black54,
                        height: 1.5,
                        fontSize: 16.0,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
