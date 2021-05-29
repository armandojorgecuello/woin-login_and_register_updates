import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/models/recovery_password_model.dart';
import 'package:woin/src/models/response_htttp_get.dart';
import 'package:woin/src/models/user_login.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/providers/user_service.dart';



class CodeActivacion extends StatefulWidget {
  final String pageTitle;
  final Device device;
  final WoinLocation location;
  //final User user;
  final String password;
  final String userName;
  final int typeRecovery;


  const CodeActivacion({Key key, @required this.pageTitle,  @required this.device, @required this.location, @required this.password, @required this.userName, this.typeRecovery}) : super(key: key); 
  

  @override
  CodeActivacionState createState() => CodeActivacionState(
    this.pageTitle,
    this.device,
    this.location,
    //this.user,
    this.password,
    this.userName,
    this.typeRecovery
  );
}

class CodeActivacionState extends State<CodeActivacion> {
  final String pageTitle;
  final Device device;
  final WoinLocation location;
  //final User user;
  final String password;
  final String userName;
  final int typeRecovery;

  CodeActivacionState(this.pageTitle, this.device, this.location, this.password, this.userName, this.typeRecovery);

  final _formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  String currentText = "";
  
  @override
  Widget build(BuildContext context) {
    //final userLoguin ulg = this.widget.ulg;
    return Hero(
      tag: "activeCuenta",
      child: SafeArea(
        child: Scaffold(
          appBar: _appBar(context),
          body: _body(),
        ),
      ),
    );
  }

  Container _body() {
    return Container(
      height: 100.0.h,
      width: 100.0.w,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 5.0.h,),
          buildLogoWoin(),
          SizedBox(height: 2.0.h,),
          _enterCode(),
          SizedBox(height: 2.0.h,),
          _codePin(),
          Expanded(child: Container()),
          _buttons()
        ],
      )
    );
  }

  Container _buttons() {
    return Container(
      width: 100.0.w,
      height: 8.0.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            elevation: 0,
            child: Container(
              width: 35.0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.close,
                    size:12.0.sp,
                    color: Color(0xff1ba6d2),
                  ),
                  Text(
                    'Cancelar',
                    style: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0xff1ba6d2),
                    fontSize:12.0.sp),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
          RaisedButton(
            elevation: 0,
            child: Container(
              width: 35.0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Continuar',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.white,
                      fontSize: 12.0.sp
                    ),
                  ),
                  SizedBox(
                    width:
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 12.0.sp,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Color(0xff1ba6d2),
            onPressed:  () async{
              if (_formKey.currentState.validate()) {
                geoLocation gl = new geoLocation();
                await gl.obtenerGeolocalizacion();
                showDialogV2(
                  context: context,
                  builder: (BuildContext context) => CustomDialogLoading()
                );
                if(pageTitle == "Modificar Contraseña"){
                  print("AQUI VA LA LOGICA  PARA RECUPERAR CREDENCIALES");
                  SendRecoveryPasswordData sendCode = SendRecoveryPasswordData(
                    code: int.parse(_pinPutController.text),
                    username: userName,
                    typerecovery: typeRecovery,
                  );
                  await userService.sendCodeToRecoveryPassword( 
                    context,
                    sendCode,
                    gl
                  );
                }else{
                  UserLoguin userLogin = UserLoguin(
                    code: int.parse(_pinPutController.text),
                    device: device,
                    password:password,
                    username: userName,
                    woinLocation: location
                  );
                  RespUserLoguin responseUserLogin = await userService.activarCuenta(userLogin, context);
                }
                
              }
            }
          ),
        ],
      ),
    );
  }

  Container _codePin() {
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: PinPut(
            fieldsCount: 6,
            textStyle: TextStyle(color:Color(0xff1ba6d2), fontWeight: FontWeight.bold, fontSize: 12.0.sp ),
            onSubmit: (String pin) => {},
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(5.0),
            ),
            selectedFieldDecoration: _pinPutDecoration,
            followingFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  Center _enterCode() {
    return Center(
      child: Text("Ingresar Código", style:TextStyle(fontSize:12.0.sp, color:Colors.black, fontWeight: FontWeight.bold))
    );
  }

  Container buildLogoWoin() {
    return Container(
      height: 20.0.h,
      child: Center(
        child: Icon(Icons.lock, color: Color(0xff1ba6d2), size:20.0.h,),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: 0,
      centerTitle: true,
      title: Text(pageTitle, style: TextStyle(color:Color(0xff1ba6d2), fontSize: 18.0.sp),),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.grey[500],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
