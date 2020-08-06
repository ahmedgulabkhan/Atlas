import 'package:Atlas/pages/authenticate_page.dart';
import 'package:Atlas/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your blogs'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authService.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthenticatePage()), (Route<dynamic> route) => false);
            }
          )
        ],
      ),
      body: Center(
        child: Text('This is the Homepage'),
      ),
    );
  }
}