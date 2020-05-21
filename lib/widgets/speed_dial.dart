import 'package:flutter/material.dart';

class SpeedDial extends StatefulWidget {
  SpeedDial({this.controller, this.icons, this.onpressedFunctions, this.widgetList});
  final AnimationController controller;
  final List<IconData> icons;
  final List<Function> onpressedFunctions;
  final List<Widget> widgetList;

  @override
  State createState() => SpeedDialState();
}

class SpeedDialState extends State<SpeedDial> {
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.widgetList?.length ?? widget.icons.length, (int index) {
          return Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: widget.controller,
                  curve: Interval(
                      0.0, 1.0 - index / widget.widgetList?.length ?? widget.icons.length / 2.0,
                      curve: Curves.easeOut),
                ),
                child: widget.widgetList[index] ??
                    FloatingActionButton(
                        heroTag: null,
                        backgroundColor: backgroundColor,
                        mini: true,
                        child: Icon(widget.icons[index], color: foregroundColor),
                        onPressed: () => widget.onpressedFunctions[index]()),
              ));
        }).toList());
  }
}
