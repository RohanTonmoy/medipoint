import 'package:flutter/material.dart';
import 'package:medipoint_new/appointmenthelper.dart';
import 'newaccount.dart';
import 'login.dart';
import 'schedulepage.dart';
import 'userhelper.dart';
import 'patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medipoint App',
      home: HomePage(),
    );
  }

  Future<void> createNewAccount(String email, String password) async {
    Patient newPatient =
        Patient(name: 'sample patient', email: 'email', password: 'password');
    dbHelper.insertPatient(newPatient).then(
          (value) => print(value),
        );
  }

  Future<void> login(String email, String password) async {}
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Medipoint'),
          backgroundColor: Colors.lightBlueAccent,
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
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogIn(title: '')));

                      // make a script here that goes onto the login part
                    },
                    child: Text('Log In'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // make a script there that goes to the crete accoutn part
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const NewAccount(title: 'Make New Account')),
                    );
                  },
                  child: Text('Create New Account'),
                ),
              ],
            ),
          ),
        ));
  }
}
