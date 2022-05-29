import 'dart:io';

import 'package:attendance_tracker/models/user.dart';
import 'package:attendance_tracker/providers/user_provider.dart';
import 'package:attendance_tracker/ui/onboarding/save_image.dart';
import 'package:attendance_tracker/utils/colors/colors.dart';
import 'package:attendance_tracker/utils/mapping.dart';
import 'package:attendance_tracker/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  late String hostel;
  late int year;
  late String branch;

  late bool loading;

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  TextStyle get dropdownMenuItemTextStyle => const TextStyle(
        color: CustomColors.orangeColor,
      );

  List<DropdownMenuItem<String>> get hostelDropdownList {
    List<DropdownMenuItem<String>> hostelList = [
      DropdownMenuItem(
        child: Text(
          'Ambika Girls Hostel',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Ambika Girls Hostel',
      ),
      DropdownMenuItem(
        child: Text(
          'Parvati Girls Hostel',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Parvati Girls Hostel',
      ),
      DropdownMenuItem(
        child: Text(
          'Manimahesh Girls Hostel',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Manimahesh Girls Hostel',
      ),
    ];
    return hostelList;
  }

  List<DropdownMenuItem<String>> get yearDropdownList {
    List<DropdownMenuItem<String>> yearList = [
      DropdownMenuItem(
        child: Text(
          '1st year',
          style: dropdownMenuItemTextStyle,
        ),
        value: '1st year',
      ),
      DropdownMenuItem(
        child: Text(
          '2nd year',
          style: dropdownMenuItemTextStyle,
        ),
        value: '2nd year',
      ),
      DropdownMenuItem(
        child: Text(
          '3rd year',
          style: dropdownMenuItemTextStyle,
        ),
        value: '3rd year',
      ),
      DropdownMenuItem(
        child: Text(
          '4th year',
          style: dropdownMenuItemTextStyle,
        ),
        value: '4th year',
      ),
      DropdownMenuItem(
        child: Text(
          '5th year',
          style: dropdownMenuItemTextStyle,
        ),
        value: '5th year',
      ),
    ];
    return yearList;
  }

  List<DropdownMenuItem<String>> get branchDropdownList {
    List<DropdownMenuItem<String>> branchList = [
      DropdownMenuItem(
        child: Text(
          'Civil Engineering',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Civil Engineering',
      ),
      DropdownMenuItem(
        child: Text(
          'Electrical Engineering',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Electrical Engineering',
      ),
      DropdownMenuItem(
        child: Text(
          'Mechanical Engineering',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Mechanical Engineering',
      ),
      DropdownMenuItem(
        child: Text(
          'Electronics and Communication Engineering',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Electronics and Communication Engineering',
      ),
      DropdownMenuItem(
        child: Text(
          'Architecture',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Architecture',
      ),
      DropdownMenuItem(
        child: Text(
          'Computer Science and Engineering',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Computer Science and Engineering',
      ),
      DropdownMenuItem(
        child: Text(
          'Chemical Engineering',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Chemical Engineering',
      ),
      DropdownMenuItem(
        child: Text(
          'Material Science and Engineering',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Material Science and Engineering',
      ),
      DropdownMenuItem(
        child: Text(
          'Engineering Physics',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Engineering Physics',
      ),
      DropdownMenuItem(
        child: Text(
          'Mathematics and Computing',
          style: dropdownMenuItemTextStyle,
        ),
        value: 'Mathematics and Computing',
      ),
    ];
    return branchList;
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
                  controller: nameController,
                  autocorrect: false,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                    color: CustomColors.orangeColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Name',
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
                  controller: rollNoController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Roll Number',
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
                child: DropdownButtonFormField(
                  items: hostelDropdownList,
                  isExpanded: true,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        hostel = mapHostel(value);
                      });
                    }
                  },
                  dropdownColor: CustomColors.orangeLight.shade200,
                  style: TextStyle(
                    color: CustomColors.orangeLight.shade700,
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Hostel',
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
                child: DropdownButtonFormField(
                  items: yearDropdownList,
                  isExpanded: true,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        year = mapYear(value);
                      });
                    }
                  },
                  dropdownColor: CustomColors.orangeLight.shade200,
                  style: TextStyle(
                    color: CustomColors.orangeLight.shade700,
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Year',
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
                child: DropdownButtonFormField(
                  items: branchDropdownList,
                  isExpanded: true,
                  onChanged: (String? value) {
                    if (value != null) {
                      branch = value;
                    }
                  },
                  dropdownColor: CustomColors.orangeLight.shade200,
                  style: TextStyle(
                    color: CustomColors.orangeLight.shade700,
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Branch',
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
                  enabled: true,
                  cursorColor: CustomColors.orangeColor,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    color: CustomColors.orangeColor,
                  ),
                  controller: mobileController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Mobile Number',
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
                          setState(() {
                            loading = true;
                          });
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            UserModel userModel = UserModel(
                              id: user.uid,
                              name: nameController.text.trim(),
                              mail: user.email!,
                              roll: rollNoController.text.trim(),
                              branch: branch,
                              hostel: hostel,
                              year: year,
                              mobile: mobileController.text.trim(),
                            );
                            final userProvider = Provider.of<UserProvider>(
                                context,
                                listen: false);
                            await userProvider.createUser(userModel);
                            showSnackBar(context, "Data saved successfully");
                          }
                          setState(() {
                            loading = false;
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SaveImagePage(),
                            ),
                          );
                        },
                        elevation: 0,
                        minWidth: double.infinity,
                        height: 48,
                        color: CustomColors.orangeColor,
                        splashColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: CustomColors.orangeLight.shade50,
                          ),
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
