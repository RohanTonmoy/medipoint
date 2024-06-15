import 'package:flutter/material.dart';
import 'userhelper.dart';
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
  bool isDoctor = false;
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
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Log In'),
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
                    Text("ERROR - Account Not Found, Please try again!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
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
                                    SchedulePage(patient: patient)),
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
