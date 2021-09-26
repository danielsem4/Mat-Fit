import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class DatabaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> saveUser(
    String email, String name, String lastName, String phoneNumber) async {
      Map<String, String> userInfoMap = {
        'Email': email,
        'Name': name,
        'Last_Name': lastName,
        'Phone_Number': phoneNumber,
        'Diet': 'false',
        'WorkoutPlan': 'false'
      };
      await users.doc(auth.currentUser.uid).set(userInfoMap);
      return;
    }

  Future<QuerySnapshot> getUserByUsername(String searchQuery) async {
    return await FirebaseFirestore.instance
      .collection('Users')
      .where('Name', isEqualTo: searchQuery)
      .get();
  }

  getUserName() async {
    return await users.doc(auth.currentUser.uid).get();
  }

  addNewAnnouncement(String announcement) async {
    if (announcement==""){
      return;
    }
    Map<String, Object> announcMap = {
      'announcement': announcement,
      'date': Timestamp.now(),
    };
    FirebaseFirestore.instance.collection('Announcements').add(announcMap);
  }

  getGalleries() async {
    List<String> links = [];
    try {
       firebase_storage.ListResult result =
        await firebase_storage.FirebaseStorage.instance.ref().child("gallery").listAll();
    for (firebase_storage.Reference ref in result.items) {
     String url = await firebase_storage.FirebaseStorage.instance
      .ref(ref.fullPath)
      .getDownloadURL();
        links.add(url);
    }
    return links;
    } catch (e) {
      print(e.toString());
    }
  }
  
  getRecommendation() async {
    List<String> links = [];
    try {
       firebase_storage.ListResult result =
        await firebase_storage.FirebaseStorage.instance.ref().child("recommendations").listAll();
    for (firebase_storage.Reference ref in result.items) {
     String url = await firebase_storage.FirebaseStorage.instance
      .ref(ref.fullPath)
      .getDownloadURL();
        links.add(url);
    }
    return links;
    } catch (e) {
      print(e.toString());
    }
  }

  addNewEvent(
    String title, String description, DateTime dateTime,String email,TimeOfDay time, String trainer) async {
    Map<String, Object> eventMap = {
      'dateTime': dateTime,
      'description': description,
      'id': email,
      'title': title,
      'trainer': trainer,
      'hours': time.toString(),
    };
    FirebaseFirestore.instance.collection('Events').add(eventMap);
  }
}

