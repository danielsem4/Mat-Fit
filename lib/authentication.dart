import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email,String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email,String password}) async {
    try {
      await  _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
      }  catch (signUpError) {
          if(signUpError is PlatformException) {
            if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return "Eror";
        }
      }
      return "Eror";
    }
  }
}