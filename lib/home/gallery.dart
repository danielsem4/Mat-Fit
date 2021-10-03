import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:fit_app/widgets/photoWheel.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/database.dart';
import 'package:provider/provider.dart';


class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  DatabaseService dbService = new DatabaseService();
  List<String> gallLinks = [];
  final controller = CarouselController();

  void initState() {
    loadInfo();
    super.initState();
  }

  void loadInfo() async {
    try {
      dbService.getGalleries().then((value){
        setState(() {
          gallLinks = value;
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
    return gallLinks.length == 0 ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
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
      body: PhotoWheel(gallLinks)
    );
  }
}