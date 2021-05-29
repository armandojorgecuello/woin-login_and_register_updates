import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final Path path=Path();
    path.lineTo(0.0, size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height*.6);
    //path.lineTo(size.width*.8, size.height*.2);
    var startpoint1=Offset(size.width*.98, size.height*.50);
    var endpoint1=Offset(size.width*.86, size.height*.22);
    path.quadraticBezierTo(startpoint1.dx, startpoint1.dy, endpoint1.dx, endpoint1.dy);

    var startpoint=Offset(size.width*.70, size.height*.18);
   var endpoint=Offset(size.width*.68, 0 );
    path.quadraticBezierTo(startpoint.dx, startpoint.dy, endpoint.dx, endpoint.dy);

   // var startpoint2=Offset(size.width*.67, size.height*.07);
    //var endpoint2=Offset(size.width*.69, 0);
    //path.quadraticBezierTo(startpoint2.dx, startpoint2.dy, endpoint2.dx, endpoint2.dy);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) =>true;

}