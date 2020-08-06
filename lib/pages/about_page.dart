import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        elevation: 0.0,
      ),
      body: Center(
        child: Text("This is the about page"),
      ),
    );
  }
}