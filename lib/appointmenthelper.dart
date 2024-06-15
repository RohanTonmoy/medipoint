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
              startTime TEXT NOT NULL, 
              endTime TEXT NOT NULL,
              date TEXT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
    //temporary
    print(path);
  }

  Future<int> insertAppointment(Appointment appointment) async {
    this.retrieveAppointments().then(
      (value) {
        value.forEach(
          (element) {
            if (element.startTime == element.startTime) {}
          },
        );
      },
    );
    return db.insert('appointments', appointment.toMap());
  }

  Future<int> updatePatient(Appointment appointment) async {
    int result = await db.update(
      'appointments',
      appointment.toMap(),
      where: "id = ?",
      whereArgs: [appointment.id],
    );
    return result;
  }

  Future<List<Appointment>> retrieveAppointments() async {
    final List<Map<String, Object?>> queryResult =
        await db.query('appointments');
    return queryResult.map((e) => Appointment.fromMap(e)).toList();
  }

  Future<void> deleteAppointment(int id) async {
    await db.delete(
      'appointments',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> length() async {
    int i = 0;
    this.retrieveAppointments().then(
      (value) {
        value.forEach(
          (element) {
            if (element.startTime == element.startTime) {
              i++;
            }
          },
        );
      },
    );
    return i;
  }
}
