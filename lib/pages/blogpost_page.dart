import 'package:Atlas/models/BlogPostDetails.dart';
import 'package:Atlas/services/database_service.dart';
import 'package:Atlas/shared/loading.dart';
import 'package:flutter/material.dart';

class BlogPostPage extends StatefulWidget {

  final String userId;
  final String blogPostId;

  BlogPostPage({
    this.userId,
    this.blogPostId
  });

  @override
  _BlogPostPageState createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {

  BlogPostDetails blogPostDetails = new BlogPostDetails();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getBlogPostDetails();
  }

  _getBlogPostDetails() async {
    await DatabaseService(uid: widget.userId).getBlogPostDetails().then((res) {
      setState(() {
        blogPostDetails = res;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.blogPostId),
      ),
      body: Center(
        child: Text('This is the post content'),
      ),
    );
  }
}