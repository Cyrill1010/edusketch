import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadGrades extends StatelessWidget {
  const ReadGrades({Key key, this.doc, this.openContainer}) : super(key: key);
  final DocumentSnapshot doc;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(doc['name']), Text(doc['grades'].length.toString())],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: doc['grades'].length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    isThreeLine: false,
                    leading: Tooltip(
                        message: 'Notice the notes!',
                        child: FaIcon(
                          FontAwesomeIcons.notesMedical,
                          color: Colors.yellow,
                        )),
                    trailing: doc['grades'][index]['grade'],
                    title: Text(doc['grades'][index]['topic']),
                    subtitle: Row(
                      children: <Widget>[
                        Text('Type: ' +
                            doc['grades'][index]['type'] +
                            ' = ' +
                            doc['grades'][index]['gradeWeight']),
                        Text(doc['grades'][index]['semester'] + ', ' + doc['grades'][index]['date'])
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    onTap: openContainer,
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.grey,
                      height: 2.0,
                    );
                  },
                ),
              ],
            )));
  }
}
