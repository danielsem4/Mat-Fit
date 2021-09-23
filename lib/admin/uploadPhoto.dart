import 'package:flutter/material.dart';


class UploadPhoto extends StatefulWidget {

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

 