import 'package:fit_app/message/textinputWidget.dart';
import 'package:fit_app/message/messageBox.dart';
import 'package:fit_app/message/post.dart';
import 'package:flutter/material.dart';
import 'textinputWidget.dart';


class MyHomePage extends StatefulWidget {
  final String name;

  MyHomePage(this.name);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  
  void newPost(String text){
    this.setState(() {
      posts.add(new Post(text,widget.name));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mat-Fit')),
      body: Column(children: <Widget>[
        Expanded(child: PostList(this.posts)),
        TextInputWidget(this.newPost)
        ]));
  }
}

