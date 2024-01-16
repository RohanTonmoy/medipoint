import 'package:flutter/material.dart';
import 'appointmentdetails.dart';
import 'schedulepage.dart';
import 'patient.dart';
import 'userhelper.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({super.key, required this.patient});
  final Patient patient;

  @override
  State<PersonalInfo> createState() => _PersonalInfo();
}

class _PersonalInfo extends State<PersonalInfo> {
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
  }

  void changed(String d) {
    widget.patient.changed(d);
  }

  void changey(String y) {
    widget.patient.changey(y);
  }

  void changef(String f) {
    widget.patient.changef(f);
  }

  void changel(String l) {
    widget.patient.changel(l);
  }

  void changedesc(String d) {
    widget.patient.changedesc(d);
  }

  @override
  void innitState() {
    innitState1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text('First Name:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: fname,
                ),
                onChanged: (text) {
                  changef(text);
                  innitState1();
                  changef(text);
                },
              ),
            ),
            Text('Last Name:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                onChanged: (value) => changel(value),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: lname,
                ),
              ),
            ),
            Text('Month of Birth:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: month,
                ),
                onChanged: (value) {
                  innitState1();
                  changem(value);
                },
              ),
            ),
            Text('Day of Birth:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: day,
                ),
                onChanged: (value) {
                  innitState1();
                  changed(value);
                },
              ),
            ),
            Text('Year of Birth:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: year,
                ),
                onChanged: (value) {
                  innitState1();
                  changey(value);
                },
              ),
            ),
            Text(
              'Enter anything significant about your medical health:',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: desc,
                ),
                onChanged: (value) {
                  innitState1();
                  changedesc(value);
                  innitState1();
                },
              ),
            ),
            Text(
              '(Enter first name and press on Personal Info to see old info)',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ])),
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
        /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalInfo(patient: widget.patient)));*/
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
