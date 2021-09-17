import 'package:flutter/material.dart';

class AdminCalendar extends StatefulWidget {

  @override
  _AdminCalendarState createState() => _AdminCalendarState();
}

class _AdminCalendarState extends State<AdminCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text("Calendar"),
         centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade700,
    );
  }
}