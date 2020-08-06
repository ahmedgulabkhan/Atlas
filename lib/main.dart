import 'package:Atlas/helper/helper_functions.dart';
import 'package:Atlas/pages/authenticate_page.dart';
import 'package:Atlas/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  bool _isLoggedIn = false;
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserLoggedInStatus();
  }

  _getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        _isLoggedIn = value;
      });
    });

    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        userName = value;
      });
    });

    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: (_isLoggedIn != null) ? _isLoggedIn ? HomePage(userName: userName, userEmail: userEmail) : AuthenticatePage() : AuthenticatePage(),
    );
  }
}
