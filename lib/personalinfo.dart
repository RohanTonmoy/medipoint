import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key, required this.title});
  final String title;

  @override
  State<PersonalInfo> createState() => _PersonalInfo();
}

class _PersonalInfo extends State<PersonalInfo> {
  String fname = '';
  String lname = '';
  int month = 1;
  int day = 1;
  int year = 2000;
  String desc = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          SizedBox(height: 40),
          Text('First Name:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Color.fromARGB(255, 255, 255, 255),
              onChanged: (value) {
                fname = value;
              },
              controller: TextEditingController()),
          SizedBox(height: 10),
          Text('Last Name:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Color.fromARGB(255, 255, 255, 255),
              onChanged: (value) {
                lname = value;
              },
              controller: TextEditingController()),
          SizedBox(height: 30),
          Text('Enter your birthdate below:'),
          Text('Month:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Color.fromARGB(255, 255, 255, 255),
              onChanged: (value) {
                month = int.parse(value);
              },
              controller: TextEditingController()),
          Text('Day:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Color.fromARGB(255, 255, 255, 255),
              onChanged: (value) {
                day = int.parse(value);
              },
              controller: TextEditingController()),
          Text('Year of Birth:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Color.fromARGB(255, 255, 255, 255),
              onChanged: (value) {
                year = int.parse(value);
              },
              controller: TextEditingController()),

        ])));
  }
}
