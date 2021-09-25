import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_app/widgets/searchUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOfUsers extends StatefulWidget {

  @override
  _ListOfUsersState createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
Widget chatRoomList() {
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
                  return ChatRoomTile(
                    snapshot.data.docs[index].data()['Name'],
                    snapshot.data.docs[index].data()['Email'],
                    snapshot.data.docs[index].data()['Diet'],
                    snapshot.data.docs[index].data()['WorkoutPlan'],
                    snapshot.data.docs[index].data()['Phone_Number'],
                    snapshot.data.docs[index].data()['Last_Name'],
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
          "Users",
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
        child: chatRoomList(),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String name;
  final String email;
  final String diat;
  final String workout;
  final String phoneNum;
  final String lastName;
  ChatRoomTile(
    this.name,
    this.email,
    this.diat,
    this.workout,
    this.phoneNum,
    this.lastName
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                    "For "+ name + " " + lastName,
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
                            diat == "false" ?
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.restaurant),
                                  splashColor: Colors.grey,
                                  iconSize: 28,
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                            workout == "false" ?
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.directions_walk_sharp),
                                  splashColor: Colors.grey,
                                  iconSize: 30,
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                  "Name: " + name + " " + lastName,
                  style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                  textDirection: TextDirection.ltr,
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                 "Email: " + email,
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
                    diat == "true" ?
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
                    workout == "true" ?
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
                  "Phone: " + phoneNum,
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
}