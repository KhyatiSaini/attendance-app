import 'package:attendance_tracker/ui/authentication/sign_in.dart';
import 'package:attendance_tracker/ui/authentication/sign_up.dart';
import 'package:attendance_tracker/utils/wave_clipper.dart';
import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orangeLight.shade200,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 500,
                  color: CustomColors.orangeLight.shade400,
                ),
              ),
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 470,
                  color: CustomColors.orangeLight.shade600,
                ),
              ),
              Positioned(
                bottom: 15,
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                              },
                              elevation: 0,
                              minWidth: double.infinity,
                              height: 48,
                              color: CustomColors.orangeColor,
                              splashColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: CustomColors.orangeLight.shade50,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 30,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SignInPage()));
                              },
                              elevation: 0,
                              minWidth: double.infinity,
                              height: 48,
                              color: CustomColors.orangeColor,
                              splashColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: CustomColors.orangeLight.shade50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: CustomColors.orangeColor,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: MaterialButton(
                        onPressed: () {

                        },
                        elevation: 0,
                        minWidth: double.infinity,
                        height: 48,
                        color: CustomColors.orangeLight.shade50,
                        splashColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'View Attendance',
                          style: TextStyle(
                            color: CustomColors.orangeDark.shade50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
