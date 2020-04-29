import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrackingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          filterBar,
          ListView(
            children: <Widget>[overallOverview, DetailedOverview()],
          )
        ],
      ),
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

class DetailedOverview extends StatefulWidget {
  @override
  _DetailedOverviewState createState() => _DetailedOverviewState();
}

class _DetailedOverviewState extends State<DetailedOverview> {
  List<String> items = <String>['Chemistry', 'Physics', 'Frence'];

  _updateItems(int oldIndex, int newIndex) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: ReorderableListView(
          header: Text('Detailed Overview',
              style: Theme.of(context).textTheme.subtitle1),
          onReorder: (int oldIndex, int newIndex) {
            setState(_updateItems(oldIndex, newIndex));
          },
          scrollDirection: Axis.vertical,
          children: items
              .map((item) => ExpansionTile(
                    key: ValueKey(item),
                    backgroundColor: Colors.grey[200],
                    leading: FaIcon(
                      FontAwesomeIcons.flask,
                      size: 20,
                    ),
                    title: Text('Chemistry'),
                    trailing: IgnorePointer(),
                    children: <Widget>[
                      ListTile(title: Text('Title of the item')),
                      ListTile(
                        title: Text('Title of the item2'),
                      )
                    ],
                  ))
              .toList()),
    );
  }
}
