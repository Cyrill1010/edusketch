import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'color_pickers.dart';

class DetailedSubject extends StatefulWidget {
  const DetailedSubject({Key key, this.snapshot, this.index, this.createMode})
      : super(key: key);
  final AsyncSnapshot snapshot;
  final int index;
  final bool createMode;

  @override
  _DetailedSubjectState createState() => _DetailedSubjectState();
}

class _DetailedSubjectState extends State<DetailedSubject> {
  Widget _icon;
  Firestore db = Firestore.instance;
  SlideColorPicker _colorPicker;
  final key = GlobalKey<SlideColorPickerState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _goalController = TextEditingController();

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
    if (!widget.createMode) {
      _icon = Icon(IconDataSolid(int.parse(
          widget.snapshot.data.documents[widget.index].data['icon'])));
      _colorPicker = SlideColorPicker(
        key: key,
        initialColor: Color(int.parse(
            widget.snapshot.data.documents[widget.index].data['color'])),
      );
      _nameController.text =
          widget.snapshot.data.documents[widget.index].data['name'];
      _weightController.text = widget
          .snapshot.data.documents[widget.index].data['weight']
          .toString();
      _goalController.text =
          widget.snapshot.data.documents[widget.index].data['goal'].toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _weightController.dispose();
    _goalController.dispose();
  }

  void updateData(DocumentSnapshot doc, String icon, String color) async {
    await db.collection('Subjects').document(doc.documentID).updateData({
      'icon': icon,
      'color': color,
      'name': _nameController.text,
      'weight': _weightController.text,
      'goal': _goalController.text
    });
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Subjects').document(doc.documentID).delete();
  }

  void createData(String icon, String color) async {
    await db.collection('Subjects').add({
      'average': null,
      'icon': icon,
      'color': color,
      'name': _nameController.text,
      'weight': _weightController.text,
      'goal': _goalController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    String iconString =
        _icon.toString().split('(IconData(U+')[1].split(')')[0].toLowerCase();
    String finalIconString =
        iconString.substring(0, 1) + 'x' + iconString.substring(1);
    String finalColorString =
        key.currentState.color.toString().split('(')[1].split(')')[0];
    DocumentSnapshot doc = widget.snapshot.data.documents[widget.index];
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {Navigator.pop(context), deleteData(doc)},
            icon: Icon(
              Icons.delete,
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
              onPressed: () => {
                Navigator.pop(context),
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Form(
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
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _goalController,
                decoration: InputDecoration(labelText: 'Goal'),
              ),
              SizedBox(
                height: 20,
              ),
              SubmitButton(
                onPressed: () => {
                  Navigator.pop(context),
                  widget.createMode
                      ? createData(finalIconString, finalColorString)
                      : updateData(doc, finalIconString, finalColorString)
                },
                text: widget.createMode ? 'Create' : 'Apply',
                color: Colors.pink,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
