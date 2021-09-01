import 'package:fit_app/message/post.dart';
import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  final List<Post> listItems;

  PostList(this.listItems);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
          child: Row(children: <Widget>[
           Expanded(
            child: ListTile(
              title: Text(post.body),
              subtitle: Text(post.author),
            )),
            ],
          ) 
        );
      }
    );
  }
}