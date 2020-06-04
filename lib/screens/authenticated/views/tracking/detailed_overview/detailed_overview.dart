import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/screens/authenticated/views/tracking/detailed_overview/read_grades.dart';
import 'package:edusketch/widgets/detailed_subject.dart';
import 'package:edusketch/widgets/reorderable_firebase_list.dart';
import 'package:flutter/material.dart';
import 'read_subject.dart';

// class DetailedOverview extends StatefulWidget {
//   DetailedOverview({Key key}) : super(key: key);

//   @override
//   _DetailedOverviewState createState() => _DetailedOverviewState();
// }

// class _DetailedOverviewState extends State<DetailedOverview> {
//   @override
//   Widget build(BuildContext context) {
//     String dropdownValue = 'Subjects';
//     return Container(
//         constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.8),
//         child: ReorderableFirebaseList(
//             header: Row(
//               children: [
//                 Text('Detailed overview',
//                     style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.grey)),
//                 DropdownButton<String>(
//                   value: dropdownValue,
//                   icon: Icon(Icons.arrow_downward),
//                   iconSize: 24,
//                   elevation: 16,
//                   style: TextStyle(color: Colors.deepPurple),
//                   underline: Container(
//                     height: 2,
//                     color: Colors.deepPurpleAccent,
//                   ),
//                   onChanged: (String newValue) {
//                     setState(() {
//                       dropdownValue = newValue;
//                     });
//                   },
//                   items:
//                       <String>['Subjects', 'Grades'].map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 )
//               ],
//             ),
//             collection: Firestore.instance.collection('Subjects'),
//             indexKey: 'order',
//             itemBuilder: (BuildContext context, int index, DocumentSnapshot doc) {
//               return OpenContainer(
//                   key: Key('$index'),
//                   closedColor: Colors.white,
//                   closedElevation: 0.0,
//                   openBuilder: (BuildContext context, VoidCallback _) => (() {
//                         switch (dropdownValue) {
//                           case 'Subjects':
//                             return DetailedSubject(
//                               createMode: false,
//                               doc: doc,
//                               index: index,
//                             );
//                             break;
//                           case 'Grades':
//                             return DetailedSubject(
//                               createMode: false,
//                               doc: doc,
//                               index: index,
//                             );
//                             break;
//                           default:
//                             return DetailedSubject(
//                               createMode: false,
//                               doc: doc,
//                               index: index,
//                             );
//                         }
//                       }()),
//                   transitionDuration: Duration(milliseconds: 700),
//                   closedBuilder: (BuildContext _, VoidCallback openContainer) => (() {
//                         switch (dropdownValue) {
//                           case 'Subjects':
//                             return ReadSubject(
//                               doc: doc,
//                             );
//                             break;
//                           case 'Grades':
//                             return ReadGrades(
//                               doc: doc,
//                               openContainer: openContainer,
//                             );
//                             break;
//                           default:
//                             return ReadSubject(
//                               doc: doc,
//                             );
//                         }
//                       }()));
//             }));
//   }
// }
