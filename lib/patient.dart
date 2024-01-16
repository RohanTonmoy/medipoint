class Patient {
  int? id;
  String name;
  String email;
  String password;
  String first = 'First';
  String last = 'Last';
  String m = '01';
  String d = '01';
  String y = '2000';
  String desc = 'N/A';

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

  void changef(String first) {
    this.first = first;
  }

  void changel(String last) {
    this.last = last;
  }

  void changem(String month) {
    m = month;
  }

  void changed(String day) {
    d = day;
  }

  void changey(String year) {
    y = year;
  }

  void changedesc(String description) {
    desc = description;
  }
}
