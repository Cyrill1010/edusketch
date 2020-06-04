import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/screens/authenticated/views/tracking/detailed_overview/detailed_overview.dart';
import 'package:edusketch/screens/authenticated/views/tracking/filter_bar/filter_bar.dart';
import 'package:edusketch/screens/authenticated/views/tracking/overall_overview/overall_overview.dart';
import 'package:edusketch/widgets/detailed_subject.dart';
import 'package:flutter/material.dart';

import 'detailed_overview/read_grades.dart';
import 'detailed_overview/read_subject.dart';

class TrackingView extends StatefulWidget {
  TrackingView({this.animationController});
  final AnimationController animationController;

  @override
  _TrackingViewState createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  String dropdownValue = 'Subjects';

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FilterBar(),
      Divider(
        thickness: 1,
      ),
      OverallOverview(),
      Divider(
        thickness: 1,
      ),
      Row(
        children: [
          Text('Detailed overview',
              style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.grey)),
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Subjects', 'Grades'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      StreamBuilder(
        stream: Firestore.instance.collection('Subjects').orderBy('order').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docs = snapshot.data.documents;
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return OpenContainer(
                    key: Key('$index'),
                    closedColor: Colors.white,
                    closedElevation: 0.0,
                    openBuilder: (BuildContext context, VoidCallback _) => (() {
                          switch (dropdownValue) {
                            case 'Subjects':
                              return DetailedSubject(
                                createMode: false,
                                doc: docs[index],
                                index: index,
                              );
                              break;
                            case 'Grades':
                              return DetailedSubject(
                                createMode: false,
                                doc: docs[index],
                                index: index,
                              );
                              break;
                            default:
                              return DetailedSubject(
                                createMode: false,
                                doc: docs[index],
                                index: index,
                              );
                          }
                        }()),
                    transitionDuration: Duration(milliseconds: 700),
                    closedBuilder: (BuildContext _, VoidCallback openContainer) => (() {
                          switch (dropdownValue) {
                            case 'Subjects':
                              return ReadSubject(
                                doc: docs[index],
                              );
                              break;
                            case 'Grades':
                              return ReadGrades(
                                doc: docs[index],
                                openContainer: openContainer,
                              );
                              break;
                            default:
                              return ReadSubject(
                                doc: docs[index],
                              );
                          }
                        }()));
              },
              itemCount: docs.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ]);
  }
}
