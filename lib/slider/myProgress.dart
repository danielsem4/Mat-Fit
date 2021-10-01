import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/slider/progresGallery.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:fit_app/slider/uploadMyProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class MyProgress extends StatefulWidget {

  @override
  _MyProgressState createState() => _MyProgressState();
}

  // DocumentSnapshot profileSnapshot;
  // void loadInfo() async {
  //   await databaseMethods.getUserName().then((val) {
  //     profileSnapshot = val;
  //   });
  // }
  // DatabaseService databaseMethods = new DatabaseService();

class _MyProgressState extends State<MyProgress> {
  DatabaseService dbService = DatabaseService();
  String email;
  String userName;
  String uid;
  File file;
  UploadTask task;
  QuerySnapshot searchSnapshot;

 
  void loadInfo() {
    try {
      dbService.getUserName().then((value){
        setState(() {
          email = value.data()['Email'];
        });
      });
    } catch (e) {
        print(e.toString());
    }
  }
  @override
  void initState() {
    loadInfo();
    super.initState();
  }
  // initiates the search query finds the correct usernames.
  void initiateSearch() {
    dbService
    .getUserProgressByUserEmail(email)
    .then((val) {
    setState(() {
      searchSnapshot = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    initiateSearch();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Progress"),
        centerTitle: true,
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
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset('assets/anumations/pro.json'),
            // Divider(thickness: 1.5),
            Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton.extended (
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                  Navigator.push(
                        context, 
                          MaterialPageRoute(builder: (context) => UploadMyProgress()));
                    },
                    label: Text(
                      "Add Progress",
                      style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                ),
              ),
            ),
            searchList(context)
          ],
        ),
      ),
    );
  }

  Widget searchList(BuildContext context) {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return progressTile(
                context: context,
                userEmail: searchSnapshot.docs[index]['Email'],
                userWeight: searchSnapshot.docs[index]['Weight'],
                userGoal: searchSnapshot.docs[index]['Goal'],
                userDate: searchSnapshot.docs[index]['Date'],
              );
            })
        : Container();
  }

  Widget progressTile({BuildContext context,String userEmail, String userWeight, String userGoal, String userDate}) {
     
      String uid;

      return InkWell(
         onTap: () {
           print(userDate);
           Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => ProgressGallery(userDate,userEmail)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Align(
                alignment: Alignment.topLeft,
                  child: Text(
                    'Date: $userDate',
                      style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                          ),
                      textDirection: TextDirection.ltr,
              )
            ),
            Align(
                alignment: Alignment.topLeft,
                  child: Text(
                    'Your Weight was: $userWeight',
                      style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                          ),
                      textDirection: TextDirection.ltr,
              )
            ),
            Align(
                alignment: Alignment.topLeft,
                  child: Text(
                    'Your Goal was: $userGoal',
                      style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                          ),
                      textDirection: TextDirection.ltr,
              )
            ),
          ],
        ),
      ),
    );
  }
}