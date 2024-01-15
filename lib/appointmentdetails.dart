import 'package:flutter/material.dart';

class AppointmentDetails extends StatefulWidget {
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  List<String> appointments = []; 

  @override
  void initState() {
    super.initState();
    fetchAppointments(); // fetch the appointments from backend
  }

  Future<void> fetchAppointments() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appointments[index]),
            
          );
        },
      ),
    );
  }
}
