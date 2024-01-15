import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'patient.dart';

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

  List<String> _scheduleDetails = [];

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Schedule'),
      ),
      body: Column(children: [
        TableCalendar(
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
              });

              /*
                    Future<void> fetchSchedule(DateTime date) async{
                      final response = await x.get(here we get the individual patient info in the sql database)
                      );

                      if(reponse == true){
                        print(schedule)

                      else{
                        handle the null response here
                      }
                    }
                  }

                */
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
                }))
      ]),
    );
  }
}
