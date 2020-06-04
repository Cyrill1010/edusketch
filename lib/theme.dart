import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: Colors.lightBlue[600],
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 20),
    headline2: TextStyle(fontSize: 30),
    headline3: TextStyle(fontSize: 20),
    subtitle1: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
    subtitle2: TextStyle(color: Colors.grey[700], fontSize: 8, fontWeight: FontWeight.w800),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  ),
);
final TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
