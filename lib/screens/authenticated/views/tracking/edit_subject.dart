import 'package:edusketch/widgets/color_pickers.dart';
import 'package:edusketch/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class EditSubject extends StatefulWidget {
  EditSubject({Key key}) : super(key: key);

  @override
  _EditSubjectState createState() => _EditSubjectState();
}

class _EditSubjectState extends State<EditSubject> {
  Color currentColor = Color(0xff443a49);
  Widget _icon;

  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.cupertino);

    _icon = Icon(icon);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
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
            size: 35,
          ),
        ),
        title: Text('Hio'),
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
              children: <Widget>[
                RaisedButton(
                  onPressed: _pickIcon,
                  child: Text('Open IconPicker'),
                ),
                SizedBox(height: 10),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _icon != null ? _icon : Container()),
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
              onPressed: () => Navigator.pop(context),
              text: 'Apply',
              color: Colors.pink,
            )
          ]),
        ),
      ),
    );
  }
}
