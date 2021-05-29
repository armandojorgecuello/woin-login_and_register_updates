import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

showgeneralDialogRegister({ String title, String popContent, context, Function onPressed, String buttonText }){
    showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget){
        final curvedValue = Curves.easeInOutBack.transform ( 1.0) - (a1.value);
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: SafeArea(
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height:4.0.h,),
                      Text(
                        title, style: TextStyle(fontSize:14.0.sp, color:Color(0xff1ba6d2), fontWeight: FontWeight.bold), 
                      ),
                      SizedBox(height:4.0.h,),
                      Text(popContent, style: TextStyle(fontSize:12.0.sp, color:Color(0xfc979797)), textAlign: TextAlign.center,),
                      SizedBox(height:4.0.h,),
                      ButtonTheme(
                        minWidth: 35.0.w,
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color:Color(0xff1ba6d2))
                          ),
                          child: Text(buttonText, style: TextStyle(fontSize:15.0.sp, color:Color(0xff1ba6d2))),
                          onPressed: onPressed
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {}
    );
  }













