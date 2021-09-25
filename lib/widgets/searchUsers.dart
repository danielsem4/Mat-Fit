import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_app/database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
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

  Widget SearchTile(
    {String userName, String userEmail, String userLastName, String userNum, String userDiet, String userWorkout}) {
    return GestureDetector(
      onTap: () {
        buildDialog();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("------------------------------------------------------------------------------------",
                style: TextStyle(
                color: Colors.grey.shade200
                )),
                Align(
                 alignment: Alignment.topLeft,
                  child: Text(
                    "Name: " + userName + " " + userLastName,
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
                      "Email: " + userEmail,
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
                 "Phone: " + userNum,
                 style: TextStyle (
                 fontSize: 16,
                 color: Colors.white
                ),
                textDirection: TextDirection.ltr,
                )),
                Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                              onPressed: () {
                  
                              },
                               icon: Icon(FontAwesomeIcons.infoCircle),
                               color: Colors.redAccent,
                               iconSize: 25,
                              ),
                ),
              Text(
                "Info",
                style: TextStyle(
                fontSize: 16,
                 color: Colors.white
              ),
              )
              ],
            ),
                Text(
                  "------------------------------------------------------------------------------------",
                style: TextStyle(
                color: Colors.grey.shade200
              ),
            ),
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
      body: GestureDetector(
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
              searchList()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDialog() {
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
              child: Icon(Icons.do_not_disturb_alt, size: 60,color: Colors.redAccent),
            ),
            Expanded(
              child: Container(
                color: Colors.blueGrey.shade700,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "The email dose not exists",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18
                           ) ,
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Back to login page"),
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
  }
}

