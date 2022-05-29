import 'package:flutter/cupertino.dart';
import 'package:attendance_tracker/utils/colors/colors.dart';

Widget getCustomContainer() {
  return Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 5,
    ),
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        10,
      ),
      color: CustomColors.orangeLight.shade200,
      border: Border.all(
        color: CustomColors.orangeLight.shade400,
        width: 1.5,
      ),
    ),
  );
}
