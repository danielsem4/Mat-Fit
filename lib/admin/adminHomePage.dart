import 'package:fit_app/admin/adminCalendar.dart';
import 'package:fit_app/admin/adminSettings.dart';
import 'package:fit_app/admin/publishAnnouncement.dart';
import 'package:fit_app/admin/uploadPhoto.dart';
import 'package:fit_app/authentication.dart';
import 'package:fit_app/widgets/searchUsers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AdminHomePage extends StatefulWidget {

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final AuthenticationService _auth = AuthenticationService();
  String imageUrl;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Coach"),
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.white10,
              ]
            )
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade700,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
           padding: const EdgeInsets.all(25.0),
            child: Image.asset(
              ('assets/logo/logo_7.png'),
              width: 250,
              height: 165,
              fit: BoxFit.cover,
            ),),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70.0, 0.0, 90.0, 0.0),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 22.0, 0.0),
                        child: Text("Send Message",
                        style: TextStyle(
                          color: Colors.white
                    )),
                      ),
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
                        Text("Upload Photo",
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
                      padding: const EdgeInsets.fromLTRB(65.0, 25.0, 90.0, 0.0),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 18.0, 0.0),
                        child: Text("Check Calendar",
                        style: TextStyle(
                          color: Colors.white
                    )),
                      ),
                  ]),
                  Padding(
                  padding: const EdgeInsets.fromLTRB(52.0, 20.0, 0.0, 0.0),
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
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(62.0, 25.0, 90.0, 0.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                           context, 
                            MaterialPageRoute(builder: (context) => SearcUsers()));
                        },
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: Colors.white),
                          iconSize: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 0.0, 15.0, 0.0),
                        child: Text("Search User",
                        style: TextStyle(
                          color: Colors.white
                    )),
                      ),
                  ]),
                  Padding(
                  padding: const EdgeInsets.fromLTRB(56.0, 20.0, 0.0, 0.0),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                        await _auth.signOut();
                      },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white),
                          iconSize: 40,
                        ),
                        Text("LogOut",
                        style: TextStyle(
                          color: Colors.white
                        ),
                        ),
                    ],
                  ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}






