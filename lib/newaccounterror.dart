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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
              const Text("Enter your name:",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  onChanged: (value) => userName = value,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Email input
              const Text("Enter your email:",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  onChanged: (value) => userEmail = value,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Password input
              const Text('Enter your password:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  onChanged: (value) => userPassword = value,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Password',
                    icon: Icon(Icons.lock),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Submit button
              ElevatedButton(
                child: const Text('Submit',
                  style: TextStyle(
                    fontSize: 20,
                  )),
                onPressed: () {
                  if (dbHelper.loginPatient(userEmail, userPassword) != -1) {
                    Patient newPatient = Patient(
                        name: userName,
                        email: userEmail,
                        password: userPassword);
                    dbHelper.insertPatient(newPatient);
                    dbHelper.retrievePatients().then(
                          (value) => value.forEach((e) => print(e.toMap())),
                        );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SchedulePage(patient: newPatient),
                        ));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const NewAccountError(title: '')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
