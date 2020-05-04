import 'package:flutter/material.dart';

// final darkTheme =                dont needed can use lightTheme.dark() see hive flutter dark mode switch
//     ThemeData(brightness: Brightness.dark, primaryColor: Colors.blueGrey);
final theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    textTheme: TextTheme(
        subtitle1: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        subtitle2: TextStyle(
            color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w800)));
final TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
