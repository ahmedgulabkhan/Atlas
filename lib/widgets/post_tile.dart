import 'package:Atlas/pages/blogpost_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:randomizer/randomizer.dart';

class PostTile extends StatefulWidget {

  final String userId;
  final String blogPostId;
  final String blogPostTitle;
  final String blogPostContent;
  final String date;

  PostTile({
    this.userId,
    this.blogPostId,
    this.blogPostTitle,
    this.blogPostContent,
    this.date
  });

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {

  FirebaseUser _user;

  Randomizer randomizer = Randomizer();
  List<Color> colorsList = [Color(0xFF083663), Color(0xFFFE161D), Color(0xFF682D27), 
    Color(0xFF61538D), Color(0xFF08363B), Color(0xFF319B4B), Color(0xFFF4D03F)];

  // initState
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  _getCurrentUser() async {
    _user = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlogPostPage(userId: _user.uid, blogPostId: widget.blogPostId)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: randomizer.getspecifiedcolor(colorsList),
            child: Text(widget.blogPostTitle.substring(0, 1).toUpperCase(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
          ),
          title: Text(
            widget.blogPostTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            widget.blogPostContent,
            style: TextStyle(fontSize: 13.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
          trailing: Text(widget.date, style: TextStyle(color: Colors.grey, fontSize: 12.0)),
        ),
      ),
    );
  }
}