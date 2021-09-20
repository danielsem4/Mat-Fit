import 'dart:io';

import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/database.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class MyDiet extends StatefulWidget {
  final File file;

  const MyDiet({
    Key key,
    @required this.file,
  }) : super(key: key);

  @override
  _MyDietState createState() => _MyDietState();
}

class _MyDietState extends State<MyDiet> {

  String name = "";
  DatabaseService dbService = new DatabaseService();

  List<String> dietLinks = [];

  @override
  void initState() {
    loadInfo();
    super.initState();
  }

  void loadInfo() async {
    try {
      dbService.getUserName().then((value){
        setState(() {
          name = value.data()['Name'];
        });
      });
    } catch (e) {
        print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: Text(name + 's Diet'),
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
        ),
        centerTitle: true,
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}