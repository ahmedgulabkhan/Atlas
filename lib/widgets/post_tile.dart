import 'dart:math';

import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {

  final String blogPostTitle;
  final String blogPostContent;
  final String date;

  PostTile({
    this.blogPostTitle,
    this.blogPostContent,
    this.date
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.blueAccent,
          child: Text(blogPostTitle.substring(0, 1).toUpperCase(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        ),
        title: Text(blogPostTitle, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(blogPostContent, style: TextStyle(fontSize: 13.0)),
        trailing: Text(date),
      ),
    );
  }
}