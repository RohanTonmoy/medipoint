import 'patient.dart';

class Schedule {
  int? id; //needed?
  bool isAvailable = true;
  Patient patient;
  int startTime;
  int endTime;

  Schedule(
      {this.id,
      required this.isAvailable,
      required this.patient,
      required this.startTime,
      required this.endTime});

  Schedule.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        isAvailable = res["isAvailable"],
        patient = res["patient"],
        startTime = res['startTime'],
        endTime = res['endTime'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'isAvailable': isAvailable,
      'patient': patient,
      'startTime': startTime,
      'endTime': endTime
    };
  }
}
