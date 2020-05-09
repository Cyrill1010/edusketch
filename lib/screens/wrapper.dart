import 'package:edusketch/models/user.dart';
import 'package:edusketch/screens/authenticated/views.dart';
import 'package:flutter/material.dart';

import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Views();
    }
  }
}
