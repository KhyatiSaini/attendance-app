class Attendance {
  final String uid;
  final String name;
  final String roll;
  final String branch;
  final String hostel;
  final String mobile;

  Attendance({
    required this.uid,
    required this.name,
    required this.roll,
    required this.branch,
    required this.hostel,
    required this.mobile,
  });

  factory Attendance.fromJson(Map<String, dynamic> data) {
    return Attendance(
      uid: data['uid'],
      name: data['name'],
      roll: data['roll'],
      branch: data['branch'],
      hostel: data['hostel'],
      mobile: data['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['roll'] = roll;
    data['branch'] = branch;
    data['hostel'] = hostel;
    data['mobile'] = mobile;
    return data;
  }
}
