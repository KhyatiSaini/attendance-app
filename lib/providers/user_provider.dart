import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

import 'package:attendance_tracker/models/user.dart';
import 'package:attendance_tracker/utils/constant.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;

  Future<bool> createUser(UserModel user) async {
    try {
      final response = await post(
        Uri.parse('${baseUrl}api/user/register'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future<UserModel?> fetchUserById(String uid) async {
    try {
      final response = await get(
        Uri.parse('${baseUrl}api/user/getUserById/$uid'),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
        },
      );

      userModel = UserModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return userModel;
  }

  UserModel? get getUser => userModel;
}