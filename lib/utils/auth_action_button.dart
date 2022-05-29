import 'package:attendance_tracker/models/user_image.dart';
import 'package:attendance_tracker/services/camera_service.dart';
import 'package:attendance_tracker/services/database_helper.dart';
import 'package:attendance_tracker/services/ml_service.dart';
import 'package:attendance_tracker/ui/pages/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthActionButton extends StatefulWidget {
  const AuthActionButton({
    Key? key,
    required this.onPressed,
    required this.isLogin,
    required this.reload,
    required this.email,
  }) : super(key: key);
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  final String email;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  final MLService _mlService = MLService();
  final CameraService _cameraService = CameraService();

  UserImageModel? predictedUser;

  Future _signUp(context) async {

  }

  Future _signIn(context) async {
    // String password = _passwordTextEditingController.text;
    // if (predictedUser!.password == password) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (BuildContext context) => Profile(
    //                 predictedUser!.user,
    //                 imagePath: _cameraService.imagePath!,
    //               )));
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const AlertDialog(
    //         content: const Text('Wrong password!'),
    //       );
    //     },
    //   );
    // }
  }

  Future<UserImageModel?> _predictUser() async {
    UserImageModel? userImageModel = await _mlService.predict();
    return userImageModel;
  }

  Future onTap() async {
    try {
      bool faceDetected = await widget.onPressed();
      if (faceDetected) {
        if (widget.isLogin) {
          var user = await _predictUser();
          if (user != null) {
            predictedUser = user;
          }
        }
        else {
          _signUp(context);
        }
        // PersistentBottomSheetController bottomSheetController =
        //     Scaffold.of(context)
        //         .showBottomSheet((context) => signSheet(context));
        // bottomSheetController.closed.whenComplete(() => widget.reload());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[200],
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'CAPTURE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Colors.white)
          ],
        ),
      ),
    );
  }

  // signSheet(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         widget.isLogin && predictedUser != null
  //             ? Text(
  //                 'Welcome back, ' + predictedUser!.email + '.',
  //                 style: const TextStyle(fontSize: 20),
  //               )
  //             : widget.isLogin
  //                 ? const Text(
  //                     'User not found',
  //                     style: TextStyle(fontSize: 20),
  //                   )
  //                 : Container(),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
