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

    Future<void> saveUserProgress(
    String email, String weight, String goal, String date) async {
      Map<String, String> userInfoMap = {
        'Email': email,
        'Weight': weight,
        'Goal': goal,
        'Date': date,
      };
      FirebaseFirestore.instance.collection('Progress').add(userInfoMap);
      return;
    }
  
  Future<QuerySnapshot> getUserByUsername(String searchQuery) async {
    return await FirebaseFirestore.instance
      .collection('Users')
      .where('Name', isEqualTo: searchQuery)
      .get();
  }

  Future<QuerySnapshot> getEventsByUserEmail(String searchQuery) async {
    return await FirebaseFirestore.instance
      .collection('Events')
      .where('id', isEqualTo: searchQuery)
      .get();
  }

  Future<QuerySnapshot> getUserProgressByUserEmail(String searchQuery) async {
    return await FirebaseFirestore.instance
      .collection('Progress')
      .where('Email', isEqualTo: searchQuery)
      .get();
  }
  getUserName() async {
    return await users.doc(auth.currentUser.uid).get();
  }

  getUserIdByEmail(String email) async {
    String ide;
    await getByUserEmail(email).then((value) async {
      ide = value.docs[0].id;
    });
    return ide;
  }

  Future<QuerySnapshot> getByUserEmail(String useremail) async {
    return await users
        .where('Email', isEqualTo: useremail)
        .get();
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
    String title, String description, String dateTime,String email,String time, String trainer) async {
    Map<String, Object> eventMap = {
      'dateTime': dateTime,
      'description': description,
      'id': email,
      'title': title,
      'trainer': trainer,
      'hours': time,
    };
    FirebaseFirestore.instance.collection('Events').add(eventMap);
  }

  Future updateUserPlan(String plan,String uid) async {
       await users.doc(uid).set({
      'WorkoutPlan': plan
    },SetOptions(merge: true));
  }
  
  Future updateUserDiet(String diet,String uid) async {
      await users.doc(uid).set({
        'Diet': diet
    },SetOptions(merge: true));
  }

  getProgressPhotos(String email,String date) async {
    List<String> links = [];
    try {
      firebase_storage.ListResult result =
      await firebase_storage.FirebaseStorage.instance.ref().child('userprogress/$email/$date').listAll();
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


}

