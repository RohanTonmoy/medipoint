import 'patient.dart';

class Appointment {
  int? id; //needed?
  int? patient;
  DateTime startTime;
  DateTime endTime;

  Appointment({
    this.id,
    this.patient,
    required this.startTime,
    required this.endTime,
  });

  Appointment.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        startTime = res['startTime'],
        endTime = res['endTime'],
        patient = res['patient'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'patient': patient,
    };
  }

  // String toString() {
  //   return 'From $startTime to $endTime on $patient';
  // }

  String toString() {
    DateTime startDate = startTime;
    DateTime endDate = endTime;
    return 'From ${startDate.hour}:${startDate.minute} to ${endDate.hour}:${endDate.minute} on ${startDate.month}/${startDate.day}/${startDate.year}';
  }

  DateTime intToDateTime(int intTime) {
    return DateTime.fromMillisecondsSinceEpoch(intTime);
  }
}
