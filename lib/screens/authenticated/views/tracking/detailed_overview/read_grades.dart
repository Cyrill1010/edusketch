import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadGrades extends StatelessWidget {
  const ReadGrades({Key key, this.doc, this.openContainer}) : super(key: key);
  final DocumentSnapshot doc;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    final grades = doc['grades'];
    return Container(
        child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Color(int.parse(doc['color'])),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 2, spreadRadius: 0),
              ],
            ),
            child: ListView.separated(
              itemCount: doc['doc'].length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(doc['name']), Text(grades.length)],
                  );
                }
                index -= 1;
                return ListTile(
                  isThreeLine: false,
                  leading: Tooltip(
                      message: 'There are notes!',
                      child: FaIcon(
                        FontAwesomeIcons.notesMedical,
                        color: Colors.yellow,
                      )),
                  trailing: grades[index]['grade'],
                  title: Text(grades[index]['topic']),
                  subtitle: Row(
                    children: <Widget>[
                      Text('Type: ' + grades[index]['type'] + ' = ' + grades[index]['gradeWeight']),
                      Text(grades[index]['semester'] + ', ' + grades[index]['date'])
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  onTap: openContainer,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey,
                  height: 2.0,
                );
              },
            )));
  }
}
