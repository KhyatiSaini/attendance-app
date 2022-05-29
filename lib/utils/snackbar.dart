import 'package:attendance_tracker/utils/colors/colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
      backgroundColor: CustomColors.orangeColor,
    ),
  );
}