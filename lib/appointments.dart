import 'patient.dart';

class Appointment {
  int? id; //needed?
  String startTime;
  String endTime;
  String date;

  Appointment(
      {this.id,
      required this.startTime,
      required this.endTime,
      required this.date});

  Appointment.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        startTime = res['startTime'],
        endTime = res['endTime'],
        date = res['date'];

  Map<String, Object?> toMap() {
    return {'id': id, 'startTime': startTime, 'endTime': endTime, 'date': date};
  }

  String toString() {
    return 'From $startTime to $endTime on $date';
  }
}
