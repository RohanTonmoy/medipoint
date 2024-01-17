import 'package:flutter/material.dart';
import 'userhelper.dart'; // Ensure this file exists and contains DatabaseHelper
import 'patient.dart'; // Ensure this file exists and contains Patient class
import 'schedulepage.dart'; // Ensure this file exists

class NewAccountError extends StatefulWidget {
  const NewAccountError({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NewAccountError> createState() => _NewAccountErrorState();
}

class _NewAccountErrorState extends State<NewAccountError> {
  late DatabaseHelper dbHelper;
  String userName = '';
  String userEmail = '';
  String userPassword = '';

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
        title: Text('Create New Account'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/hospitalbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              const Text("ERROR - Email already in use! Please try again.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
              const SizedBox(height: 40),
              // Name input
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
                        // Patient newPatient = Patient(
                        //     name: 'sample patient',
                        //     email: email,
                        //     password: password);
                        // dbHelper.retrievePatients().then(
                        //       (value) => value.forEach((e) => print(e.toMap())),
                        //     );
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
            ],
          ),
        ),
      ),
    );
  }
}
