import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SlideColorPicker extends StatefulWidget {
  SlideColorPicker({Key key, this.initialColor}) : super(key: key);
  final Color initialColor;

  @override
  SlideColorPickerState createState() => SlideColorPickerState();
}

class SlideColorPickerState extends State<SlideColorPicker> {
  @override
  void initState() {
    super.initState();
    currentColor = widget.initialColor;
  }

  Color get color => currentColor;

  Color currentColor;

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: currentColor,
      elevation: 3.0,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: SingleChildScrollView(
                child: SlidePicker(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  paletteType: PaletteType.rgb,
                  enableAlpha: false,
                  displayThumbColor: true,
                  showLabel: false,
                  showIndicator: true,
                  indicatorBorderRadius: const BorderRadius.vertical(
                    top: const Radius.circular(25.0),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
