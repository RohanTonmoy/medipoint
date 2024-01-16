import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'patient.dart';
import 'appointments.dart';

class AppointmentHelper {
  static final AppointmentHelper _databaseHelper = AppointmentHelper._();

  AppointmentHelper._();

  Database? db;

  bool initialized = false;

  factory AppointmentHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    if (!initialized) {
      String path = await getDatabasesPath();
      db = await openDatabase(
        join(path, 'medipointschedule.db'),
        onCreate: (database, version) async {
          await database.execute(
           """
          CREATE TABLE patients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT
          )
          """,
          );
          await database.execute(
            """
            CREATE TABLE appointments (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            patient INTEGER,
            startTime INT NOT NULL,
            endTime INT NOT NULL,
            FOREIGN KEY (patient) REFERENCES patients(id)
          )
          """,
          );
        },
        version: 1,
      );
      initialized = true;
      print("Database initialized at $path");
    }
  }

  int startTime(DateTime date) {
    DateTime newTime = DateTime(date.year, date.month, date.day, 9);
    return newTime.millisecondsSinceEpoch;
  }

  int endTime(DateTime date) {
    DateTime newTime = DateTime(date.year, date.month, date.day, 17);
    return newTime.millisecondsSinceEpoch;
  }

  int appointmentDuration() {
    return Duration(minutes: 30).inMilliseconds;
  }

  Future<int> insertAppointment(int patient, int startTime) async {
    if (db == null) {
      throw Exception('Database not initialized');
    }
    Appointment newAppointment = Appointment(
      patient: patient,
      startTime: startTime,
      endTime: startTime + appointmentDuration() - 1,
    );
    return db!.insert('appointments', newAppointment.toMap());
  }

  Future<int> updatePatient(Patient patient) async {
    if (db == null) {
      throw Exception('Database not initialized');
    }
    return db!.update(
      'patients',
      patient.toMap(),
      where: "id = ?",
      whereArgs: [patient.id],
    );
  }

  Future<List<Patient>> retrieveAppointments() async {
    if (db == null) {
      throw Exception('Database not initialized');
    }
    final List<Map<String, Object?>> queryResult = await db!.query('patients');
    return queryResult.map((e) => Patient.fromMap(e)).toList();
  }

  Future<void> deletePatient(int id) async {
    if (db == null) {
      throw Exception('Database not initialized');
    }
    await db!.delete(
      'patients',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<Patient> getPatient(String email, String password) async {
    if (db == null) {
      throw Exception('Database not initialized');
    }
    final List<Map<String, Object?>> queryResult = await db!.query(
      'patients',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (queryResult.isNotEmpty) {
      return Patient.fromMap(queryResult.first);
    } else {
      throw Exception('No patient found with provided credentials');
    }
  }
}
