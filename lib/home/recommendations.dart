import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:fit_app/widgets/photoWheel.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/database.dart';
import 'package:provider/provider.dart';


class Recommendations extends StatefulWidget {
  @override
  _RecommendationStates createState() => _RecommendationStates();
}

class _RecommendationStates extends State<Recommendations> {
  DatabaseService dbService = new DatabaseService();
  List<String> reclLinks = [];
  final controller = CarouselController();

  void initState() {
    loadInfo();
    super.initState();
  }

  void loadInfo() async {
    try {
      dbService.getRecommendation().then((value){
        setState(() {
          reclLinks = value;
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
    return reclLinks.length == 0 ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
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
      body: PhotoWheel(reclLinks)
    );
  }
}