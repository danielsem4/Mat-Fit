import 'package:fit_app/slider/changeThemeButton.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool valNotify1 = false;
  bool valNotify2 = true;
   

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

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: text == 'DarkTheme' ?
                 Colors.grey[800]: Colors.grey,
        title: Text("Settings",style: TextStyle(fontSize: 22),),
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
            Row(
              children: [
                Text("Dark Mode",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                Icon(Icons.mode_night_outlined),
                ChangeThemeButtonWidget(),
              ],)
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
              color: Colors.grey,
              ),
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.grey)
          ],
        ),
      ),
    );
  }
}