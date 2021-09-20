// import 'dart:html';

import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

// class Announcements extends StatefulWidget {
//   @override
//   _AnnouncementsState createState() => _AnnouncementsState();
// }

// class _AnnouncementsState extends State<Announcements> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Announcements"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [],
//       ),
//     );
//   }
// }
class Announcements extends StatefulWidget {
  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  Widget chatRoomList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Announcements')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                    snapshot.data.docs[index].data()['announcement'],
                    snapshot.data.docs[index].data()['date'],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Announcements",
        ),
        flexibleSpace: text == 'DarkTheme' ?
         Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.deepPurple,
                Colors.red
              ]
            )
          ),
        ) :
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.green,
                Colors.lime
              ]
            )
          ),
        ),
        centerTitle: true,
        
      ),
      body: Container(
        child: chatRoomList(),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String message;
  final Timestamp date;
  ChatRoomTile(
    this.message,
    this.date,
  );
  @override
  Widget build(BuildContext context) {
    String fulldate = date.toDate().day.toString() +
        "/" +
        date.toDate().month.toString() +
        "/" +
        date.toDate().year.toString() +
        "\n" +
        date.toDate().hour.toString() +
        ":" +
        date.toDate().minute.toString();
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
          actions: <Widget>[
            Align(
              child: Text(fulldate),
              alignment: Alignment.centerLeft,
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          content: Text(
            message,
            textDirection: TextDirection.rtl,
          ),
        );
            });
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[300])),
          child: Column(children: [
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  message,
                  textDirection: TextDirection.rtl,
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  fulldate,
                  textDirection: TextDirection.ltr,
                )),
          ])),
    );
  }
}