import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class ContactMe extends StatefulWidget {
  
  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Contact Me"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Lottie.asset('assets/anumations/socialmedia.json'),
          SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 38),
              textStyle: TextStyle(fontSize: 26),
              primary: Colors.blueAccent
            ),
            icon: Icon(FontAwesomeIcons.youtube,color: Colors.red),
            label: Text('YouTube'),
            onPressed: () {},
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30),
              textStyle: TextStyle(fontSize: 26),
              primary: Colors.blueAccent
            ),
            icon: Icon(FontAwesomeIcons.whatsapp,color: Colors.green,),
            label: Text('WhatsApp'),
            onPressed: () {},
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32),
              textStyle: TextStyle(fontSize: 26),
              primary: Colors.blueAccent
            ),
            icon: Icon(FontAwesomeIcons.instagram,color: Colors.purpleAccent,),
            label: Text('Instegram'),
            onPressed: () {},
          )
        ]
      ),
    );
  }
}