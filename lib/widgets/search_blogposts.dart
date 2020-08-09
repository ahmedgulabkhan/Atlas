import 'package:Atlas/services/database_service.dart';
import 'package:Atlas/widgets/post_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

 class SearchBlogPosts extends StatefulWidget {

  @override
  _SearchBlogPostsState createState() => _SearchBlogPostsState();
}

class _SearchBlogPostsState extends State<SearchBlogPosts> {
   
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  bool _isLoading = false;
  bool _hasUserSearched = false;

  _initiateSearch() async {
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        _isLoading = true;
      });
      await DatabaseService().searchBlogPostsByName(searchEditingController.text).then((snapshot) {
        searchResultSnapshot = snapshot;
        // print(searchResultSnapshot.documents.length);
        setState(() {
          _isLoading = false;
          _hasUserSearched = true;
        });
      });
    }
  }

  Widget blogPostsList() {
    return _hasUserSearched ? (searchResultSnapshot.documents.length == 0) ? 
    Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: Center(child: Text('No results found...')),
    )
    : 
    ListView.builder(
      shrinkWrap: true,
      itemCount: searchResultSnapshot.documents.length,
      itemBuilder: (context, index) {
        // return ListTile(
        //   title: Text(
        //     searchResultSnapshot.documents[index].data["blogPostTitle"], style: TextStyle(fontWeight: FontWeight.bold),
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 1,
        //   ),
        //   subtitle: Text(
        //     searchResultSnapshot.documents[index].data["blogPostContent"], style: TextStyle(fontSize: 13.0),
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 4,
        //   ),
        // );
        return Column(
          children: <Widget>[
            PostTile(
              userId: searchResultSnapshot.documents[index].data["userId"],
              blogPostId: searchResultSnapshot.documents[index].data['blogPostId'],
              blogPostTitle: searchResultSnapshot.documents[index].data['blogPostTitle'],
              blogPostContent: searchResultSnapshot.documents[index].data['blogPostContent'],
              date: searchResultSnapshot.documents[index].data['date']
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 0.0)
            ),
          ],
        );
      }
    )
  :
  Container();
  }

   @override
   Widget build(BuildContext context) {
     return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            color: Colors.black87,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchEditingController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search blog posts...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      border: InputBorder.none
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _initiateSearch();
                  },
                  child: Container(
                    height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Icon(Icons.search, color: Colors.white)
                  )
                )
              ],
            ),
          ),
          _isLoading ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: Center(child: CircularProgressIndicator()),
          ) : blogPostsList()
        ]
      ),
    );
  }
}