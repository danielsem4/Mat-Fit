import 'dart:io';
import 'package:fit_app/slider/theme.dart';
import 'package:fit_app/slider/utlis.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMe extends StatefulWidget {
  
  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {

  void launchWhatsapp({@required number,@required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print("Eror");

  }
  
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: text == 'DarkTheme' ?
         Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.deepPurple,
                Colors.red
              ]
            )
          ),
        ) :
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.green,
                Colors.lime
              ]
            )
          ),
        ),
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
                    padding: const EdgeInsets.fromLTRB(75.0, 0.0, 100.0, 0.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.youtube,
                        color: Colors.redAccent[700],
                        size: 50.0,
                      ),
                      splashColor: Colors.red.shade800,
                      onPressed: () {}
                    ),
                  ),
                  SizedBox(height: 10),
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
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 100.0, 0.0),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green[400],
                    size: 50.0,
                  ),
                  splashColor: Colors.green,
                  onPressed: () {
                    openWhatsapp();
                  },
                ),
              ),
              SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 88.0, 0.0),
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
                    padding: const EdgeInsets.fromLTRB(80.0, 0.0, 100.0, 0.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.purpleAccent[700],
                        size: 50.0,
                      ),
                      splashColor: Colors.purple,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                    child: Text("Instegram",
                    style: TextStyle(
                      color:text == 'DarkTheme' ? 
                      Colors.white : Colors.black
                    )
                    ,),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: Colors.blue,
                        size: 50.0,
                      ),
                      splashColor: Colors.blueAccent,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
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
  openWhatsapp() async {
    var whatsapp = "0522462878";
    var whatsappURLandroid = "whatsapp://send?phone="+whatsapp;
    var whatsappURLios = "http://wa.me/$whatsapp?";

    if(Platform.isIOS) {
      // for ios phone
      if( await canLaunch(whatsappURLios)) {
        await launch(whatsappURLios);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Eror")));
      }
    } else { 
      // for android phone
       if( await canLaunch(whatsappURLandroid)) {
        await launch(whatsappURLandroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Eror")));
      }
    }

  }
}
