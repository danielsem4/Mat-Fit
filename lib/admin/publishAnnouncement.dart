import 'package:flutter/material.dart';
import 'package:fit_app/database.dart';
// Define a custom Form widget.

class PublishAnnouncement extends StatefulWidget {

  @override
  _PublishAnnouncementState createState() => _PublishAnnouncementState();
}

class _PublishAnnouncementState extends State<PublishAnnouncement> {
  @override
  Widget build(BuildContext context) {
      final myController = TextEditingController();
      DatabaseService mydb = new DatabaseService();

      // final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
      // ? 'DarkTheme' : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
      title: Text("300 calories of carbs a day"),
      backgroundColor: Colors.grey.shade900,
      centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade600,
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(60.0),
          child: TextField(
          controller: myController,
          decoration: InputDecoration(hintText: "Publish the following:",
          contentPadding: EdgeInsets.all(100),
          border: OutlineInputBorder()
          ),
          textDirection: TextDirection.rtl,
          
        ),
        )
        ,
        ElevatedButton(
          onPressed: (){
            mydb.addNewAnnouncement(myController.text);
        },
        child: Text("Publish"), 
        ),

      ],),
    );
    
  }
}