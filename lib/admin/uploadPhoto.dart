import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_app/firebaseStorage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';


class UploadPhoto extends StatefulWidget {

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  UploadTask task;
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: Text("Upload photo"),
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
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 140),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(65.0, 0.0, 0.0, 0.0),
                      child: IconButton (
                        onPressed: selectFile,
                        icon: Icon(Icons.photo_camera_back),
                        splashColor: Colors.grey,
                        color: Colors.white,
                        iconSize: 55,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(65.0, 0.0, 0.0, 14.0),
                      child: Text(
                        "Select Photo",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(85.0, 0.0, 0.0, 0.0),
                  child: IconButton (
                    onPressed: uploadPhoto,
                    icon: Icon(Icons.upload_sharp),
                    splashColor: Colors.grey,
                    color: Colors.white,
                    iconSize: 55,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(85.0, 0.0, 0.0, 0.0),
                  child: Text(
                    "Upload Photo",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(85.0, 0.0, 0.0, 0.0),
                  child: task != null ? buildUploadStatus(task) : Container(),
                ),
              ],
            ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(72.0, 0.0, 0.0, 0.0),
                      child: IconButton (
                        onPressed: selectFile,
                        icon: Icon(Icons.photo_camera_back),
                        splashColor: Colors.grey,
                        color: Colors.white,
                        iconSize: 55,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(72.0, 0.0, 0.0, 20.0),
                      child: Text(
                        "Select Rec",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(97.0, 0.0, 0.0, 0.0),
                  child: IconButton (
                    onPressed: uploadRec,
                    icon: Icon(Icons.upload_sharp),
                    splashColor: Colors.grey,
                    color: Colors.white,
                    iconSize: 55,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(97.0, 0.0, 0.0, 0.0),
                  child: Text(
                    "Upload Rec",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(85.0, 0.0, 0.0, 0.0),
                  child: task != null ? buildUploadStatus(task) : Container(),
                ),
              ],
            ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data;
        final progres = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progres * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        );
      } else {
        return Container();
      }
    }
  );

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result == null) return;
    final path = result.files.single.path;

    setState(() {
      file = File(path);
    });
  }

  Future uploadPhoto() async {
    if(file == null) return;

    final fileName = basename(file.path);
    final destination = 'gallery/$fileName';

    task = FirebaseApi.uploadFile(destination, file);

    if(task == null) return;
    setState(() {});

  }

  Future uploadRec() async {
    if(file == null) return;

    final fileName = basename(file.path);
    final destination = 'recommendations/$fileName';

    task = FirebaseApi.uploadFile(destination, file);

    if(task == null) return;
    setState(() {});

  }
}

 