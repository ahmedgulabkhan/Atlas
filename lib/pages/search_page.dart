import 'package:flutter/material.dart';

 class SearchPage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        elevation: 0.0,
      ),
      body: Center(
        child: Text("This is the search page"),
      ),
    );
   }
 }