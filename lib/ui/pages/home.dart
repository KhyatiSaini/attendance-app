import 'package:attendance_tracker/models/attendance.dart';
import 'package:attendance_tracker/models/user.dart';
import 'package:attendance_tracker/providers/attendance_provider.dart';
import 'package:attendance_tracker/providers/user_provider.dart';
import 'package:attendance_tracker/ui/landing/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/colors/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orangeLight.shade200,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.orangeLight.shade900,
        elevation: 0.2,
        title: Text(
          'Attendance',
          style: TextStyle(
            color: CustomColors.orangeLight.shade50,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              size: 26,
              color: CustomColors.orangeLight.shade100,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    UserModel? userModel =
                        await userProvider.fetchUserById(user.uid);

                    if (userModel != null) {
                      Attendance attendance = Attendance(
                        uid: user.uid,
                        name: userModel.name,
                        roll: userModel.roll,
                        branch: userModel.branch,
                        hostel: userModel.hostel,
                        mobile: userModel.mobile,
                      );
                      final attendanceProvider =
                          Provider.of<AttendanceProvider>(context,
                              listen: false);
                      attendanceProvider.markAttendance(attendance, context);
                    }
                  }
                },
                elevation: 0,
                minWidth: double.infinity,
                height: 48,
                color: CustomColors.orangeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Mark Attendance',
                  style: TextStyle(
                    color: CustomColors.orangeLight.shade50,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {},
                elevation: 0,
                minWidth: double.infinity,
                height: 48,
                color: CustomColors.orangeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: CustomColors.orangeLight.shade50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
