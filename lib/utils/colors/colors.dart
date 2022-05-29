import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  static const int primaryColor = 0xffff9800;
  static const Color orangeColor = Color(0xffffa21a);

  static const MaterialColor orangeLight = MaterialColor(
    primaryColor,
    <int, Color>{
      50: Color(0xffffffff),
      100: Color(0xfffff5e6),
      200: Color(0xffffeacc),
      300: Color(0xffffe0b3),
      400: Color(0xffffd699),
      500: Color(0xffffcc80),
      600: Color(0xffffc166),
      700: Color(0xffffb74d),
      800: Color(0xffffad33),
      900: Color(0xffffa21a),
    },
  );

  static const MaterialColor orangeDark = MaterialColor(
    primaryColor,
    <int, Color>{
      50: Color(0xffe68900),
      100: Color(0xffcc7a00),
      200: Color(0xffb36a00),
      300: Color(0xff995b00),
      400: Color(0xff804c00),
      500: Color(0xff663d00),
      600: Color(0xff4c2e00),
      700: Color(0xff331e00),
      800: Color(0xff190f00),
      900: Color(0xff000000),
    },
  );
}
