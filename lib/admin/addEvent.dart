import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';


class AddEventPage extends StatefulWidget {
  final DateTime selectedday;

  const AddEventPage({Key key, this.selectedday}) : super(key: key);
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormBuilderState>();
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

              },
               child: Text("Save"),
               ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget> [
          FormBuilder(
            child: Column(
              children: [
                FormBuilderTextField(name: "title",
                decoration: InputDecoration(
                  hintText: "Add Title",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.turned_in_not),
                )),
                Divider(
                  thickness: 2.5,
                ),
                FormBuilderTextField(
                  name: "description",
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Detail",
                    prefixIcon: Icon(Icons.short_text),
                  ),
                ),
                Divider(
                  thickness: 2.5,
                ),
                FormBuilderDateTimePicker(
                  scrollPadding: const EdgeInsets.only(bottom: 15),
                  name: "date",
                  initialValue: widget.selectedday ?? 
                  DateTime.now(),
                  fieldHintText: "Add Date",
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.calendar_today_sharp)
                  ),
                )
              ],
            ) 
          )
        ],
      ),
    );
  }
}