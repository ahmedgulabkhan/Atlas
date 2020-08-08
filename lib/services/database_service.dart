import 'package:Atlas/models/BlogPostDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {

  final String uid;
  DatabaseService({
    this.uid
  });

  // Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  // update user data
  Future updateUserData(String fullName, String email, String password) async {
    return await userCollection.document(uid).setData({
      'fullName': fullName,
      'email': email,
      'password': password,
    });
  }

  // get user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).getDocuments();
    print(snapshot.documents[0].data);
    return snapshot;
  }

  // save blog post
  Future saveBlogPost(String title, String author, String authorEmail, String content) async {
    DocumentReference blogPostsRef = await Firestore.instance.collection('users').document(uid).collection('blogPosts').add({
      'userId': uid,
      'blogPostId': '',
      'blogPostTitle': title,
      'blogPostAuthor': author,
      'blogPostAuthorEmail': authorEmail,
      'blogPostContent': content,
      'createdAt': new DateTime.now(),
      'date': DateFormat.yMMMd('en_US').format(new DateTime.now())
    });

    await blogPostsRef.updateData({
        'blogPostId': blogPostsRef.documentID
    });

    return blogPostsRef.documentID;
  }

  // get user blog posts
  getUserBlogPosts() async {
    // return await Firestore.instance.collection("users").where('email', isEqualTo: email).snapshots();
    return Firestore.instance.collection('users').document(uid).collection('blogPosts').orderBy('createdAt').snapshots();
  }

  // get blog post details
  Future getBlogPostDetails(String blogPostId) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('users').document(uid).collection('blogPosts').where('blogPostId', isEqualTo: blogPostId).getDocuments();
    BlogPostDetails blogPostDetails = new BlogPostDetails(
      blogPostTitle: snapshot.documents[0].data['blogPostTitle'],
      blogPostAuthor: snapshot.documents[0].data['blogPostAuthor'],
      blogPostAuthorEmail: snapshot.documents[0].data['blogPostAuthorEmail'],
      blogPostContent: snapshot.documents[0].data['blogPostContent'],
      date: snapshot.documents[0].data['date'],
    );

    return blogPostDetails;
  }
}