import 'package:fit_app/database.dart';
import 'package:fit_app/widgets/listOfUsers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';


class AddEventPage extends StatefulWidget {
  final DateTime selectedday;
  final userName;
  final userEmail;

  const AddEventPage({Key key, this.selectedday,this.userEmail,this.userName}) : super(key: key);
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  DatabaseService dbService = DatabaseService();
  TextEditingController titleC = new TextEditingController();
  TextEditingController descriptionC = new TextEditingController();
  DateTime dateTime = DateTime.now();
  TimeOfDay time;
  String theHour;
  String theDate;
  

  String getText() {
    if(time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2,'0');
      final minutes = time.minute.toString().padLeft(2,'0');
      return '$hours:$minutes';
    }
  }

  void loadInfo(){
    setState(() {
      theDate = "${widget.selectedday.year}-${widget.selectedday.month}-${widget.selectedday.day}";
    });
  }

  @override
  void initState() {
    loadInfo();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
         flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.white10,
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
                await dbService.addNewEvent(titleC.text, descriptionC.text, theDate, widget.userEmail, theHour, widget.userName);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
               child: Text("Save"),
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
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.more_time),
                      iconSize: 35,
                      color: Colors.grey,
                      onPressed: () => pickTime(context),
                    ),
                    Text(getText())
                  ],
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
  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 12, minute: 0);
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    if (selectedTime == null) return;
    setState(() {
      time = selectedTime;
      theHour = getText();
    });
  }
}