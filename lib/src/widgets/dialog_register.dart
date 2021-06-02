


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/main.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';
import 'package:woin/src/presentation/pages/tab-principal/home_page.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/presentation/pages/usuario/codeActivacion.dart';


class DialogRegister {

  showPopCustomizer({context, String content, String title}){
    TextStyle style = TextStyle(fontSize:12.0, fontStyle: FontStyle.italic, color:Colors.grey);
    showGeneralDialog(
      context: context, 
      pageBuilder: (_, __, ___)=> AlertDialog(
        backgroundColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.w),
                child: Text(
                  title, 
                  style:TextStyle(fontSize:20.0, fontStyle: FontStyle.italic, color:Colors.white), 
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0.w),
                child: Text(content, style:style, textAlign: TextAlign.center,),
              ),
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context)=> HomePage())
                  );
                },
                child: Text("Ir al Inicio", style:style),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                color: Color(0xFF5701AB),
              )
            ],
          ),
        ) ,
      )
    ); 
  }

  

}


class ConfirmVerificationCodeReceive extends StatefulWidget {
  final String imgUrl; 
  final String title; 
  final String content; 
  final String firstTitle; 
  final String okButtonTex; 
  final String closeButonText;
  final String pageTitle;
  final Device device;
  final WoinLocation location;
  final String password;
  final String userName;

  const ConfirmVerificationCodeReceive({Key key, this.imgUrl, this.title, this.content, this.firstTitle, this.okButtonTex, this.closeButonText, this.pageTitle, this.device, this.location, this.password, this.userName,}) : super(key: key);

  @override
  _ConfirmVerificationCodeReceiveState createState() => _ConfirmVerificationCodeReceiveState(
    this.imgUrl,
    this.title,
    this.content,
    this.firstTitle,
    this.okButtonTex,
    this.closeButonText,
    this.pageTitle,
    this.device,
    this.location,
    this.password,
    this.userName,
  );
}

class _ConfirmVerificationCodeReceiveState extends State<ConfirmVerificationCodeReceive> {

  final String imgUrl; 
  final String title; 
  final String content; 
  final String firstTitle; 
  final String okButtonTex; 
  final String closeButonText;
  final String pageTitle;
  final Device device;
  final WoinLocation location;
  final String password;
  final String userName;

  _ConfirmVerificationCodeReceiveState(this.imgUrl, this.title, this.content,  this.firstTitle, this.okButtonTex, this.closeButonText, this.pageTitle, this.device, this.location, this.password, this.userName);


  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:2.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.0.h ,),
              Text(firstTitle, style: TextStyle(fontSize:20.0.sp, color:Color(0xff1ba6d2)),),
              SizedBox(height: 2.0.h ,),
              Icon(Icons.security_sharp, size: 150.0.sp, color:Color(0xff1ba6d2)),
              SizedBox(height: 2.0.h ,),
              Text(
                title,
                style: TextStyle(fontSize:20.0.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.0.h ,),
              Text(content, textAlign: TextAlign.center, style: TextStyle(color:Color(0xfc979797), fontSize:11.0.sp),),
              Expanded(child:Container()),
              RaisedButton(
                color: Color(0xff1ba6d2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)
                ),
                onPressed:(){
                  if(okButtonTex == "Reenviar"){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }else if(okButtonTex == "Iniciar Sesión"   ){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }else{
                     Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CodeActivacion(
                      pageTitle: pageTitle,
                      device: device,
                      location: location,
                      //user: user,
                      password: password,
                      userName: userName,
                    )));
                  }
                } ,
                child: Container(
                  width: 30.0.w,
                  child: Center(
                    child: Text( 
                      okButtonTex ,
                      style:TextStyle(color:Colors.white)
                    )
                  )
                ),
              ),
              SizedBox(height: 1.0.h,),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(
                    color: Color(0xff1ba6d2)
                  )
                ),
                onPressed: (){
                 if(okButtonTex == "Reenviar"){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }else if(okButtonTex == "Iniciar Sesión"   ){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: 30.0.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, color: Color(0xff1ba6d2)),
                      SizedBox(width: 2.0.w,),
                      Text( closeButonText, style:TextStyle(color:Color(0xff1ba6d2)) ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.0.h,),
            ],
          ),
        ),
      ),
    );
  }
}



showgeneralDialogPromo({
    String imgUrl, 
    String title, 
    String content, 
    context, 
    String firstTitle, 
    Function funcOkButton, 
    Function funcCancelButton, 
    String okButtonTex, 
    String closeButonText
  }){
    showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget){
        final curvedValue = Curves.easeInOutBack.transform ( 1.0) - (a1.value);
        return Builder(
          builder: (BuildContext context) { 
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal:2.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.0.h ,),
                      Text(firstTitle, style: TextStyle(fontSize:20.0.sp, color:Color(0xff1ba6d2)),),
                      SizedBox(height: 2.0.h ,),
                      Icon(Icons.security_sharp, size: 150.0.sp, color:Color(0xff1ba6d2)),
                      SizedBox(height: 2.0.h ,),
                      Text(
                        title,
                        style: TextStyle(fontSize:20.0.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.0.h ,),
                      Text(content, textAlign: TextAlign.center, style: TextStyle(color:Color(0xfc979797), fontSize:11.0.sp),),
                      Expanded(child:Container()),
                      RaisedButton(
                        color: Color(0xff1ba6d2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        onPressed: funcOkButton,
                        child: Container(
                          width: 30.0.w,
                          child: Center(child: Text( okButtonTex ,style:TextStyle(color:Colors.white)))
                        ),
                      ),
                      SizedBox(height: 1.0.h,),
                      RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(
                            color: Color(0xff1ba6d2)
                          )
                        ),
                        onPressed: funcCancelButton,
                        child: Container(
                          width: 30.0.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.close, color: Color(0xff1ba6d2)),
                              SizedBox(width: 2.0.w,),
                              Text( closeButonText, style:TextStyle(color:Color(0xff1ba6d2)) ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.0.h,),
                    ],
                  ),
                ),
              ),
            );
          },
          
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {}
    );
  }
