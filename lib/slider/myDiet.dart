import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/database.dart';
import 'package:provider/provider.dart';

class MyDiet extends StatefulWidget {

  @override
  _MyDietState createState() => _MyDietState();
}

class _MyDietState extends State<MyDiet> {

  String name = "";

  DatabaseService dbService = new DatabaseService();

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
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: Text(name + 's Diet'),
        backgroundColor: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
        centerTitle: true,
      ),
    );
  }
}