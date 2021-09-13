import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
        backgroundColor: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
                 ),
      body: Column(
        children:[
          SizedBox(height: 100,),
           Center(
             child: CarouselSlider.builder(
               carouselController: controller,
               options: CarouselOptions(
                 height: 360,
                 initialPage: 0,
                 enlargeCenterPage: true,
                 enlargeStrategy: CenterPageEnlargeStrategy.height,
                 ),
               itemCount: gallLinks.length,
               itemBuilder: (context,index,realIndex) {
                 final urlImage = gallLinks[index];

                 return buildImage(urlImage,index);
               },
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 120),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12)
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white),
        onPressed: prev,
        ),
        SizedBox(width: 20),
        ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: text == 'DarkTheme' ?
                 Colors.deepPurple[400]: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12)
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white),
        onPressed: next,
        ),
    ],
           )
          ]
      ),
    );
  }
  Widget buildImage(String urlImage,int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 18),
    color: Colors.deepPurple[400],
    child: Image.network(
      urlImage,
      fit:BoxFit.cover,
    ),
  );

  void next() => controller.nextPage(duration: Duration(milliseconds: 500));

  void prev() => controller.previousPage(duration: Duration(milliseconds: 500));
}