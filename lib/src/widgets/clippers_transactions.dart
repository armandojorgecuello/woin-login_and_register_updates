import 'package:flutter/material.dart';

class BottomWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 20, size.height / 5);
    var firstdEndPoint = Offset(size.width / 2.35, size.height / 3.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 2.15);
    var secondEndPoint = Offset(size.width, size.height / 1.25);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 70);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomGreyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 20, size.height / 5);
    var firstdEndPoint = Offset(size.width / 2.5, size.height / 3.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 2.15);
    var secondEndPoint = Offset(size.width, size.height / 1.25);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    ;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
