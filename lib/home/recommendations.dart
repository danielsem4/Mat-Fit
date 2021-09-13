import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Recommendations extends StatefulWidget {

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations",
        style: TextStyle(
          color: text == 'LightTheme' ?
            Colors.black : Colors.white
         )),
        centerTitle: true,
        backgroundColor: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
      ),
    );
  }
}