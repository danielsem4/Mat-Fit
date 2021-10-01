import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/firebaseStorage.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class UploadMyProgress extends StatefulWidget {
  final DateTime selectedday;

  const UploadMyProgress({Key key, this.selectedday}) : super(key: key);
  @override
  State<UploadMyProgress> createState() => _UploadMyProgress();
}

  DocumentSnapshot profileSnapshot;
  DatabaseService databaseMethods = new DatabaseService();

  void loadInfo() async {
    await databaseMethods.getUserName().then((val) {
      profileSnapshot = val;
    });
  }

class _UploadMyProgress extends State<UploadMyProgress> {

  DatabaseService dbService = DatabaseService();
  TextEditingController weightC = new TextEditingController();
  TextEditingController goalC = new TextEditingController();
  String email = "";
  String userName = "";
  String uid;
  String day = DateTime.now().day.toString();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();
  String time = "";
  File file;
  UploadTask task;
  List<File> files = [];
  int counter = 0;

  @override
  void initState() {
    loadInfo();
    super.initState();
  }
  
   void loadInfo() async {
    try {
      dbService.getUserName().then((value){
        setState(() {
          email = value.data()['Email'];
          userName = value.data()['Name'];
          time = '$day.$month.$year';
        });
      });
    } catch (e) {
        print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme'; 
    
    return Scaffold(
      appBar: AppBar(
        title: Text("No Pain No Gain"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
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
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
             Navigator.pop(context);
          }
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent
              ),
              onPressed: () async {
                dbService.saveUserProgress(email, weightC.text ,goalC.text, time);
                uploadPhoto();
                Navigator.of(context).pop();
              },
               child: Text(
                 "Save",
                 style: TextStyle(
                 color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(26.0),
        children: <Widget> [
          FormBuilder(
            child: Column(
              children: [
                FormBuilderTextField(
                name: "title",
                controller: this.weightC,
                decoration: InputDecoration(
                  hintText: "Your weight",
                  border: InputBorder.none,
                  prefixIcon: Icon(FontAwesomeIcons.weight),
                )),
                Divider (
                  thickness: 2.5,
                ),
                FormBuilderTextField(
                  controller: this.goalC,
                  name: "description",
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Your Goal till the next ",
                    prefixIcon: Icon(FontAwesomeIcons.bullseye),
                  ),
                ),
                Divider (
                  thickness: 2.5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      dbService.getUserIdByEmail(email).then((val){
                      setState(() {
                        uid = val;
                      });
                    });
                      selectPic();
                    },
                    child: Row(
                      children: [
                        Text(" "),
                        Icon(
                          Icons.photo,
                          color: Colors.grey.shade400,
                        ),
                        Text(
                          "   Select Photos",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.shade400
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider (
                  thickness: 2.5,
                ),
                Lottie.asset('assets/anumations/weight.json'),
              ],
            ) 
          )
        ],
      ),
    );
  }

  Future selectPic() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if(result == null) return;

    setState(() {
      files = result.paths.map((path) => File(path)).toList();
    });
    print(files.length);
  }

  Future uploadPhoto() async {
    if(files.isEmpty) return;
     
    for (file in files) {
      final fileName = uid;
      final destination = 'userprogress/$email/$time/$fileName$counter';

      task = FirebaseApi.uploadFile(destination, file);

      if(task == null) return;
      setState(() {
        counter+=1;
      });
    }
  }
}
