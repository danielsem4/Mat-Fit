import 'package:flutter/material.dart';

class AdminSettings extends StatefulWidget {

  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text("Settings"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade700,
    );
  }
}