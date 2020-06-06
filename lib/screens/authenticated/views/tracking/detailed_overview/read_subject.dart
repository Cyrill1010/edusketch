import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/globals/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadSubject extends StatelessWidget {
  const ReadSubject({Key key, this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: Color(int.parse(doc['color'])),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 2, spreadRadius: 0),
          ],
        ),
        child: ListTile(
            isThreeLine: false,
            leading: Icon(
              IconDataSolid(int.parse(doc['icon'])),
              size: 45,
              color: isLightColor(int.parse(doc['color']), 200) ? null : Colors.white,
            ),
            title: Text(
              doc['name'],
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: isLightColor(int.parse(doc['color']), 200) ? null : Colors.white),
            ),
            subtitle: Text('Weight: ' + (doc['weight'] * 100).toString() + '%',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: isLightColor(int.parse(doc['color']), 200) ? null : Colors.grey[300])),
            trailing: Tooltip(
              verticalOffset: 240,
              preferBelow: false,
              message: 'goal: ' + doc['goal'].toString(),
              child: doc['average'] != 0
                  ? RichText(
                      text: TextSpan(children: [
                      WidgetSpan(
                          child: FaIcon(
                        isGoalReached(doc['goal'], doc['average'])
                            ? FontAwesomeIcons.check
                            : FontAwesomeIcons.exclamationTriangle,
                        size: 20,
                        color: isGoalReached(doc['goal'], doc['average'])
                            ? Colors.green[600]
                            : Colors.red[600],
                      )),
                      TextSpan(
                          text: doc['average'].toString(),
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: isLightColor(int.parse(doc['color']), 200)
                                  ? null
                                  : Colors.grey[300]))
                    ]))
                  : FaIcon(
                      FontAwesomeIcons.solidQuestionCircle,
                      color: isLightColor(int.parse(doc['color']), 200) ? null : Colors.white,
                    ),
            )));
  }
}
