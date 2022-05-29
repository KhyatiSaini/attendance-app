import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:attendance_tracker/utils/colors/colors.dart';

import '../../utils/snackbar.dart';
import '../pages/home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String email;
  late String password;
  late bool loading;

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  bool validateEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orangeLight.shade100,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    cursorHeight: 20,
                    cursorWidth: 1.5,
                    autofocus: false,
                    cursorColor: CustomColors.orangeColor,
                    textAlignVertical: TextAlignVertical.center,
                    autocorrect: false,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: CustomColors.orangeColor,
                    ),
                    validator: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        if (!validateEmail(value)) {
                          return 'Please enter valid email.';
                        }
                      } else {
                        return 'This field is required.';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      email = value;
                    },
                    onFieldSubmitted: (String value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: CustomColors.orangeLight.shade700,
                      ),
                      filled: true,
                      fillColor: CustomColors.orangeLight.shade200,
                      contentPadding: const EdgeInsets.only(
                        left: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    cursorHeight: 20,
                    cursorWidth: 1.5,
                    autofocus: false,
                    cursorColor: CustomColors.orangeColor,
                    textAlignVertical: TextAlignVertical.center,
                    autocorrect: false,
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      color: CustomColors.orangeColor,
                    ),
                    obscureText: true,
                    validator: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                      } else {
                        return 'This field is required.';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      password = value;
                    },
                    onFieldSubmitted: (String value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: CustomColors.orangeLight.shade700,
                      ),
                      filled: true,
                      fillColor: CustomColors.orangeLight.shade200,
                      contentPadding: const EdgeInsets.only(
                        left: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.orangeLight.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: loading
                      ? Platform.isAndroid
                          ? const CircularProgressIndicator(
                              color: CustomColors.orangeColor,
                            )
                          : const CupertinoActivityIndicator(
                              color: CustomColors.orangeColor,
                            )
                      : MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                showSnackBar(context, 'Sign in successful');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                              } catch (error) {
                                showSnackBar(context, error.toString());

                                if (kDebugMode) {
                                  print(error);
                                }
                              }

                              setState(() {
                                loading = false;
                              });
                            }
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
                Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: const Text(
                    'Don\' have an account? Sign Up here!',
                    style: TextStyle(
                      color: CustomColors.orangeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
