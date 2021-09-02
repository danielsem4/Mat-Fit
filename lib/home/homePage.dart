// import 'package:fit_app/authentication.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/home/aboutMe.dart';
import 'package:fit_app/slider/contactMe.dart';
import 'package:fit_app/slider/navigationDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Hello '+ name),
        centerTitle: true,),
        body: Body());
  }
}

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  // final AuthenticationService _auth = AuthenticationService();


  @override
  Widget build(BuildContext context) {
    final urLImage1 = 'assets/logo/logo_1.jpg';

    return SingleChildScrollView(
        child: Column(
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
              icon: Icon(Icons.info_outline_rounded),
              label: Text("About Me"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
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
              icon: Icon(Icons.photo_camera_back),
              label: Text("Gallery"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
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
              icon: Icon(Icons.favorite_outline_sharp),
              label: Text("Recommendations"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
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
              icon: Icon(Icons.person_pin_circle_outlined),
              label: Text("Contact Me"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
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
