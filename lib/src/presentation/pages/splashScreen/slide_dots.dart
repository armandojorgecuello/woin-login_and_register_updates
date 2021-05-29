import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  bool isActive;

  SlideDots({Key key, this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 550),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 13 : 8,
      width: isActive ? 13 : 8,
      decoration: BoxDecoration(
          color: isActive ? Color(0xff1ba6d2) : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
