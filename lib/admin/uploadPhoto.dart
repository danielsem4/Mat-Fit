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
        title: Text("Galery"),
        backgroundColor: Colors.grey.shade600,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade900,
    );
  }
}