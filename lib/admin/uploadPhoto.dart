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
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
      ),
    );
  }
}

 