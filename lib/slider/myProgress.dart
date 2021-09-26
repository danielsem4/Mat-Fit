import 'package:fit_app/slider/theme.dart';
import 'package:fit_app/slider/uploadMyProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class MyProgress extends StatefulWidget {

  @override
  _MyProgressState createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        title: Text("My Progress"),
        centerTitle: true,
        flexibleSpace: text == 'DarkTheme' ?
         Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.deepPurple,
                Colors.red
              ]
            )
          ),
        ) :
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.green,
                Colors.lime
              ]
            )
          ),
        )
      ),
      body: Column(
        children: [
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: FloatingActionButton (
            child: Icon(Icons.add),
            backgroundColor: Colors.grey.shade600,
            splashColor: Colors.grey.shade200,
            onPressed: () {
              Navigator.push(
                context, 
                  MaterialPageRoute(builder: (context) => UploadMyProgress()));
            },
          ),
        ), 
        ],
      ),
    );
  }
}