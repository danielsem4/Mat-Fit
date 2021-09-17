import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTrain extends StatefulWidget {

  @override
  _NewTrainState createState() => _NewTrainState();
}

class _NewTrainState extends State<NewTrain> {
  @override
  Widget build(BuildContext context) {
     final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Training"),
        centerTitle: true,
        backgroundColor: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
      ),
    );
  }
}