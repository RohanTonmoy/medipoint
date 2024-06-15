import 'package:flutter/material.dart';
import 'appointmentdetails.dart';
import 'schedulepage.dart';
import 'patient.dart';
import 'userhelper.dart';
import 'applist.dart';

class DoctorPersonalInfo extends StatefulWidget {
  DoctorPersonalInfo({super.key, required this.patient});
  final Patient patient;

  @override
  State<DoctorPersonalInfo> createState() => _DoctorPersonalInfo();
}

class _DoctorPersonalInfo extends State<DoctorPersonalInfo> {
  String? fname;
  int _currentIndex = 1;
  String? lname;
  String? month;
  String? day;
  String? year;
  String? desc;
  void innitState1() {
    fname = widget.patient.first;
    lname = widget.patient.last;
    month = widget.patient.m;
    day = widget.patient.d;
    year = widget.patient.y;
    desc = widget.patient.desc;
  }

  void changem(String m) {
    widget.patient.changem(m);
    info[2] = m;
  }

  void changed(String d) {
    widget.patient.changed(d);
    info[3] = d;
  }

  void changey(String y) {
    widget.patient.changey(y);
    info[4] = y;
  }

  void changef(String f) {
    widget.patient.changef(f);
    info[0] = f;
  }

  void changel(String l) {
    widget.patient.changel(l);
    info[1] = l;
  }

  void changedesc(String d) {
    widget.patient.changedesc(d);
    info[5] = d;
  }

  // @override
  // void innitState() {
  //   innitState1();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Doctor Personal Information'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text('First Name:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: info[0],
                ),
                onChanged: (text) {
                  changef(text);
                },
              ),
            ),
            Text('Last Name:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextField(
                onChanged: (value) => changel(value),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: info[1],
                ),
              ),
            ),
            Text('Specialty/Field',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: info[2],
                ),
                onChanged: (value) {
                  changem(value);
                },
              ),
            ),
            Text('Name of Clinic/Hospital',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: info[3],
                ),
                onChanged: (value) {
                  changed(value);
                },
              ),
            ),
            Text('Address of Clinic/Hospital',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: info[4],
                ),
                onChanged: (value) {
                  changey(value);
                },
              ),
            ),
            Text(
              'Extra Details:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: info[5],
                ),
                onChanged: (value) {
                  changedesc(value);
                },
              ),
            ),
          ])),
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
