import 'dart:async';
import 'package:flutter/material.dart';
import 'patient.dart';
import 'package:flutter/material.dart';
import 'package:medipoint_new/applist.dart';
import 'package:medipoint_new/appointmentdetails.dart';
import 'package:medipoint_new/personalinfo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'patient.dart';
import 'package:medipoint_new/login.dart';
import 'schedulepage.dart';
import 'appointmenthelper.dart';

String startApp = '';
String endApp = '';
//late AppointmentHelper appHelper;
int timeToInt(String time, DateTime dateTime) {
  String firstHalf = time.substring(0, 2);
  String secondHalf = time.substring(3);
  DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day,
      int.parse(firstHalf), int.parse(secondHalf));
  return date.millisecondsSinceEpoch;
}

class AppList extends StatefulWidget {
  const AppList({super.key, required this.patient, required this.dateTime});

  final Patient patient;
  final DateTime dateTime;
  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  late AppointmentHelper dbHelper = AppointmentHelper();

  final List<App> _apps = <App>[];
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  int _currentIndex = 1;
  AppointmentHelper appHelper = AppointmentHelper();

  void _addApp(String name, String start) async {
    try {
      int startEpoch = timeToInt(startApp, widget.dateTime);
      print("Start Epoch: $startEpoch");

      await appHelper.insertAppointment(widget.patient.id!, startEpoch);

      setState(() {
        _apps.add(App(name: name, completed: false));
      });

      _textFieldController.clear();
      _textFieldController2.clear();
    } catch (e) {
      print("Error making appointment");
    }
  }

/*
    setState(() {
       int start = timeToInt(startApp, widget.dateTime);
       appHelper.insertAppointment(widget.patient.id!, start); //error with widget.patient.id
       
      _apps.add(App(name: name, completed: false));
    });
    _textFieldController.clear();
    _textFieldController2.clear();
  }
*/

  void _handleChange(App appointment) {
    setState(() {
      appointment.completed = !appointment.completed;
    });
  }

  void _deleteApp(App appointment) {
    setState(() {
      _apps.removeWhere((element) => element.name == appointment.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Manager'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _apps.map((App appointment) {
          return Item(
              app: appointment,
              onAppChanged: _handleChange,
              removeApp: _deleteApp);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
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

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add an appointment'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Enter the start time:'),
              TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: 'HH:MM'),
                autofocus: true,
                onChanged: (value) => startApp = value,
              ),
              Text('Enter the end time:'),
              TextField(
                controller: _textFieldController2,
                decoration: const InputDecoration(hintText: 'HH:MM'),
                autofocus: true,
                onChanged: (value) => endApp = value,
              ),
            ],
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addApp(_textFieldController.text, _textFieldController2.text);
                print(dbHelper.retrieveAppointments());
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class App {
  App({required this.name, required this.completed});
  String name;
  bool completed;
}

class Item extends StatelessWidget {
  Item({required this.app, required this.onAppChanged, required this.removeApp})
      : super(key: ObjectKey(app));

  final App app;
  final void Function(App app) onAppChanged;
  final void Function(App app) removeApp;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onAppChanged(app);
      },
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: app.completed,
        onChanged: (value) {
          onAppChanged(app);
        },
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(app.name, style: _getTextStyle(app.completed)),
        ),
        IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            removeApp(app);
          },
        ),
      ]),
    );
  }
}
