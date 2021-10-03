import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoWheel extends StatefulWidget {
  final List<String> gallLinks;
  PhotoWheel(this.gallLinks);

  @override
  _PhotoWheelState createState() => _PhotoWheelState();
}

class _PhotoWheelState extends State<PhotoWheel> {
  DatabaseService dbService = new DatabaseService();
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme'; 
    return widget.gallLinks.length == 0 ? Loading() : Scaffold(
      body: Column(
        children:[
          SizedBox(height: 80,),
           Center(
             child: CarouselSlider.builder(
               carouselController: controller,
               options: CarouselOptions(
                 height: 360,
                 initialPage: 0,
                 enlargeCenterPage: true,
                 enlargeStrategy: CenterPageEnlargeStrategy.height,
                 ),
               itemCount: widget.gallLinks.length,
               itemBuilder: (context,index,realIndex) {
                 final urlImage = widget.gallLinks[index];

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
