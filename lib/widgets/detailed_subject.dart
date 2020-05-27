import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/globals/globals.dart';
import 'package:edusketch/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/icons.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'color_pickers.dart';
import 'package:edusketch/globals/globals.dart' as globals;

class DetailedSubject extends StatefulWidget {
  const DetailedSubject({Key key, this.doc, this.index, this.createMode}) : super(key: key);
  final DocumentSnapshot doc;
  final int index;
  final bool createMode;

  @override
  _DetailedSubjectState createState() => _DetailedSubjectState();
}

class _DetailedSubjectState extends State<DetailedSubject> {
  final _formKey = GlobalKey<FormState>();
  Widget _icon;
  Firestore db = Firestore.instance;
  SlideColorPicker _colorPicker;
  final key = GlobalKey<SlideColorPickerState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _goalController = TextEditingController();
  List<IconData> iconDataList = schoolIcons.values.toList();
  math.Random random = math.Random();

  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPickerShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        searchHintText: 'Search icon...',
        iconPackMode: IconPack.schoolIcons);
    _icon = Icon(icon);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    String iconString = iconDataList[random.nextInt(iconDataList.length)]
        .toString()
        .split('IconData(U+')[1]
        .split(')')[0];
    _icon = widget.createMode
        ? Icon(IconDataSolid(int.parse(iconString.substring(0, 1) + 'x' + iconString.substring(1))))
        : Icon(IconDataSolid(int.parse(widget.doc.data['icon'])));
    _colorPicker = SlideColorPicker(
      key: key,
      initialColor: widget.createMode
          ? Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
          : Color(int.parse(widget.doc.data['color'])),
    );
    _weightController.text = widget.createMode ? '1' : widget.doc.data['weight'].toString();
    if (!widget.createMode) {
      _nameController.text = widget.doc.data['name'];
      _goalController.text = widget.doc.data['goal'].toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _weightController.dispose();
    _goalController.dispose();
  }

  void updateData(DocumentSnapshot doc) async {
    String iconString = _icon.toString().split('IconData(U+')[1].split(')')[0].toLowerCase();
    await db.collection('Subjects').document(doc.documentID).updateData({
      'abbreviation': convertAbbreviation(_nameController.text),
      'icon': iconString.substring(0, 1) + 'x' + iconString.substring(1),
      'color': key.currentState.color.toString().split('(')[1].split(')')[0],
      'name': _nameController.text,
      'weight': _weightController.text,
      'goal': _goalController.text
    });
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Subjects').document(doc.documentID).delete();
    DocumentSnapshot snapshot = await db.collection('SubjectCount').document('count').get();
    db
        .collection('SubjectCount')
        .document('count')
        .updateData({'count': snapshot.data['count'] - 1});
  }

  void createData() async {
    String iconString = _icon.toString().split('IconData(U+')[1].split(')')[0].toLowerCase();
    DocumentSnapshot snapshot = await db.collection('SubjectCount').document('count').get();
    await db.collection('Subjects').add({
      'abbreviation': convertAbbreviation(_nameController.text),
      'average': 0.0,
      'plusPoints': 0.0,
      'icon': iconString.substring(0, 1) + 'x' + iconString.substring(1),
      'color': key.currentState.color.toString().split('(')[1].split(')')[0],
      'name': _nameController.text,
      'weight': _weightController.text,
      'goal': _goalController.text,
      'order': snapshot.data['count']
    }).catchError((e) => print(e));
    db
        .collection('SubjectCount')
        .document('count')
        .updateData({'count': snapshot.data['count'] + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.navigate_before,
                size: 40,
              ),
            ),
            title: Text(
              'Edit subject',
              style: Theme.of(context).textTheme.headline4,
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                onPressed: () =>
                    {Navigator.pop(context), widget.createMode ? null : deleteData(widget.doc)},
                icon: Icon(Icons.delete),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: _pickIcon,
                        child: _icon,
                      ),
                      _colorPicker
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _weightController,
                    decoration: InputDecoration(labelText: 'Weight'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!globals.isWeight(double.parse(value))) {
                        return 'Please enter a weight';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _goalController,
                    decoration: InputDecoration(labelText: 'Goal'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!globals.isGrade(int.parse(value))) {
                        return 'Please enter a Grade';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SubmitButton(
                    onPressed: () => {
                      if (_formKey.currentState.validate())
                        {
                          Navigator.pop(context),
                          widget.createMode ? createData() : updateData(widget.doc)
                        }
                    },
                    text: widget.createMode ? 'Create' : 'Apply',
                    color: Colors.pink,
                  )
                ]),
              ),
            ),
          )),
    );
  }
}
