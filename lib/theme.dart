import 'package:flutter/material.dart';

final theme = ThemeData(
    primaryColor: Colors.lightBlue[600],
    // inputDecorationTheme: InputDecorationTheme(
    //   fillColor: Colors.white,
    //   filled: true,
    //   contentPadding: EdgeInsets.all(12.0),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(
    //       const Radius.circular(10.0),
    //     ),
    //     borderSide: BorderSide(color: Colors.grey[200], width: 2.0),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(
    //       const Radius.circular(10.0),
    //     ),
    //     borderSide: BorderSide(color: Colors.blue, width: 2.0),
    //   ),
    // ),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline3: TextStyle(fontSize: 40),
      subtitle1: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
      subtitle2: TextStyle(
          color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w800),
    ));
final TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
