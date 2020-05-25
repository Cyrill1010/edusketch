import 'package:flutter/material.dart';

class AuthenticateInput extends StatelessWidget {
  const AuthenticateInput(
      {Key key, this.labelText, this.obscureText, this.validator, this.onChanged})
      : super(key: key);
  final String labelText;
  final bool obscureText;
  final Function validator;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.grey[200], width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            labelText: labelText),
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged);
  }
}
