import 'package:Atlas/services/database_service.dart';
import 'package:Atlas/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:randomizer/randomizer.dart';

class UserDetailsPage extends StatefulWidget {

  final String userId;
  final String fullName;
  final String email;

  UserDetailsPage({
    this.userId,
    this.fullName,
    this.email
  });

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {

  Stream _blogPosts;

  @override
  void initState() {
    super.initState();
    _getUserBlogPosts();
  }

  _getUserBlogPosts() {
    DatabaseService(uid: widget.userId).getUserBlogPosts().then((snapshots) {
      setState(() {
        _blogPosts = snapshots;
      });
      print(_blogPosts);
    });
  }


  Widget noBlogPostWidget() {
    return Center(
      child: Text('This user did not publish any blog posts...'),
    );
  }

  Widget blogPostsList() {
    return StreamBuilder(
      stream: _blogPosts,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data.documents != null && snapshot.data.documents.length != 0) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    PostTile(
                      userId: widget.userId,
                      blogPostId: snapshot.data.documents[index].data['blogPostId'],
                      blogPostTitle: snapshot.data.documents[index].data['blogPostTitle'],
                      blogPostContent: snapshot.data.documents[index].data['blogPostContent'],
                      date: snapshot.data.documents[index].data['date']
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(height: 0.0)
                    ),
                  ],
                );
              }
            );
          }
          else {
            return noBlogPostWidget();
          }
        }
        else {
          return noBlogPostWidget();
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    Randomizer randomizer = Randomizer();
    List<Color> colorsList = [Color(0xFF083663), Color(0xFFFE161D), Color(0xFF682D27),
      Color(0xFF61538D), Color(0xFF08363B), Color(0xFF319B4B), Color(0xFFF4D03F)];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fullName),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundColor: randomizer.getspecifiedcolor(colorsList),
              child: Text(widget.fullName.substring(0, 1).toUpperCase(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ),

            SizedBox(height: 25.0),

            Text(widget.fullName),

            SizedBox(height: 5.0),

            Text(widget.email),

            SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Blog Posts', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            blogPostsList()
          ],
        ),
      ),
    );
  }
}