import 'dart:async';
import 'package:path/path.dart';
import 'main.dart';
import 'package:sqflite/sqflite.dart';
import 'appointments.dart';

class AppointmentHelper {
  static final AppointmentHelper _databaseHelper = AppointmentHelper._();

  AppointmentHelper._();

  late Database db;

  factory AppointmentHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'medipoint-main.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE appointments (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              patient INT NOT NULL, 
              startTime INT NOT NULL,
              endTime INT NOT NULL,
              completed INT NOT NULL,
              FOREIGN KEY(patient) REFERENCES patients(id)
            )
          """,
        );
      },
      version: 1,
    );
    //temporary
    print(path);
  }

  int startTime(DateTime date) {
    DateTime newtime = DateTime(date.year, date.month, date.day, 9);
    return newtime.millisecondsSinceEpoch;
  }

  int endTime(DateTime date) {
    DateTime newTime = DateTime(date.year, date.month, date.day, 17);
    return newTime.millisecondsSinceEpoch;
  }

  static int appointmentDuration() {
    return new Duration(minutes: 30).inMilliseconds;
  }

  List<Appointment> getAvailableAppointments(DateTime date) {
    List<Appointment> availableList = [];
    int start = startTime(date);
    int end = endTime(date);
    retrieveAppointments().then(
      (listOfAppointments) {
        for (int x = start; x < end; x += appointmentDuration()) {
          bool apptAvailable = true;
          for (Appointment y in listOfAppointments) {
            if (x == y.startTime) {
              apptAvailable = false;
            }
          }
          if (apptAvailable) {
            availableList.add(Appointment(
              patient: null,
              startTime: DateTime.fromMillisecondsSinceEpoch(x),
              endTime: DateTime.fromMillisecondsSinceEpoch(
                  x + appointmentDuration()),
            ));
          }
        }
      },
    );

    return availableList;
  }

  Future<int> insertAppointment(int patient, int startTime) async {
    Appointment newAppointment = Appointment(
        patient: patient,
        startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
        endTime: DateTime.fromMillisecondsSinceEpoch(
            startTime + appointmentDuration() - 1));
    return db.insert('appointments', newAppointment.toMap());
  }

  Future<List<Appointment>> retrieveAppointments() async {
    final List<Map<String, Object?>> queryResult =
        await db.query('appointments');
    return queryResult
        .map((e) => Appointment.fromMap(e))
        .toList(); //change to make sure that only appointments after datetime.now are shown
  }
}
