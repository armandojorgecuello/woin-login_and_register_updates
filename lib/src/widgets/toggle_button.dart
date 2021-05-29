import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/models/user_detail.dart';

class ToggleButton extends StatefulWidget {
  final UserDetailResponse user;

  const ToggleButton({Key key,@required this.user}) : super(key: key);
  @override
  _ToggleButtonState createState() => _ToggleButtonState(
    this.user
  );
}

class _ToggleButtonState extends State<ToggleButton> {
  final UserDetailResponse user;
  double xAlign;
  Color emColor;
  Color cliColor;
  _ToggleButtonState(this.user);

  double width = 15.0.w;
  double height = 3.0.h;
  double emAlign = -1;
  double cliAlign = 1;
  Color selectedColor = Colors.grey;
  Color normalColor   = Colors.grey;


  @override
  void initState() {
    super.initState();
    xAlign =  emAlign;
    emColor =  user.typeDefault == 0 ?  Colors.grey : selectedColor;
    cliColor = user.typeDefault == 0 ?  Colors.grey : normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return user.typeDefault == 0 ? Container() : Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          user.typeDefault == 0 ? Container() : AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: Duration(milliseconds: 300),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: BoxDecoration(
                color:  user.typeDefault == 2 ? Color(0xff1BA6D2) : Color(0xffD2A409) ,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
          ),
          user.typeDefault == 0 ? Container() : GestureDetector(
            onTap: () {
              setState(() {
                xAlign = emAlign;
                emColor = selectedColor;
                cliColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Cli',
                  style: TextStyle(
                    color: emColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          user.typeDefault == 0 ? Container() : GestureDetector(
            onTap: () {
              setState(() {
                //xAlign = cliAlign;
                cliColor = selectedColor;
                emColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Em',
                  style: TextStyle(
                    color: cliColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}