import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class NewTrain extends StatefulWidget {

  @override
  _NewTrainState createState() => _NewTrainState();
}

class _NewTrainState extends State<NewTrain> {
   DateTime selectedDay = DateTime.now();
   DateTime focusedDay = DateTime.now();
   CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
     final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Training"),
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
      body: Column(
        children: [
          SizedBox(height: 5),
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
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: text == 'DarkTheme' ?
                Colors.white : Colors.black,
                ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: text == 'DarkTheme' ?
                Colors.white : Colors.black,
                ),
                
            ),
          ),
        ],
      ), 
    );
  }
}