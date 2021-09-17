// import 'package:fit_app/authentication.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/home/aboutMe.dart';
import 'package:fit_app/home/gallery.dart';
import 'package:fit_app/home/recommendations.dart';
import 'package:fit_app/slider/announcements.dart';
import 'package:fit_app/slider/contactMe.dart';
import 'package:fit_app/slider/navigationDrawer.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

      return MaterialApp(
        color: Theme.of(context).primaryColor,
         theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Theme.of(context).primaryColor,
        ),
        themeMode: themeProvider.themeMode,
        darkTheme: MyThemes.darkTheme,
         home: Body()
        );
      },
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  // final AuthenticationService _auth = AuthenticationService();
  String name = "";

  DatabaseService dbService = new DatabaseService();

  @override
  void initState() {
    loadInfo();
    super.initState();
  }
  
   void loadInfo() async {
    try {
      dbService.getUserName().then((value){
        setState(() {
          name = value.data()['Name'];
        });
      });
    } catch (e) {
        print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final urLImage1 = 'assets/logo/logo_4.png';
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text('Hello ' + name),
        centerTitle: true,
        backgroundColor: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
      ),
      body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Image.asset(
            urLImage1,
            width: 300,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60.0, 25.0, 90.0, 0.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => AboutMe()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.readme,
                        color: text == 'DarkTheme' ?
                        Colors.deepPurple[400]: Colors.green
                        ),
                        splashColor: text == 'DarkTheme' ?
                        Colors.purple.shade400: Colors.green.shade500,
                        iconSize: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 22.0, 0.0),
                      child: Text("About Me",
                      style: TextStyle(
                        color: text == 'DarkTheme' ? 
                        Colors.white : Colors.black
                  )),
                    ),
                ]),
                Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => Gallery()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.cameraRetro,
                        color: text == 'DarkTheme' ?
                        Colors.deepPurple[400]: Colors.green
                        ),
                        splashColor: text == 'DarkTheme' ?
                        Colors.purple.shade400: Colors.green.shade500,
                        iconSize: 50,
                      ),
                      SizedBox(height: 3),
                      Text("Galery",
                      style: TextStyle(
                        color: text == 'DarkTheme' ? 
                        Colors.white : Colors.black
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        SizedBox(height: 40),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64.0, 25.0, 90.0, 0.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => ContactMe()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.mobileAlt,
                        color: text == 'DarkTheme' ?
                        Colors.deepPurple[400]: Colors.green
                        ),
                        splashColor: text == 'DarkTheme' ?
                        Colors.purple.shade400: Colors.green.shade500,
                        iconSize: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                      child: Text("Contact Me",
                      style: TextStyle(
                        color: text == 'DarkTheme' ? 
                        Colors.white : Colors.black
                  )),
                    ),
                ]),
                Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => Recommendations()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.heart,
                        color: text == 'DarkTheme' ?
                        Colors.deepPurple[400]: Colors.green
                        ),
                        splashColor: text == 'DarkTheme' ?
                        Colors.purple.shade400: Colors.green.shade500,
                        iconSize: 50,
                      ),
                      SizedBox(height: 3),
                      Text("Recommendation",
                      style: TextStyle(
                        color: text == 'DarkTheme' ? 
                        Colors.white : Colors.black
                      ),
                    ),
                  ],
                ),
              ),
            ],
        ),
        Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60.0, 45.0, 70.0, 0.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                         context, 
                          MaterialPageRoute(builder: (context) => Announcements()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.bell,
                        color: text == 'DarkTheme' ?
                        Colors.deepPurple[400]: Colors.green
                        ),
                        splashColor: text == 'DarkTheme' ?
                        Colors.purple.shade400: Colors.green.shade500,
                        iconSize: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 27.0, 0.0),
                      child: Text("Noticiations",
                      style: TextStyle(
                        color: text == 'DarkTheme' ? 
                        Colors.white : Colors.black
                  )),
                    ),
                ]),
      ],
    ));
  }
}
