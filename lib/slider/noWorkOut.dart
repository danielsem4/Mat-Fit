import 'package:fit_app/database.dart';
import 'package:fit_app/slider/contactMe.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class NoMyWorkoutPlan extends StatefulWidget {
  @override
  _MyWorkoutPlanState createState() => _MyWorkoutPlanState();
}

class _MyWorkoutPlanState extends State<NoMyWorkoutPlan> {

  bool val = false;

  DatabaseService dbService = new DatabaseService();

  @override
  void initState() {
    loadWorkout();
      super.initState();
  }

  void loadWorkout() async {
    try {
      dbService.getUserName().then((value){ 
        setState(() {
          val = value.data()['WorkoutPlan'];
        });
      });
    } catch(e) {
        print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';


    return Scaffold(
      appBar: AppBar(
        title: Text("Food For Thought",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
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
        centerTitle: true,
      ),
      body: Column(
        children: [
          Lottie.asset('assets/anumations/workout.json'),
          SizedBox(height: 32),
          Text("You Dont Have a Workout Plan",
          style: TextStyle(
            fontSize: 26,)),
          SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20),
              textStyle: TextStyle(fontSize: 28),
            ),
            icon: Icon(Icons.sports_kabaddi,color: Colors.white),
            label: Text('Contact Me',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
            onPressed: () {
              Navigator.push(
                context, 
                  MaterialPageRoute(builder: (context) => ContactMe()));
            },
          )
        ]
      ),
    );
  }
}


