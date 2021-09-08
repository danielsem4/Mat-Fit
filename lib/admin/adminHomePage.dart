import 'package:fit_app/admin/publishAnnouncement.dart';
import 'package:fit_app/admin/uploadPhoto.dart';
import 'package:fit_app/authentication.dart';
import 'package:flutter/material.dart';


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
        title: Text("Matan 3 month hituv"),
        backgroundColor: Colors.grey.shade600,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 80),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                 context, 
                  MaterialPageRoute(builder: (context) => PublishAnnouncement()));
              },
              icon: Icon(
                Icons.send_rounded,
                color: Colors.white),
              label: Text("Publish a Message",
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 80),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                 context, 
                  MaterialPageRoute(builder: (context) => UploadPhoto()));
              },
              icon: Icon(
                Icons.photo_camera,
                color: Colors.white),
              label: Text("Upload Photo",
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
