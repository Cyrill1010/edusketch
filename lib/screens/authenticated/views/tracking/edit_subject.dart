import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/widgets/color_pickers.dart';
import 'package:edusketch/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class EditSubject extends StatefulWidget {
  EditSubject({Key key, this.snapshot, this.index}) : super(key: key);
  final snapshot;
  final index;
  final db = Firestore.instance;

  @override
  _EditSubjectState createState() => _EditSubjectState();
}

class _EditSubjectState extends State<EditSubject> {
  Color currentColor = Color(0xff443a49);
  Widget _icon = Icon(Icons.ac_unit);

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

  void updateData(doc) async {
    await widget.db
        .collection('Subjects')
        .document(doc.documentID)
        .updateData({'name': 'please 🤫'});
    print(widget.db);
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Navigator.pop(context),
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
                SlideColorPicker(
                  initialColor: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Weight'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Goal'),
            ),
            SizedBox(
              height: 20,
            ),
            SubmitButton(
              onPressed: () => {
                Navigator.pop(context),
                updateData(widget.snapshot.data.documents[widget.index])
              },
              text: 'Apply',
              color: Colors.pink,
            )
          ]),
        ),
      ),
    );
  }
}
