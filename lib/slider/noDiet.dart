import 'package:fit_app/slider/contactMe.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoDiet extends StatefulWidget {

  @override
  _NoDietState createState() => _NoDietState();
}

class _NoDietState extends State<NoDiet> {
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: Text("Food For Thought"),
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
      body: Column(
        children: [
          Lottie.asset('assets/anumations/36895-healthy-or-junk-food.json'),
          SizedBox(height: 32),
          Text("You Dont Have a Diet",style: TextStyle(fontSize: 26),),
          SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20),
              textStyle: TextStyle(fontSize: 28),
              primary: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
            ),
            icon: Icon(Icons.restaurant_menu_outlined),
            label: Text('Contact Me'),
            onPressed: () {
              Navigator.push(
                context, 
                  MaterialPageRoute(builder: (context) => ContactMe()));
            },
          )
        ]
      ),
    );
  }
}