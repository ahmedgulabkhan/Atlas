import 'package:flutter/material.dart';
import 'package:randomizer/randomizer.dart';

class UserDetailsPage extends StatelessWidget {

  final String userId;
  final String fullName;
  final String email;

  UserDetailsPage({
    this.userId,
    this.fullName,
    this.email
  });

  @override
  Widget build(BuildContext context) {

    Randomizer randomizer = Randomizer();
    List<Color> colorsList = [Color(0xFF083663), Color(0xFFFE161D), Color(0xFF682D27),
      Color(0xFF61538D), Color(0xFF08363B), Color(0xFF319B4B), Color(0xFFF4D03F)];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 30.0),
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundColor: randomizer.getspecifiedcolor(colorsList),
            child: Text(fullName.substring(0, 1).toUpperCase(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25.0)),
          ),

          SizedBox(height: 25.0),

          Center(child: Text(fullName)),

          SizedBox(height: 5.0),

          Center(child: Text(email)),
        ],
      ),
    );
  }
}