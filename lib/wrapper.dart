import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/admin/adminHomePage.dart';
import 'package:fit_app/admin/publishAnnouncement.dart';
import 'package:fit_app/home/homePage.dart';
import 'package:fit_app/loginPage/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return LoginPage();
    } else {
      if(user.email=="admin@admin.admin")
        return AdminHomePage();
      return HomePage();
    }
  }
}