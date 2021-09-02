import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class MyWorkoutPlan extends StatefulWidget {
  @override
  _MyWorkoutPlanState createState() => _MyWorkoutPlanState();
}

class _MyWorkoutPlanState extends State<MyWorkoutPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food For Thought"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Lottie.asset('assets/anumations/workout.json'),
          SizedBox(height: 32),
          Text("You Dont Have a Workout Plan",style: TextStyle(fontSize: 26,color: Colors.green[700]),),
          SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20),
              textStyle: TextStyle(fontSize: 28),
            ),
            icon: Icon(Icons.sports_kabaddi),
            label: Text('Contact Me'),
            onPressed: () {},
          )
        ]
      ),
    );
  }
}


