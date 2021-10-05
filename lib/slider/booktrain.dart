import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/slider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class NewTrain extends StatefulWidget {

  @override
  _NewTrainState createState() => _NewTrainState();
}

class _NewTrainState extends State<NewTrain> {
   String selectedDayC = DateTime.now().toString();
   DateTime focusedDay = DateTime.now();
   DateTime selectedDayD = DateTime.now();
   CalendarFormat format = CalendarFormat.week;
   DatabaseService dbService = new DatabaseService();
   QuerySnapshot searchSnapshot;
   String email;

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
     dbService
    .getEventsByUserEmail(email)
    .then((val) {
     setState(() {
      searchSnapshot = val;
      });
    });
  }

  Widget buildCalendar() {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
      return Container(
        height: 540,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.shade900,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // build the calendar
                        TableCalendar(
                          focusedDay: focusedDay, 
                          firstDay: DateTime.utc(2021), 
                          lastDay: DateTime.utc(2031),
                          calendarFormat: format,
                          weekendDays: [5,6],
                          selectedDayPredicate: (day) {
                              return isSameDay(selectedDayD, day);
                            },
                            onDaySelected: (_selectedDay, _focusedDay) {
                              setState(() {
                              selectedDayC = "${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day}";
                              selectedDayD = _selectedDay;
                              focusedDay = _focusedDay; // update _focusedDay here as well
                            });
                          },
                          daysOfWeekStyle: DaysOfWeekStyle ( // decorate the days
                            weekendStyle: TextStyle (
                              color: Colors.grey
                            ),
                            weekdayStyle: TextStyle (
                              color: Colors.white
                            ),
                          ),
                          headerStyle: HeaderStyle ( // decorate the header
                            titleCentered: true,
                            formatButtonVisible: false,
                            headerMargin: const EdgeInsets.only
                            (bottom: 8.0),
                            titleTextStyle: TextStyle(
                              color: text == 'DarkTheme' ?
                              Colors.deepPurple.shade200 :
                              Colors.greenAccent,
                              fontSize: 20
                            ),
                          ),
                          calendarStyle: CalendarStyle( // decorate the selected day
                            selectedDecoration: BoxDecoration(
                              color: text == 'DarkTheme' ?
                              Colors.deepPurple.shade200 :
                              Colors.greenAccent,
                              shape: BoxShape.circle
                            ),
                            todayDecoration: BoxDecoration(
                              shape: BoxShape.circle
                            )
                          ),
                        ),
                        searchSnapshot != null
                          ? ListView.builder(
                              itemCount: searchSnapshot.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return dayTask(
                                   searchSnapshot.docs[index]['hours'],
                                   searchSnapshot.docs[index]['title'],
                                   searchSnapshot.docs[index]['description'],
                                   searchSnapshot.docs[index]['dateTime'],
                                   searchSnapshot.docs[index]['id'],
                          );
                        }) : Container(
                          child: Text(
                            "No Training for today (:"
                          ),
                        )
                      ]
                    )
                  )
                )
              )
            )
          ],
        ),
      );
  }

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
      body: Container(
        child: buildCalendar(),
      )
    );
  }

  Widget dayTask(String hour,String title, String description, String savedDay, String savedEmail) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';
    if(email == savedEmail) {
      if(selectedDayC == savedDay) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "$hour",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                color: text == 'DarkTheme' ?
                  Colors.deepPurple.shade400 :
                  Colors.greenAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$title"),
                    SizedBox(height: 8),
                    Text("$description")
                  ],
                ),
              )
            )
          ],
        );
      }
    }
    return Container();
  }
}







// return searchSnapshot != null
  //       ? ListView.builder(
  //           itemCount: searchSnapshot.docs.length,
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             return theWorkouts(
  //               context: context,
  //               title: searchSnapshot.docs[index]['title'],
  //               userEmail: searchSnapshot.docs[index]['id'],
  //               hour: searchSnapshot.docs[index]['hours'],
  //               description: searchSnapshot.docs[index]['description'],
  //               date: searchSnapshot.docs[index]['dateTime'],
  //             );
  //           })
  //       : Container(
  //         child: Text(
  //           "You dont Have Trainings for this week (:"
  //         ),
  //       );