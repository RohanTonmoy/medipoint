import 'patient.dart';

class Appointment {
  int? id; //needed?
  int patient;
  int startTime;
  int endTime;

  Appointment(
      {this.id,
      required this.patient,
      required this.startTime,
      required this.endTime});

  Appointment.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        patient = res["patient"],
        startTime = res['startTime'],
        endTime = res['endTime'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'patient': patient,
      'startTime': startTime,
      'endTime': endTime
    };
  }
}
