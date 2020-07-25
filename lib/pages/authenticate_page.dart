import 'package:Atlas/pages/register_page.dart';
import 'package:Atlas/pages/signin_page.dart';
import 'package:flutter/material.dart';


class AuthenticatePage extends StatefulWidget {
  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {

  bool _showSignIn = true;
  
  void _toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_showSignIn) {
      return SignInPage(toggleView: _toggleView);
    }
    else {
      return RegisterPage(toggleView: _toggleView);
    }
  }
}