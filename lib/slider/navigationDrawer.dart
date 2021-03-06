import 'package:fit_app/authentication.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/firebaseStorage.dart';
import 'package:fit_app/slider/booktrain.dart';
import 'package:fit_app/slider/myDiet.dart';
import 'package:fit_app/slider/myProgress.dart';
import 'package:fit_app/slider/myWorkOut.dart';
import 'package:fit_app/slider/noDiet.dart';
import 'package:fit_app/slider/noWorkOut.dart';
import 'package:fit_app/slider/settings.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatefulWidget {

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {

  final padding = EdgeInsets.symmetric(horizontal: 20);
  final AuthenticationService _auth = AuthenticationService();

  String valDiet;
  String name = "";
  String lastName = "";
  String email = "";
  String valWorkout;
  DatabaseService dbService = new DatabaseService();

  @override
  void initState() {
    loadDiet();
    super.initState();
  }

  void loadDiet() async {
    try {
      dbService.getUserName().then((value){ 
        setState(() {
          valDiet = value.data()['Diet'];
          valWorkout = value.data()['WorkoutPlan'];
        });
      });
    } catch(e) {
        print(e.toString());
    }
    try {
      dbService.getUserName().then((vl){
        setState(() {
          name = vl.data()['Name'];
        });
      });
    } catch (e) {
        print(e.toString());
    }
    try {
      dbService.getUserName().then((vall){
        setState(() {
          email = vall.data()['Email'];
        });
      });
    } catch (e) {
        print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
  return Drawer(
      child: Material(
        color: text == 'DarkTheme' ?
        Colors.grey[800] : Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'My Diet',
                icon: Icons.restaurant,
                onClicked: () async {
                   if(this.valDiet == "false") {
                   Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => NoDiet())); //
                    } else {
                   final url = 'Diets/'+name+email+'.pdf';
                   final file = await PDFApi.loadFirebase(url);
                  if (file == null) return;
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyDiet(file: file))); 
                  }//
                }
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'My Workout Plan',
                icon: Icons.assignment_rounded,
                onClicked: ()  async {
                  if(this.valWorkout == "false") {
                   Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => NoMyWorkoutPlan())); //
                    } else {
                   final url = 'WorkoutPlans/'+name+email+'.pdf';
                   final file = await PDFApi.loadFirebase(url);
                  if (file == null) return;
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyWorkout(file: file))); 
                  }//
                }
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'Book a Training',
                icon: Icons.bookmark_add,
                onClicked: () => selectedItem(context, 2),
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'My Progress',
                icon: FontAwesomeIcons.walking,
                onClicked: () => selectedItem(context, 3),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white),
              const SizedBox(height: 24),
              buildMenuItem(
                text: 'Settings',
                icon: Icons.settings,
                onClicked: () => selectedItem(context, 4),
              ),
              buildMenuItem(
                text: 'Logout',
                icon: Icons.logout,
                onClicked: () => selectedItem(context, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem ({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon,color: color,),
      title: Text(text,style: TextStyle(color: color),),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      // case 0:
      // if(this.val == "true") {
      //   Navigator.of(context).push(
      //       MaterialPageRoute(builder: (context) => MyDiet(file: ))); //
      // } else {
      //   Navigator.push(
      //     context, 
      //       MaterialPageRoute(builder: (context) => NoDiet()));
      // }
      //  break;

       case 1:
        Navigator.push(
          context, 
            MaterialPageRoute(builder: (context) => NoMyWorkoutPlan()));
        break;
        
        case 2:
        Navigator.push(
          context, 
            MaterialPageRoute(builder: (context) => NewTrain()));
        break;

        case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyProgress()));
        break;
       
      case 4:
        Navigator.push(
          context, 
            MaterialPageRoute(builder: (context) => Settings()));
        break;

      case 5: 
          logOut();
        break;
    }
  }
  void logOut() async {
    await _auth.signOut();
  }
}
