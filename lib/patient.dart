class Patient {
  int? id;
  String name;
  String email;
  String password;

  Patient(
      {this.id,
      required this.name,
      required this.email,
      required this.password});

  Patient.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        email = res["email"],
        password = res['password'];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }
}
