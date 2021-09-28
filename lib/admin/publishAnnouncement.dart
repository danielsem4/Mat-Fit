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
      title: Text("Write a message"),
      centerTitle: true,
      backgroundColor: Colors.grey.shade800,
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
      backgroundColor: Colors.grey.shade600,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(60.0),
            child: TextField(
            controller: myController,
            maxLines: 9,
            minLines: 1,
            decoration: InputDecoration(hintText: "Publish the following:",
            contentPadding: EdgeInsets.all(100),
            border: OutlineInputBorder(
              
            )
            ),
            textDirection: TextDirection.rtl,
            
          ),
          )
          ,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade500
            ),
            onPressed: (){
              mydb.addNewAnnouncement(myController.text);
              Navigator.of(context).pop();
          },
          child: Text("Publish"), 
          ),
      
        ],),
      ),
    );
    
  }
}