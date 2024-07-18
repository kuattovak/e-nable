import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _progressPercentage = 0;

  // Calendar style and builders definitions

  CalendarStyle calendarStyle = CalendarStyle(
    isTodayHighlighted: false,
    weekendTextStyle: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    outsideTextStyle: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(65, 0, 0, 0),
    ),
    holidayTextStyle: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    defaultTextStyle: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    selectedDecoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Color(0xff1F59DA),
      borderRadius: BorderRadius.circular(8.0),
    ),
    selectedTextStyle: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  CalendarBuilders calendarBuilders = CalendarBuilders(
    selectedBuilder: (context, date, _) {
      return Container(
        margin: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xff1F59DA),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          '${date.day}',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Progress',
          style: GoogleFonts.montserrat(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xff1F59DA)),
        ),
      ),
      backgroundColor: Color(0xffF8F8F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 320,
              height: 404,
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _fetchProgress();
                },
                daysOfWeekVisible: false,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                calendarStyle: calendarStyle,
                calendarBuilders: calendarBuilders,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              child: Text(
                'Your progress on this day made up:',
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w500),
              ),
              width: 191,
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 316,
                  height: 29,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff1F59DA),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    value: _progressPercentage / 100,
                    minHeight: 29,
                  ),
                ),
                Positioned.fill(
                  right: 270,
                  child: Center(
                    child: Text(
                      '$_progressPercentage%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _fetchProgress() async {
    if (_selectedDay != null) {
      String docId =
          'day-${_selectedDay!.day}-month-${_selectedDay!.month}-year-${_selectedDay!.year}';
      DocumentReference progresses =
          FirebaseFirestore.instance.collection('progresses').doc(docId);
      print(docId);
      DocumentSnapshot snapshot = await progresses.get();
      if (snapshot.exists) {
        setState(() {
          _progressPercentage = snapshot['percentage'];
        });
      } else {
        setState(() {
          _progressPercentage = 0;
        });
      }
    }
  }
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
