// import 'package:fit_app/authentication.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/home/aboutMe.dart';
import 'package:fit_app/home/recommendations.dart';
import 'package:fit_app/slider/contactMe.dart';
import 'package:fit_app/slider/navigationDrawer.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
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
        backgroundColor:  text == 'DarkTheme' ?
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
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutMe())
                 );
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: text == 'DarkTheme' ? 
                Colors.black87 : Colors.white),
              label: Text("About Me",
              style: TextStyle(
                fontSize: 20,
                color: text == 'DarkTheme' ? 
                MyThemes.darkTheme.primaryColor : MyThemes.lightTheme.primaryColor
                )),
              style: ElevatedButton.styleFrom(
                primary: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
                onPrimary: Colors.white,
                minimumSize: Size(250, 45),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.photo_camera_back,
              color: text == 'DarkTheme' ? 
                Colors.black87 : Colors.white),
              label: Text("Gallery",
              style: TextStyle(
                fontSize: 20,
                color: text == 'DarkTheme' ? 
                MyThemes.darkTheme.primaryColor : MyThemes.lightTheme.primaryColor),),
              style: ElevatedButton.styleFrom(
                primary:  text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
                onPrimary: Colors.white,
                minimumSize: Size(250, 45),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Recommendations())
                 );
              },
              icon: Icon(Icons.favorite_outline_sharp,
              color: text == 'DarkTheme' ? 
                Colors.black87 : Colors.white),
              label: Text("Recommendations",
              style: TextStyle(
                fontSize: 20,
                color: text == 'DarkTheme' ? 
                MyThemes.darkTheme.primaryColor : MyThemes.lightTheme.primaryColor
                )),
              style: ElevatedButton.styleFrom(
                primary:  text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
                onPrimary: Colors.white,
                minimumSize: Size(250, 45),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context, 
                    MaterialPageRoute(builder: (context) => ContactMe()));
              },
              icon: Icon(Icons.person_pin_circle_outlined,
              color: text == 'DarkTheme' ? 
                Colors.black87 : Colors.white),
              label: Text("Contact Me",
              style: TextStyle(
                fontSize: 20,
                color: text == 'DarkTheme' ? 
                MyThemes.darkTheme.primaryColor : Colors.white,
                )),
              style: ElevatedButton.styleFrom(
                primary: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
                onPrimary: Colors.white,
                minimumSize: Size(250, 45),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
