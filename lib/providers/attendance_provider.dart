import 'dart:convert';

import 'package:attendance_tracker/models/attendance.dart';
import 'package:attendance_tracker/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../utils/constant.dart';

class AttendanceProvider extends ChangeNotifier {
  List<Attendance>? attendance;

  Future markAttendance(Attendance attendance, BuildContext context) async {
    try {
      final response = await post(
        Uri.parse('${baseUrl}api/attendance/mark'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
        },
        body: jsonEncode(attendance.toJson()),
      );

      if (response.statusCode == 200) {
        showSnackBar(context, 'Marked attendance successfully');
        return true;
      }
      else {
        showSnackBar(context, response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future<List<Attendance>?> fetchUserById(String uid) async {
    try {
      final response = await get(
        Uri.parse('${baseUrl}api/user/getUserById/$uid'),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
        },
      );

      attendance = jsonDecode(response.body).map((element) => Attendance.fromJson(element)).toList();
      notifyListeners();
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return attendance;
  }

}