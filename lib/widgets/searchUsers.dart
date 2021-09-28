import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/firebaseStorage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';


class SearcUsers extends StatefulWidget {

  @override
  _SearcUsersState createState() => _SearcUsersState();
}

  DocumentSnapshot profileSnapshot;

void loadInfo() async {
  await databaseMethods.getUserName().then((val) {
    profileSnapshot = val;
  });
}

DatabaseService databaseMethods = new DatabaseService();
  
class _SearcUsersState extends State<SearcUsers> {
  DatabaseService dbService = new DatabaseService();
  TextEditingController nameC = new TextEditingController();
  QuerySnapshot searchSnapshot;
  File file;
  UploadTask task;

  Widget searchList(BuildContext context) {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                context: context,
                userName: searchSnapshot.docs[index]['Name'],
                userLastName: searchSnapshot.docs[index]['Last_Name'],
                userEmail: searchSnapshot.docs[index]['Email'],
                userNum: searchSnapshot.docs[index]['Phone_Number'],
                userDiet: searchSnapshot.docs[index]['Diet'],
                userWorkout: searchSnapshot.docs[index]['WorkoutPlan'],
              );
            })
        : Container(
          child: Text("User no found"),
        );
  }

  // ignore: non_constant_identifier_names
  Widget SearchTile(
    {BuildContext context,String userName, String userEmail, String userLastName, String userNum, String userDiet, String userWorkout}) {
    final fileName = file != null ?basename(file.path) : 'No File Selected';

    final String plan = "WorkoutPlans/";
    final String diet = "Diets/";
    String uid;

    return InkWell(
      onTap: () {
        dbService.getUserIdByEmail(userEmail).then((val){
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
        height: 170,
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              child: Text(
                    'For $userName $userLastName',
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
                        Text(
                          "Choose your action",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18
                           ) ,
                        ),
                        SizedBox(height: 12),
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
                            userDiet == "false" ?
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.restaurant),
                                  splashColor: Colors.grey,
                                  iconSize: 28,
                                  onPressed: () {
                                    dbService.updateUserDiet("true",uid);
                                    setState(() {
                                      userDiet = "true";
                                    });
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
                                    setState(() {
                                      userDiet = "false";
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Text(
                                  "Delete",
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
                            userWorkout == "false" ?
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.directions_walk_sharp),
                                  splashColor: Colors.grey,
                                  iconSize: 30,
                                  onPressed: () {
                                    dbService.updateUserPlan("true",uid);
                                    setState(() {
                                      userWorkout = "true";
                                    });
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
                                    setState(() {
                                      userWorkout = "false";
                                    });
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
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.white,thickness: 2,),
                Align(
                 alignment: Alignment.topLeft,
                  child: Text(
                    'Name: $userName $userLastName',
                      style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                      textDirection: TextDirection.ltr,
                    )),
                Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Text(
                      'Email: $userEmail',
                      style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                )),
                Align(
                alignment: Alignment.topLeft,
                child: Text (
                 'Phone: $userNum',
                 style: TextStyle (
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
                    userDiet == "true" ?
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
                    userWorkout == "true" ?
                    Icon (
                      Icons.check,
                      color: Colors.green
                      ) :
                    Icon (
                      Icons.cancel,
                      color: Colors.red
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white,thickness: 2,),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    loadInfo();
    super.initState();
  }
  // initiates the search query finds the correct usernames.
  void initiateSearch() {
    dbService
    .getUserByUsername(nameC.text)
    .then((val) {
    setState(() {
      searchSnapshot = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          "Search Users",
        ),
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
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {

          },
          child: Container(
            decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.grey[300]
                    )
                  ),
            child: Column(
              children: [
                Padding(
                      padding: const EdgeInsets.only(left:15.0,right: 15.0,top:15,bottom: 0),
                      child: TextField(
                        controller: this.nameC,
                        cursorColor: Colors.blueGrey,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon (
                              Icons.search,
                              color: Colors.grey.shade100,
                            ),
                            onPressed: () {
                                initiateSearch();
                            },
                          ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey,width: 3)
                            ),
                            focusedBorder: OutlineInputBorder(
                               borderRadius:  BorderRadius.circular(16),
                               borderSide: BorderSide(color: Colors.grey.shade100,width: 3), 
                            ),
                            prefixIcon: Icon(Icons.person,color: Colors.grey.shade100,),
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.grey[200]),
                            hintText: 'Enter The User Name',
                            hintStyle: TextStyle(color: Colors.grey.shade300)
                    ),
                  ),
                ),
                searchList(context)
              ],
            ),
          ),
        ),
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

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }
}
  