import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {

  final Function toggleView;
  SignInPage({this.toggleView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is the Sign in page'),
      ),
    );
  }
}