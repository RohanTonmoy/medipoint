import 'dart:async';
import 'package:path/path.dart';
import 'main.dart';
import 'package:sqflite/sqflite.dart';
import 'patient.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'medipoint.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE patients (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL, 
              email TEXT NOT NULL,
              password TEXT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
  }

  Future<int> insertPatient(Patient patient) async {
   /* this.retrievePatients().then(
      (value) {
        value.forEach(
          (element) {
            if (element.email == patient.email) {
              return await 0;
            }
          },
        );
      },
    );
    */
    int result = await db.insert('patients', patient.toMap());
    return result;
  }

  Future<int> updatePatient(Patient patient) async {
    int result = await db.update(
      'patients',
      patient.toMap(),
      where: "id = ?",
      whereArgs: [patient.id],
    );
    return result;
  }

  Future<List<Patient>> retrievePatients() async {
    final List<Map<String, Object?>> queryResult = await db.query('patients');
    return queryResult.map((e) => Patient.fromMap(e)).toList();
  }



  Future<void> deletePatient(int id) async {
    await db.delete(
      'patients',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Patient getPatient(String email, String password){
    Patient patient = new Patient(name: '', email: '', password:'');
    this.retrievePatients().then(
      (value) {
        value.forEach(
          (element) {
            if (element.email == email && element.password == password) {
              patient = element;
            }
          },
        );
      },
    );
    return patient;
  }

  
  int loginPatient(String email, String password) {
    int a = -1;
    this.retrievePatients().then(
      (value) {
        value.forEach(
          (element) {
            if (element.email == email && element.password == password) {
              a = element.id!;
            }
          },
        );
      },
    );
    return a;
  }
}
