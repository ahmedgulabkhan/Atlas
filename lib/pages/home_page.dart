import 'package:Atlas/helper/helper_functions.dart';
import 'package:Atlas/pages/about_page.dart';
import 'package:Atlas/pages/authenticate_page.dart';
import 'package:Atlas/pages/create_blog_page.dart';
import 'package:Atlas/pages/search_page.dart';
import 'package:Atlas/services/auth_service.dart';
import 'package:Atlas/services/database_service.dart';
import 'package:Atlas/widgets/post_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _authService = new AuthService();
  FirebaseUser _user;
  String _userName = '';
  String _userEmail = '';
  Stream _blogPosts;

  // initState
  @override
  void initState() {
    super.initState();
    _getBlogPosts();
  }

  _getBlogPosts() async {
    _user = await FirebaseAuth.instance.currentUser();
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        _userName = value;
      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        _userEmail = value;
      });
    });
    DatabaseService(uid: _user.uid).getUserBlogPosts().then((snapshots) {
      setState(() {
        _blogPosts = snapshots;
      });
    });
  }


  Widget noBlogPostWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlogPage(uid: _user.uid, userName: _userName, userEmail: _userEmail)));
            },
            child: Icon(Icons.add_circle, color: Colors.grey[700], size: 100.0)
          ),
          SizedBox(height: 20.0),
          Text("You have not created any blog posts, tap on the 'plus' icon present above or at the bottom-right to create your first blog post."),
        ],
      )
    );
  }

  Widget blogPostsList() {
    return StreamBuilder(
      stream: _blogPosts,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data.documents != null && snapshot.data.documents.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                // return ListTile(
                //   title: Text(snapshot.data.documents[index].data['blogPostTitle']),
                //   subtitle: Text(snapshot.data.documents[index].data['blogPostContent']),
                //   trailing: Text(snapshot.data.documents[index].data['date']),
                // );
                return Column(
                  children: <Widget>[
                    PostTile(
                      userId: _user.uid,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Your blogs'),
        elevation: 0.0,        
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.only(top: 50.0),
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.home, color: Colors.black87),
                title: Text('Home', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.search, color: Colors.white),
                title: Text('Search', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('About', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
              ListTile(
                onTap: () async {
                  await _authService.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthenticatePage()), (Route<dynamic> route) => false);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.exit_to_app, color: Color(0xFFDC143C)),
                title: Text('Sign Out', style: TextStyle(color: Color(0xFFDC143C), fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
      body: blogPostsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlogPage(uid: _user.uid, userName: _userName, userEmail: _userEmail)));
        },
        child: Icon(Icons.add, color: Colors.white, size: 30.0),
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
      ),
    );
  }
}