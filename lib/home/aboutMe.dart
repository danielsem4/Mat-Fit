import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutMe extends StatefulWidget {

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final matansPhoto = 'assets/images/matan.png';
  String name = 'Matan Dayan';
  String email = 'matanDayam@gmail.com';
  String myPhone = 'Phone: 0546831162';
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
     final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
        centerTitle: true,
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
        )
                 ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 10
          ),
            CircleAvatar(
              radius: 130 ,
              backgroundImage: AssetImage(matansPhoto),
            ),
            SizedBox(
            height: 10
          ),
          Column(
            children: [
                 Text(
                  this.name,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                ),
              Text(
                this.email,
                style: TextStyle(color: Colors.blueGrey,fontSize: 16),
              ),
              Text(
                this.myPhone,
                style: TextStyle(color: Colors.blueGrey,fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: FractionalOffset(0.05,0.4),
              child:Text(
                'About',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),),
              const SizedBox(height: 8),
              Align(
                alignment: FractionalOffset(0.2,0.4),
              child: Text(
                "  .????????,???????????? ???? ?????? ???????? ???????? ???????? ???????? ?????? ???????????? ????????",
                style: TextStyle(fontSize: 16,height: 1.4),
              ),),
               const SizedBox(height: 8),
              Align(
                alignment: FractionalOffset(0.2,0.4),
              child: Text(
                "  ?????????? ?????????????????? ?????? ???????? ",
                style: TextStyle(fontSize: 16,height: 1.4),
              ),),
               const SizedBox(height: 8),
              Align(
                alignment: FractionalOffset(0.2,0.4),
              child: Text(
                "  My name is Matan Dayan I am a personal trainer,",
                style: TextStyle(fontSize: 16,height: 1.4),
              ),),
               const SizedBox(height: 8),
              Align(
                alignment: FractionalOffset(0.2,0.4),
              child: Text(
                "  My name is Matan Dayan I am a personal trainer,",
                style: TextStyle(fontSize: 16,height: 1.4),
              ),),
               const SizedBox(height: 8),
              Align(
                alignment: FractionalOffset(0.2,0.4),
              child: Text(
                "  My name is Matan Dayan I am a personal trainer,",
                style: TextStyle(fontSize: 16,height: 1.4),
              ),),
          ],)
        ],
      ),
    );
  }
}