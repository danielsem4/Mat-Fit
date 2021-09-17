import 'package:fit_app/admin/adminCalendar.dart';
import 'package:fit_app/admin/adminHomePage.dart';
import 'package:fit_app/admin/adminSettings.dart';
import 'package:fit_app/admin/publishAnnouncement.dart';
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
              icon: Icon(Icons.home,color: Colors.white),
              label: 'Home',
              backgroundColor: Colors.grey.shade800,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarCheck,color: Colors.white),
              label: 'Calendar',
              backgroundColor: Colors.grey.shade800,
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.send,color: Colors.white),
              label: 'Message',
              backgroundColor: Colors.grey.shade800,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,color: Colors.white,),
              label: 'Settings',
              backgroundColor: Colors.grey.shade800,
            ),
        ],
      ),
      body: screens[currIndex],
    );
  }
}