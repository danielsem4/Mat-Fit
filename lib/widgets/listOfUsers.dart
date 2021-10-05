import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_app/admin/addEvent.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/firebaseStorage.dart';
import 'package:fit_app/widgets/searchUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ListOfUsers extends StatefulWidget {
 final DateTime selectedday;
 const ListOfUsers({Key key, this.selectedday,}) : super(key: key);
  @override
  _ListOfUsersState createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  File file;
  Widget usersList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .orderBy("Name", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return UsersList(
                    snapshot.data.docs[index].data()['Name'],
                    snapshot.data.docs[index].data()['Email'],
                    snapshot.data.docs[index].data()['Diet'],
                    snapshot.data.docs[index].data()['WorkoutPlan'],
                    snapshot.data.docs[index].data()['Phone_Number'],
                    snapshot.data.docs[index].data()['Last_Name'],
                    widget.selectedday
                  );
                })
            : Container(
              child: Text("No Users... "),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          "Select user",
        ),
        actions: <Widget> [
          IconButton(
          color: Colors.white,
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => SearcUsers()));
          },
        ),
        ],
        flexibleSpace:
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.grey,
                Colors.white10,
              ]
            )
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: usersList(),
      ),
    );
  }
}

class UsersList extends StatefulWidget {
  final String name;
  final String email;
  final String diat;
  final String workout;
  final String phoneNum;
  final String lastName;
  final DateTime date;
  UsersList(
    this.name,
    this.email,
    this.diat,
    this.workout,
    this.phoneNum,
    this.lastName,
    this.date
  );

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  DatabaseService dbService = new DatabaseService();
  String uid;
  File file;
  final String plan = "WorkoutPlans/";
  final String diet = "Diets/";
  UploadTask task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dbService.getUserIdByEmail(widget.email).then((val){
          setState(() {
            uid = val;
          });
        });
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      child: Container(
        height: 200,
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              child: Text(
                    'For ${widget.name} ${widget.lastName}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade700,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ElevatedButton (
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent
                          ),
                          onPressed: () {
                            Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AddEventPage(
                            userEmail: widget.email,userName: widget.name,selectedday: widget.date,)));
                          },
                        child: Text (
                          "Save For this user"
                        ),
                      ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.backspace_outlined),
                                  splashColor: Colors.grey,
                                  iconSize: 28,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 9.5,),
                            widget.diat == "false" ?
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.restaurant),
                                  splashColor: Colors.grey,
                                  iconSize: 28,
                                  onPressed: () {
                                    dbService.updateUserDiet("true",uid);
                                    addPdf();
                                  },
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                  fontSize: 14
                                  ),
                                ),
                                Text(
                                  "diet",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ) :
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.restaurant),
                                  splashColor: Colors.brown,
                                  iconSize: 28,
                                  onPressed: () {
                                    dbService.updateUserDiet("false",uid);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Text(
                                  "Delet",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                                Text(
                                  "diet",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 9.5,),
                            widget.workout == "false" ?
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.directions_walk_sharp),
                                  splashColor: Colors.grey,
                                  iconSize: 30,
                                  onPressed: () {
                                   dbService.updateUserPlan("true",uid);
                                   addPdf();
                                  },
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                  fontSize: 14
                                  ),
                                ),
                                Text(
                                  "plan",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ) :
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.directions_walk_sharp),
                                  splashColor: Colors.brown,
                                  iconSize: 30,
                                  onPressed: () {
                                    dbService.updateUserPlan("false",uid);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Text(
                                  "Delet",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                                Text(
                                  "plan",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 9.5,), 
                            Column(
                              children: [
                                IconButton (
                                  onPressed: () {
                                    uploadPdf(diet);
                                  },
                                   icon: Icon(Icons.file_upload_outlined),
                                   iconSize: 32,
                                  ),
                                Text(
                                  "Upload",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                                Text(
                                  "Diet",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 9.5,),
                            Column(
                              children: [
                                IconButton (
                                  onPressed: () {
                                    uploadPdf(plan);
                                  },
                                   icon: Icon(Icons.file_upload_rounded),
                                   iconSize: 32,
                                  ),
                                Text(
                                  "Upload",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                                Text(
                                  "Plan",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),  
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
      });
    },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration:
              BoxDecoration(
                border: Border.all(color: Colors.grey[300]
                )
              ),
          child: Column(children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Name: " + widget.name + " " + widget.lastName,
                  style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                  textDirection: TextDirection.ltr,
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                 "Email: " + widget.email,
                 style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                  textDirection: TextDirection.ltr,
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      "Diet: ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                      textDirection: TextDirection.ltr,
                      ),
                    widget.diat == "true" ?
                    Icon(
                      Icons.check,
                      color: Colors.green
                      ) :
                    Icon(Icons.cancel,
                      color: Colors.red
                      ),
                  ],
                ) 
                ),
            Align(
                alignment: Alignment.topLeft,
                child: Row (
                  children: [
                    Text (
                      "Workout: ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                    widget.workout == "true" ?
                    Icon (
                      Icons.check,
                      color: Colors.green
                      ) :
                    Icon(Icons.cancel,
                      color: Colors.red
                      ),
                  ],
                )
              ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Phone: " + widget.phoneNum,
                  style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                  textDirection: TextDirection.ltr,
                )
              ),
            ]
          )
        ),
    );
  }

  Future addPdf() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result == null) return;
    final path = result.files.single.path;

    setState(() {
      file = File(path);
    });
  }

  Future uploadPdf(String folder) async {
    if(file == null) return;

    final fileName = basename(file.path);
    final destination = '$folder$fileName';

    task = FirebaseApi.uploadFile(destination, file);

    if(task == null) return;
    setState(() {});


  }
}