import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}