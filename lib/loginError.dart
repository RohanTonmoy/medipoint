import 'package:flutter/material.dart';
import 'databasehelper.dart';
import 'patient.dart';
import 'schedulepage.dart';

class LogInError extends StatefulWidget {
  const LogInError({super.key, required this.title});
  final String title;

  @override
  State<LogInError> createState() => _LoginError();
}

class _LoginError extends State<LogInError> {
  String inputEmail = '';
  String inputPassword = '';

  Future<void> checkCredentials() async {
    /*here check in the backend if email and password matches

      if (response == success){
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SchedulePage(email: email)),

      else{
        return)("Invalid Password. Try Again")
      }
    );
        
      }
  */
  }

  late DatabaseHelper dbHelper;
  void initState() {
    super.initState();
    this.dbHelper = DatabaseHelper();
    this.dbHelper.initDB().whenComplete(() async {
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
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text("ERROR - Account Not Found, Please try again!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 40),
                Text("Enter your email:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    onChanged: (value) => inputEmail = value,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text('Enter your password:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  child: Text('Submit',
                      style: TextStyle(
                        fontSize: 20,
                      )),
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
                                SchedulePage(patient: patient)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInError(title: '')),
                      );
                    }

                    //Check to see if credentials match database
                  },
                ),
              ]),
        ));
  }
}
