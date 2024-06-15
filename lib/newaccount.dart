import 'package:flutter/material.dart';
import 'userhelper.dart';
import 'patient.dart';
import 'schedulepage.dart';
import 'newaccounterror.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key, required this.title});
  final String title;

  @override
  State<NewAccount> createState() => _NewAccount();
}

class _NewAccount extends State<NewAccount> {
  late DatabaseHelper dbHelper;
  void initState() {
    super.initState();
    this.dbHelper = DatabaseHelper();
    this.dbHelper.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  bool isDoctor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Create New Account'),
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
                    Text("Enter your name:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Name',
                            filled: true),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text("Enter your email:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              filled: true),
                        )),
                    SizedBox(height: 40),
                    Text('Enter your password:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: TextField(
                        onChanged: (value) => userPassword = value,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Password',
                            filled: true,
                            icon: const Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: const Icon(Icons.lock),
                            )),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: DoctorDropdown(
                        onValueChange: (value) {
                          if (value == 'Doctor') {
                            setState(() => isDoctor = true);
                          } else {
                            isDoctor = false;
                          }
                        },
                      ),
                    ),

                    ElevatedButton(
                      child: Text('Submit',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {
                        if (dbHelper.loginPatient(userEmail, userPassword) !=
                            -1) {
                          Patient newPatient = Patient(
                              name: userName,
                              email: userEmail,
                              password: userPassword);
                          dbHelper.insertPatient(newPatient);

                          dbHelper.retrievePatients().then(
                                (value) =>
                                    value.forEach((e) => print(e.toMap())),
                              );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SchedulePage(patient: newPatient),
                              ));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NewAccountError(title: '')),
                          );
                        }

                        //check to see if credentials match database
                      },
                    ),
                  ]),
            )));
  }
}

const List<String> list = <String>['Patient', 'Doctor'];

class DoctorDropdown extends StatefulWidget {
  const DoctorDropdown({super.key, required this.onValueChange});
  final ValueChanged<String?> onValueChange;
  @override
  State<DoctorDropdown> createState() =>
      _DoctorDropdownState(onValueChange: onValueChange);
}

class _DoctorDropdownState extends State<DoctorDropdown> {
  String dropdownValue = list.first;
  _DoctorDropdownState({required this.onValueChange});
  final ValueChanged<String?> onValueChange;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          onValueChange(value);
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
