import 'package:flutter/material.dart';
import 'userhelper.dart';
import 'patient.dart';
import 'schedulepage.dart';
import 'loginError.dart';
import 'auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key, required this.title});
  final String title;

  @override
  State<LogIn> createState() => _Login();
}

class _Login extends State<LogIn> {
  String inputEmail = '';
  String inputPassword = '';
  final _formKey = GlobalKey<FormState>();

  // late DatabaseHelper dbHelper;

  // @override
  // void initState() {
  //   super.initState();
  //   dbHelper = DatabaseHelper();
  //   dbHelper.initDB().whenComplete(() {
  //     setState(() {});
  //   });
  // }

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
                      child: TextFormField(
                        key: _formKey,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          filled: true,
                        ),
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
                      child: TextFormField(
                        key: _formKey,
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await AuthService().signInWithEmailAndPassword(
                              inputEmail, inputPassword);
                        }

                        //Check to see if credentials match database
                      },
                    ),
                  ]),
            )));
  }
}
