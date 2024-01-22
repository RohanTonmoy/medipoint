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
import 'appointments.dart';

String startApp = '';
String endApp = '';
late AppointmentHelper apptHelper;
List<Appointment> appointments = [];

class AppList extends StatefulWidget {
  const AppList({super.key, required this.patient, required this.dateTime});
  final Patient patient;
  final DateTime dateTime;
  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  late AppointmentHelper apptHelper;

  final List<Appointment> _apps = <Appointment>[];
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  int _currentIndex = 1;

  void initState() {
    super.initState();
    this.apptHelper = AppointmentHelper();
    this.apptHelper.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  void _addApp(Patient patient, int startTime) async {
    try {
      String date =
          "${widget.dateTime.month}/${widget.dateTime.day}/${widget.dateTime.year}";
      Appointment appointment = Appointment(
          patient: patient.id,
          startTime: startTime,
          endTime: startTime + AppointmentHelper.appointmentDuration());
      apptHelper.insertAppointment(patient.id!, startTime);
      print('\n\n ${apptHelper.retrieveAppointments()}');
      appointments.add(appointment);

      setState(() {
        _apps.add(Appointment(
            id: patient.id,
            startTime: startTime,
            endTime: startTime + AppointmentHelper.appointmentDuration()));
      });
      _textFieldController.clear();
      _textFieldController2.clear();
    } catch (e) {
      print("Error making appointment");
    }
  }

  void _handleChange(Appointment appointment) {
    setState(() {
      appointment.completed = !appointment.completed;
    });
  }

  void _deleteApp(Appointment appointment) {
    setState(() {
      _apps.removeWhere((element) => element.name == appointment.name);
      appointments
          .removeWhere((element) => element.startTime == appointment.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Manager'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _apps.map((Appointment appointment) {
          return Item(
              app: appointment,
              onAppChanged: _handleChange,
              removeApp: _deleteApp);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add an Appointment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue,
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
                try {
                  _addApp(_textFieldController.text, _textFieldController.text,
                      _textFieldController2.text);
                } catch (e) {
                  Navigator.of(context).pop();
                }
                print(apptHelper.retrieveAppointments());
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Item extends StatelessWidget {
  Item({required this.app, required this.onAppChanged, required this.removeApp})
      : super(key: ObjectKey(app));

  final Appointment app;
  final void Function(Appointment app) onAppChanged;
  final void Function(Appointment app) removeApp;

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
            //delete appointment from database
          },
        ),
      ]),
    );
  }
}
