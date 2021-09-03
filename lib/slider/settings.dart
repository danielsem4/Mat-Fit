import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool valNotify1 = false;
  bool valNotify2 = true;
  bool valNotify3 = false;

  valNotifyChange1(bool newVal) {
    setState(() {
      valNotify1 = newVal;
    });
  }

  valNotifyChange2(bool newVal) {
    setState(() {
      valNotify2 = newVal;
    });
  }

  valNotifyChange3(bool newVal) {
    setState(() {
      valNotify3 = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",style: TextStyle(fontSize: 22),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text("Account",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
              ],
            ),
            Divider(height: 20, thickness: 2.5),
            SizedBox(height: 10),
            buildAccountOptions(context, "Change Paswword"),
            buildAccountOptions(context, "Language"),
            buildAccountOptions(context, "Social"),
            SizedBox(height: 40),
            Row(
              children: [
                Icon(Icons.settings,color: Colors.grey),
                SizedBox(width: 10),
                Text("General",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold )),
              ],
            ),
            Divider(height: 20, thickness: 2.5),
            SizedBox(height: 10),
            buildGeneralOption("Dark Mode",valNotify1,valNotifyChange1),
            buildGeneralOption("Notifications",valNotify2,valNotifyChange2),
          ],
        )
      ,),
    );
  }

  Padding buildGeneralOption(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(
           fontSize: 20,
           fontWeight: FontWeight.w500,
           color: Colors.grey 
          )),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.green,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              }
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOptions(BuildContext context, String title) {
    return GestureDetector (
      onTap: () {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Todo")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
               child: Text("Close")
            )
          ],
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              ),
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.grey)
          ],
        ),
      ),
    );
  }
}