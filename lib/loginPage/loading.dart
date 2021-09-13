import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Container(
      color: text == 'DarkTheme' ?
                 Colors.grey.shade900: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
          size: 60.0,
        ),
      ),
    );
  }
}