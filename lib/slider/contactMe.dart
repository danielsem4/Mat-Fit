import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ContactMe extends StatefulWidget {
  
  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
        title: Text("Contact Me"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Lottie.asset('assets/anumations/cycling.json'),
          SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 0.0, 100.0, 0.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.youtube,
                        color: Colors.redAccent[700],
                        size: 41.0,
                      ),
                      splashColor: Colors.red.shade800,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Youtube",
                  style: TextStyle(
                    color:text == 'DarkTheme' ? 
                    Colors.white : Colors.black
                  )
                  ,)
                ],
              ),
          SizedBox(height: 16),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green[400],
                    size: 41.0,
                  ),
                  splashColor: Colors.green,
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 88.0, 0.0),
                    child: Text("WhatsApp",
                    style: TextStyle(
                      color:text == 'DarkTheme' ? 
                      Colors.white : Colors.black
                    )
                    ,),
                  )
            ],
          ),
            ],
          ),
          SizedBox(height: 56),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 0.0, 100.0, 0.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.purpleAccent[700],
                        size: 41.0,
                      ),
                      splashColor: Colors.purple,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Instegram",
                  style: TextStyle(
                    color:text == 'DarkTheme' ? 
                    Colors.white : Colors.black
                  )
                  ,)
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.mailBulk,
                        color: Colors.red,
                        size: 41.0,
                      ),
                      splashColor: Colors.redAccent,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    child: Text("Mail",
                    style: TextStyle(
                      color:text == 'DarkTheme' ? 
                      Colors.white : Colors.black
                    )
                    ,),
                  )
                ],
              ),
            ],
          ),
        ]
      ),
    );
  }
}