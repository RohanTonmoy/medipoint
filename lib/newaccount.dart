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
                          filled: true
                      ),
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
                          filled: true
                      ),
                      )
                    ),
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
                    ElevatedButton(
                      child: Text('Submit',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {
                        if (dbHelper.loginPatient(userEmail, userPassword) ==
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
