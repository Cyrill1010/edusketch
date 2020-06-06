import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadGrades extends StatelessWidget {
  ReadGrades({Key key, this.doc, this.openContainer}) : super(key: key);
  final DocumentSnapshot doc;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    final items = List<ListItem>.generate(doc['grades'].length + 1, (index) {
      return index == 0
          ? HeadingItem(
              leading: Text(doc['name']),
              trailing: Text(doc['average'].toString()),
            )
          : GradeItem(
              leading: Text('$index.'),
              trailing: Tooltip(
                message: 'Notice the notes!',
                child: Text.rich(
                    TextSpan(text: doc['grades'][index - 1]['grade'].toString(), children: [
                  WidgetSpan(
                      child: FaIcon(
                    FontAwesomeIcons.exclamation,
                    color: Colors.yellow,
                  )),
                ])),
              ),
              heading: Tooltip(
                message: 'Weight: ${doc['grades'][index - 1]['gradeWeight']}',
                child: Text(
                    '${doc['grades'][index - 1]['topic']}(${doc['grades'][index - 1]['type']})'),
              ),
            );
    });
    return Card(
      child: Container(
        height: 50.0 * items.length - 10,
        child: ListView.builder(
          itemExtent: 45,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Stack(
              alignment: Alignment(0, 1.5),
              children: [
                ListTile(
                  title: item.buildTitle(context),
                  leading: item.buildLeading(context),
                  trailing: item.buildTrailing(context),
                  onTap: openContainer,
                ),
                index != items.length - 1 ? Divider() : SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildLeading(BuildContext context);
  Widget buildTrailing(BuildContext context);
}

class HeadingItem implements ListItem {
  final Widget heading;
  final Widget leading;
  final Widget trailing;

  HeadingItem({this.heading, this.leading, this.trailing});

  Widget buildTitle(BuildContext context) => heading;
  Widget buildLeading(BuildContext context) => leading;
  Widget buildTrailing(BuildContext context) => trailing;
}

class GradeItem implements ListItem {
  final Widget leading;
  final Widget trailing;
  final Widget heading;

  GradeItem({this.heading, this.leading, this.trailing});

  Widget buildTitle(BuildContext context) => heading;
  Widget buildLeading(BuildContext context) => leading;
  Widget buildTrailing(BuildContext context) => trailing;
}
