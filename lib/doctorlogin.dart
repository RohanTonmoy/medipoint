import 'package:flutter/material.dart';
import 'package:medipoint_new/doctorpersonalinfo.dart';
import 'userhelper.dart';
import 'patient.dart';
import 'schedulepage.dart';
import 'loginError.dart';

class DoctorLogIn extends StatefulWidget {
  const DoctorLogIn({super.key, required this.title});
  final String title;

  @override
  State<DoctorLogIn> createState() => _DoctorLogin();
}

class _DoctorLogin extends State<DoctorLogIn> {
  String inputEmail = '';
  String inputPassword = '';
  bool isDoctor = false;

  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    dbHelper.initDB().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            'Log In',
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/hospitalbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    const Text(
                      "Enter your email:",
                      style: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            filled: true),
                        onChanged: (value) => inputEmail = value,
                      ),
                    ),
                    SizedBox(height: 40),
                    const Text(
                      'Enter your password:',
                      style: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            filled: true),
                        onChanged: (value) => inputPassword = value,
                      ),
                    ),
                    SizedBox(height: 30),

                    ElevatedButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'TimesNewRoman',
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        print(dbHelper.loginPatient('email', 'password'));
                        int response =
                            dbHelper.loginPatient(inputEmail, inputPassword);
                        Patient patient =
                            dbHelper.getPatient(inputEmail, inputPassword);
                          if (response == -1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DoctorPersonalInfo(patient: patient)),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LogInError(title: '')),
                          );
                        }
                      

                      

                        //Check to see if credentials match database
                      },
                    ),
                  ]),
            )));
  }
}

