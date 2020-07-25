import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  final Function toggleView;
  RegisterPage({this.toggleView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is the Register page'),
      ),
    );
  }
}