import 'package:fit_app/admin/addEvent.dart';
import 'package:fit_app/widgets/listOfUsers.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AdminCalendar extends StatefulWidget {

  @override
  _AdminCalendarState createState() => _AdminCalendarState();
}

class _AdminCalendarState extends State<AdminCalendar> {
   DateTime selectedDay = DateTime.now();
   DateTime focusedDay = DateTime.now();
   CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
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
      ),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            SizedBox(height: 10),
            TableCalendar(
              focusedDay: focusedDay, 
              firstDay: DateTime.utc(2021), 
              lastDay: DateTime.utc(2031),
              calendarFormat: format,
              weekendDays: [6],
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
                onDaySelected: (_selectedDay, _focusedDay) {
                  setState(() {
                  selectedDay = _selectedDay;
                  focusedDay = _focusedDay; // update _focusedDay here as well
                });
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                headerMargin: const EdgeInsets.only
                (bottom: 8.0),
                )
              )
          ],
        ), 
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.grey.shade600,
        splashColor: Colors.grey.shade200,
        onPressed: () {
           Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => ListOfUsers(selectedday: selectedDay,)));
        },
      ), 
    );
  }
}