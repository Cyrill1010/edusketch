import 'package:edusketch/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme.dart';
import 'models/user.dart';
import 'services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      catchError: (context, error) => Error(error.toString()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //TODO remove when development done
        title: 'Edusketch',
        theme: theme,
        home: Wrapper(),
      ),
    );
  }
}
