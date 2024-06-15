import 'package:flutter/material.dart';
import 'package:medipoint_new/appointments.dart';
import 'appointmentdetails.dart';
import 'schedulepage.dart';
import 'patient.dart';
import 'personalinfo.dart';
import 'applist.dart';
import 'appointmenthelper.dart';

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails({super.key, required this.patient});

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
  final Patient patient;
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  AppointmentHelper dbHelper = AppointmentHelper();
  //Future<List<Appointment>> l = dbHelper.retrieveAppointments();

  int _currentIndex = 1;
  int length = appointments.length;
  List<Appointment> apps = appointments;

  // void initState() {
  //   super.initState();
  //   fetchAppointments();
  // }

  // void initState1() async {
  //   length = await dbHelper.length();
  //   apps = await dbHelper.retrieveAppointments();
  // }

  // Future<List<Appointment>> fetchAppointments() async {
  //   // Implement fetching logic
  //   return dbHelper.retrieveAppointments();
  // }

  @override
  Widget build(BuildContext context) {
    //initState1();
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                Appointment appointment = apps[index];
                return Column(

                  children: <Widget>[Padding(
                  padding: 
                          EdgeInsets.only(bottom: 20.0),
                          // EdgeInsets.symmetric(
                          // horizontal: 8, vertical: 20)
                          // ,
                          
                  child: Text(appointment.toString(), textAlign: TextAlign.center,
                  style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  
                  
            ),
            Divider(
                    color: Color.fromARGB(255, 139, 226, 229),
                    thickness: 2.5,
                    endIndent: 0.0,
                  ),
                  ],);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          _navigateToPage(value, context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Personal Info",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: "Appointment Details",
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PersonalInfo(patient: widget.patient)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SchedulePage(patient: widget.patient)),
        );
        break;
      // Adjust or remove case 2 as needed.
    }
  }
}
