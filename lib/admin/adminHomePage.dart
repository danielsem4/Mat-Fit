import 'package:fit_app/admin/adminCalendar.dart';
import 'package:fit_app/admin/adminSettings.dart';
import 'package:fit_app/admin/publishAnnouncement.dart';
import 'package:fit_app/admin/uploadPhoto.dart';
import 'package:fit_app/authentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminHomePage extends StatefulWidget {

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Coach"),
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade700,
      body: Column(
        children: [
          SizedBox(height: 40),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70.0, 25.0, 90.0, 0.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => PublishAnnouncement()));
                      },
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.white),
                        iconSize: 40,
                      ),
                    ),
                    Text("Send a Message",
                    style: TextStyle(
                      color: Colors.white
                  )),
                ]),
                Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => UploadPhoto()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.photoVideo,
                        color: Colors.white),
                        iconSize: 40,
                      ),
                      SizedBox(height: 3),
                      Text("Upload a Photo",
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                  ],
                ),
                ),
            ],
          ),
           SizedBox(height: 20),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70.0, 25.0, 90.0, 0.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => AdminCalendar()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.calendarCheck,
                        color: Colors.white),
                        iconSize: 40,
                      ),
                    ),
                    Text("Check Calendar",
                    style: TextStyle(
                      color: Colors.white
                  )),
                ]),
                Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 20.0, 0.0, 0.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => AdminSettings()));
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white),
                        iconSize: 40,
                      ),
                      Text("Settings",
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                  ],
                ),
                ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 80),
            child: ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white),
              label: Text("LogOut",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
                )),
              style: ElevatedButton.styleFrom(
                primary:Colors.grey.shade600,
                onPrimary: Colors.white,
                minimumSize: Size(250, 45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






