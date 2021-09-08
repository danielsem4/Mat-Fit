import 'package:fit_app/admin/adminCalendar.dart';
import 'package:fit_app/admin/adminHomePage.dart';
import 'package:fit_app/admin/adminSettings.dart';
import 'package:fit_app/admin/publishAnnouncement.dart';
import 'package:fit_app/admin/uploadPhoto.dart';
import 'package:fit_app/authentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AdminNavigationBar extends StatefulWidget {

  @override
  _AdminNavigationBarState createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  
  int currIndex = 0;
  final screens = [
    AdminHomePage(),
    AdminCalendar(),
    PublishAnnouncement(),
    AdminSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currIndex,
        backgroundColor: Colors.grey.shade300,
        onTap: (index) => setState(() => currIndex = index),
        items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.blueAccent),
              label: 'Home',
              backgroundColor: Colors.grey.shade800,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarCheck,color: Colors.blueAccent),
              label: 'Calendar',
              backgroundColor: Colors.grey.shade800,
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.send,color: Colors.blueAccent),
              label: 'Message',
              backgroundColor: Colors.grey.shade800,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,color: Colors.blueAccent,),
              label: 'Settings',
              backgroundColor: Colors.grey.shade800,
            ),
        ],
      ),
      body: screens[currIndex],
    );
  }
}