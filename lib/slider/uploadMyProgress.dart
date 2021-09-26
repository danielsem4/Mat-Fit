import 'package:fit_app/database.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class UploadMyProgress extends StatefulWidget {
  final DateTime selectedday;

  const UploadMyProgress({Key key, this.selectedday}) : super(key: key);
  @override
  State<UploadMyProgress> createState() => _UploadMyProgress();
}

class _UploadMyProgress extends State<UploadMyProgress> {

  DatabaseService dbService = DatabaseService();
  TextEditingController titleC = new TextEditingController();
  TextEditingController descriptionC = new TextEditingController();
  DateTime dateTime = DateTime.now();
  String email = "";
  String userName = "";
  TimeOfDay time;

  String getTrainerName() {
    return 'Check';
  }

  @override
  void initState() {
    loadInfo();
    super.initState();
  }
  
   void loadInfo() async {
    try {
      dbService.getUserName().then((value){
        setState(() {
          email = value.data()['Email'];
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

    return Scaffold(
      appBar: AppBar(
        title: Text("No Pain No Gain"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
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
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
             Navigator.pop(context);
          }
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent
              ),
              onPressed: () async {
                
              },
               child: Text(
                 "Save",
                 style: TextStyle(
                   color: Colors.white,
                 ),
                 ),
               ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(26.0),
        children: <Widget> [
          FormBuilder(
            child: Column(
              children: [
                FormBuilderTextField(
                name: "title",
                controller: this.titleC,
                decoration: InputDecoration(
                  hintText: "Add Title",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.turned_in_not),
                )),
                Divider (
                  thickness: 2.5,
                ),
                FormBuilderTextField(
                  controller: this.descriptionC,
                  name: "description",
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Detail",
                    prefixIcon: Icon(Icons.short_text),
                  ),
                ),
                Divider (
                  thickness: 2.5,
                ),
                FormBuilderDateTimePicker(
                  scrollPadding: const EdgeInsets.only(bottom: 15),
                  name: "date",
                  initialValue: widget.selectedday ?? 
                  dateTime,
                  fieldHintText: "Add Date",
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.calendar_today_sharp)
                  ),
                ),
                Divider (
                  thickness: 2.5,
                ),
              ],
            ) 
          )
        ],
      ),
    );
  }
}
