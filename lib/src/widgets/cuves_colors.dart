import 'package:flutter/material.dart';

class BottomWaveClipperCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 6, size.height / 6);
    var firstdEndPoint = Offset(size.width / 2, size.height /5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 3.25);
    var secondEndPoint = Offset(size.width, size.height/1.5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 70);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class BottomGreyClipperCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 6, size.height / 6);
    var firstdEndPoint = Offset(size.width / 2.5, size.height /4.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 3.38);
    var secondEndPoint = Offset(size.width, size.height / 1.35);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}