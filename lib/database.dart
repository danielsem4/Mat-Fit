import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseService {
  
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> saveUser(String email,String name, String lastName, String phoneNumber) async {
    Map<String,String> userInfoMap = {
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

  getUserName() async {
    return await users.doc(auth.currentUser.uid).get();
  }
}