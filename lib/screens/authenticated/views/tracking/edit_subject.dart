import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/widgets/color_pickers.dart';
import 'package:edusketch/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditSubject extends StatefulWidget {
  EditSubject({Key key, this.snapshot, this.index}) : super(key: key);
  final snapshot;
  final index;

  @override
  _EditSubjectState createState() => _EditSubjectState();
}

class _EditSubjectState extends State<EditSubject> {
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
    _icon = Icon(IconDataSolid(
        int.parse(widget.snapshot.data.documents[widget.index].data['icon'])));
    _colorPicker = SlideColorPicker(
      key: key,
      initialColor: Color(int.parse(
          widget.snapshot.data.documents[widget.index].data['color'])),
    );
    _nameController.text =
        widget.snapshot.data.documents[widget.index].data['name'];
    _weightController.text =
        widget.snapshot.data.documents[widget.index].data['weight'].toString();
    _goalController.text =
        widget.snapshot.data.documents[widget.index].data['goal'].toString();
  }

  void updateData(DocumentSnapshot doc) async {
    String iconString =
        _icon.toString().split('(IconData(U+')[1].split(')')[0].toLowerCase();
    await db.collection('Subjects').document(doc.documentID).updateData({
      'icon': iconString.substring(0, 1) + 'x' + iconString.substring(1),
      'color': key.currentState.color.toString().split('(')[1].split(')')[0],
      'name': _nameController.text,
      'weight': _weightController.text,
      'goal': _goalController.text
    });
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Subjects').document(doc.documentID).delete();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _weightController.dispose();
    _goalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot doc = widget.snapshot.data.documents[widget.index];
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            onPressed: () => {Navigator.pop(context), deleteData(doc)},
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
              onPressed: () => {Navigator.pop(context), updateData(doc)},
              text: 'Apply',
              color: Colors.pink,
            )
          ]),
        ),
      ),
    );
  }
}
