import 'package:flutter/material.dart';
import 'package:medipoint_new/applist.dart';
import 'package:medipoint_new/appointmentdetails.dart';
import 'package:medipoint_new/personalinfo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'patient.dart';
import 'package:medipoint_new/login.dart';

class SchedulePage extends StatefulWidget {
  final Patient patient;

  SchedulePage({Key? key, required this.patient}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime? _selectedDay;
  int _currentIndex = 1;

  List<String> _scheduleDetails = [];

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  /*List<String> _getEvents(DateTime day) {
    //get events for day
    return events[day] ?? [];
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Your Calendar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        TableCalendar(
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
          ),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              }
              );
              // Handle day selection logic
              
              Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AppList(patient: widget.patient, dateTime: selectedDay)));
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _scheduleDetails.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_scheduleDetails[index]),
              );
            },
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          _navigateToPage(value, context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Personal Info",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: "Appointment Details",
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalInfo(patient: widget.patient)));
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SchedulePage(patient: widget.patient)),
        );
        break;
      case 2:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AppointmentDetails(patient: widget.patient)));
        break;
    }
  }
}
