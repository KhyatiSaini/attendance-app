class UserModel {
  final String id;
  final String name;
  final String mail;
  final String roll;
  final String branch;
  final String hostel;
  final int year;
  final String mobile;

  UserModel({
    required this.id,
    required this.name,
    required this.mail,
    required this.roll,
    required this.branch,
    required this.hostel,
    required this.year,
    required this.mobile,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      name: data['name'],
      mail: data['mail'],
      roll: data['roll'],
      branch: data['branch'],
      hostel: data['hostel'],
      year: data['year'],
      mobile: data['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mail'] = mail;
    data['roll'] = roll;
    data['branch'] = branch;
    data['hostel'] = hostel;
    data['year'] = year;
    data['mobile'] = mobile;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, mail: $mail, roll: $roll, branch: $branch, hostel: $hostel, year: $year, mobile: $mobile}';
  }
}
