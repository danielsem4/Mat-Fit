import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MyStudio extends StatefulWidget {

  @override
  _MyStudioState createState() => _MyStudioState();
}

class _MyStudioState extends State<MyStudio> {
  @override
  Widget build(BuildContext context) {

    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        title: Text("My Studio"),
        centerTitle: true,
        backgroundColor:  text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(height: 180),
          text == 'LightTheme' ?
          Lottie.asset('assets/anumations/comingsoon2.json')
          : Lottie.asset('assets/anumations/comingsoon3.json') 
        ],)
    );
  }
}