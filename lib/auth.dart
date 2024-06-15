import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class User {
  final bool? isDoctor;

  User({
    this.isDoctor,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      isDoctor: data?['isDoctor'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (isDoctor != null) "isDoctor": isDoctor,
    };
  }
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<bool> isUserDoctor(String uid) async {
    final ref = await db.collection("users").doc(uid).withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, _) => user.toFirestore(),
        );
    final docSnap = await ref.get();
    //print(docSnap.get('isDoctor'));
    return docSnap.get('isDoctor');
  }

  Future<dynamic> getUserInfo(String uid) async {
    await db.collection("users").doc(uid).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> setUserInfo(String uid, bool isDoctor) async {
    final appInfo = <String, bool>{
      "isDoctor": isDoctor,
    };

    db
        .collection("users")
        .doc(uid)
        .set(appInfo)
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}

class Appointment {
  DateTime? startTime;
  String? patientId;
  String? doctorId;
  String documentId;

  Appointment(
      {this.startTime,
      this.patientId,
      this.doctorId,
      required this.documentId});

  factory Appointment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Appointment(
        startTime: data?['startTime'].toDate(),
        patientId: data?['patientId'],
        doctorId: data?['doctorId'],
        documentId: snapshot.id);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (startTime != null) "startTime": startTime,
      if (patientId != null) "patientId": patientId,
      if (doctorId != null) "doctorId": doctorId,
    };
  }

  String toString() {
    return 'Appointment at ${startTime} with doctor ${doctorId}';
  }
}

class appointmentService {
  final db = FirebaseFirestore.instance;

  //doctors side where they can view all appointments, users side where they can view only theirs?

  Future<void> createAppointment(
      DateTime startTime, String patientUid, String doctorUid) async {
    final appointmentInfo = <String, dynamic>{
      "doctorId": doctorUid,
      "patientId": patientUid,
      "startTime": startTime,
    };

    db
        .collection("appointments")
        .doc()
        .set(appointmentInfo)
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<dynamic> getAppointmentInfo(String documentId) async {
    //users appointments
    await db.collection("appointments").doc(documentId).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<dynamic> getAppointments(String patientUid) async {
    //users appointments

    final ref = await db
        .collection("appointments")
        .where('patientId', isEqualTo: patientUid)
        .withConverter(
          fromFirestore: Appointment.fromFirestore,
          toFirestore: (Appointment appointment, _) =>
              appointment.toFirestore(),
        );
    final collectionSnap = await ref.get();
    List<Appointment> listOfAppointments = collectionSnap.docs.map(
      (e) {
        return e
            .data(); //returns list of Appointments, use forEach to reference each one
      },
    ).toList();

    return listOfAppointments;
  }

  Future<void> removeAppointment(String documentId) async {
    db
        .collection("appointments")
        .doc(documentId)
        .delete()
        .onError((e, _) => print("Error writing document: $e"));
  }
}