import 'package:fit_app/slider/contactMe.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyDietPage extends StatefulWidget {
  
  @override
  _MyDietPageState createState() => _MyDietPageState();
}

class _MyDietPageState extends State<MyDietPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food For Thought"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Lottie.asset('assets/anumations/36895-healthy-or-junk-food.json'),
          SizedBox(height: 32),
          Text("You Dont Have a Diet",style: TextStyle(fontSize: 26,color: Colors.green[700]),),
          SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20),
              textStyle: TextStyle(fontSize: 28),
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