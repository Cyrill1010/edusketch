import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[filterBar, overallOverview, detailedOverview],
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
      Table(
        children: <TableRow>[TableRow()],
      )
    ],
  ));

  final Widget detailedOverview = Container(
      child: Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[],
      ),
      Table()
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
