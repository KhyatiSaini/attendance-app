import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    Offset firstStart = Offset(size.width / 5, size.height); //start path with this if you are making at bottom
    Offset firstEnd = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    Offset secondStart = Offset(size.width - (size.width / 3.24), size.height - 70);
    Offset secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}