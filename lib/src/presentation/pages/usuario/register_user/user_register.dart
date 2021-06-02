import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;


import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/models/user_type_model/simply_user_model.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/usuario/Login.dart';
import 'package:woin/src/presentation/widgets/cardWoin.dart';
import 'package:woin/src/presentation/widgets/dialog_reigster_code_user.dart';
import 'package:woin/src/providers/user_service.dart';
import 'package:woin/src/widgets/cuves_colors.dart';
import 'package:woin/src/widgets/dialog_terms_conditions.dart';

class mainRegisterUser extends StatefulWidget {
final int isVisitant;
mainRegisterUser({this.isVisitant});

@override
  _mainRegisterUserState createState() => _mainRegisterUserState();
}

class _mainRegisterUserState extends State<mainRegisterUser> {
  //int visibletec = 0;

  int vpassword = 0;
  int visibleconfirm = 0;
  int errorpassword = 0;
  int errorConfim = 0;
  int errpalClave=0;
  int currentIndex = 0;
  int errcPClave=0;
  bool cliWoinSelected = true;
  bool termsAccepted = false;
  double heigthUserInfo;
  double heigthPassword;
  double heigthProfileType;
  final _formKey = GlobalKey<FormState>();
  String comercialActivity = "Productos";
  String paswword;
  Uint8List bytes = Uint8List(0);
  TextEditingController _inputController  = new TextEditingController();
  TextEditingController _outputController = new TextEditingController();
  TextEditingController codigoController = new TextEditingController();
  TextEditingController publicNameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController confirmEmailController = new TextEditingController();
  TextEditingController pclaveController = new TextEditingController();
  TextEditingController pclaveconfirmController = new TextEditingController();
  final GlobalKey<FormFieldState> _keycodigoController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keypublicNameController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyusernameController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keypasswordController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyconfirmpasswordController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keytelefonoController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyemailController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keypclaveController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyConfirmEmailController = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  closeModal() {
    Navigator.of(context).pop();
  }

  irALogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding =EdgeInsets.symmetric(horizontal:3.0.w, vertical: 1.0.h);
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context)=> Login()
          )
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: _appBar(context),
        body: _body(padding, context) 
      ),
    );
  }

  Container _body(EdgeInsetsGeometry padding, BuildContext context) {
    return Container(
      height: 100.0.h,
      width: 100.0.w,
      child: Form(
        key:_formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 2.0.w,vertical: 1.0.h),
          children: <Widget>[
            _profileType(padding, context),
            SizedBox(height: 1.0.h,),
            _userInfo(padding, context),
            SizedBox(height: 1.0.h,),
            _createPassword(padding, context),
            _buttonsRegister()
          ],
        ),
      ),
    );
  }

  Theme _checkBox(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.black, // Your color
      ),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.all(0.0),
        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
        checkColor: Colors.black,
        activeColor: Color(0xff1ba6d2),
        value: termsAccepted , 
        //tristate: false,
        title: Text(
          "Aceptar Terminos y Condiciones", 
          style:TextStyle(color:Colors.black, fontSize: 10.0.sp,fontFamily: "SansRegularlight"),
        ),
        onChanged: (bool value){
          setState(() {
            termsAccepted = value;
          });
        },
        secondary: GestureDetector(
          child: Icon(Icons.visibility),
          onTap: (){
            
          },
        ), 
      ),
    );
  }

  Container _userInfo(EdgeInsetsGeometry padding, BuildContext context) {
    return Container(
      height: heigthUserInfo ?? 45.0.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 2.0.h,bottom: 3.0.h),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: padding,
                child: Text(
                  "Datos de usuario para iniciar sesión",
                  style: TextStyle(color:Color(0xff1ba6d2),fontWeight: FontWeight.bold,fontSize: 11.0.sp, fontFamily: "Roboto-bold" ),
                ),
              ),
              
              Padding(
                padding: padding,
                child: _textFieldUserName(context),
              ),
              Padding(
                padding: EdgeInsets.only(right: 3.0.w, left:3.0.w, top:2.0.h,bottom:0.5.h ),
                child: Text(
                  "Crear contraseña",
                  maxLines: 1,
                  style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 10.0.sp, fontFamily: "Roboto-bold" ),
                )
              ),
              Padding(
                padding: padding,
                child: _textFieldPassword(context),
              ),
              Padding(
                padding:padding,
                child:_textFieldConfirmPassword(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _createPassword(EdgeInsetsGeometry padding, BuildContext context) {
    return Container(
      height: heigthPassword ?? 56.0.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 2.0.h,bottom: 3.0.h),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 3.0.w, left:3.0.w, top:2.0.h,bottom:0.5.h ),
                child: Text(
                  "Método para recuperar contraseña",
                  maxLines: 2,
                  style: TextStyle(color:Color(0xff1ba6d2),fontWeight: FontWeight.bold,fontSize: 11.0.sp, fontFamily: "Roboto-bold" ),
                )
              ),
              Padding(
              padding: padding,
                child: _textFieldEmail(context),
              ),
              Padding(
              padding: padding,
                child: _textFieldConfirmEmail(context),
              ),
              Padding(
                padding: padding,
                child: _textFieldPhoneNumber(context),
              ),
              Padding(
                padding: EdgeInsets.only(right: 3.0.w, left:3.0.w, top:2.0.h,bottom:0.5.h ),
                child: Text(
                  "Escriba una palabra clave para recuperar contraseña",
                  maxLines: 1,
                  style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 10.0.sp, fontFamily: "Roboto-bold" ),
                )
              ),
              Padding(
                padding: padding,
                child: textFieldKeyWord(context),
              ),
              //Padding(
              //  padding: padding,
              //  child: _checkBox(context),
              //),
            ],
          ),
        ),
      ),
    );
  }

  Container _profileType(EdgeInsetsGeometry padding, BuildContext context) {
    return Container(
      height: heigthProfileType ?? 62.0.h,
      width: 100.0.w,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 2.0.h, bottom: 3.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: padding,
                child: Text(
                  "Seleccione perfil para el intercambio comercial",
                  style: TextStyle(color:Color(0xff1ba6d2),fontWeight: FontWeight.bold,fontSize: 11.0.sp, fontFamily: "Roboto-bold" ),
                ),
              ),
              Padding(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _cliWoinCard(),
                    Expanded(child:Container()),
                    _enWoinCard(),
                  ],
                ),
              ),
              _textTypeUser(padding),
              cliWoinSelected == true ? Container() : Padding(
                padding: padding,
                child: Text(
                  "Seleccione la actividad de su empresa",
                  style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 10.0.sp, fontFamily: "Roboto-bold" ),
                ),
              ),
              cliWoinSelected == true ? Container() : _emWoinSelectorService(),
              Padding(
                padding: padding,
                child: Text(
                  "Información visible públicamente",
                  style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 10.0.sp, fontFamily: "Roboto-bold" ),
                ),
              ),
              _profileTypeTextField(),
              Padding(
                padding: padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 74.0.w,
                      child: _textFieldReferredCode(context)
                    ),
                    Expanded(child:Container()),
                    GestureDetector(
                      child: Icon(Icons.qr_code_scanner,size: 25.0.sp,color: Colors.grey[500],),
                      onTap: (){
                        //_scan();
                       showScanQRDialog(
                         content: "Escanea ó selecciona QR del usuario que lo invitó para ingresar como referido",
                         title: "Código de referido",
                         context: context
                       );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> itemsList = [
    "Productos",
    "Servicios",
    "Inmuebles",
    "Vehículos",
    "Eventos"
  ];

  List<IconData> listIcons = [
    LineIcons.shoppingBag,
    Icons.build,
    Icons.location_city,
    LineIcons.car,
    Icons.cake,
  ];


  Padding _emWoinSelectorService() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:3.0.w, vertical: 0.5.h),
      child: Container(
        height: 10.0.h,
        width: 100.0.w,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: itemsList.length,
          itemBuilder: (context, index){
            return _itemsSelector(
              icon:  listIcons[index],
              title: itemsList[index] ,
              index: index
            );
          },
        ),
      ),
    );
  }

  Padding _itemsSelector({String title, IconData icon, int index}) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:2.5.w, vertical: 0.5.h),
      child: GestureDetector(
        onTap: (){
          setState((){
            currentIndex = index;
            comercialActivity = title;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            CircleAvatar(
              radius: 3.0.h,
              backgroundColor: currentIndex == index ? Color(0xffFFD400) :  Colors.grey[100],
              child: Icon(icon, color:currentIndex == index ? Colors.white : Colors.grey  ),
            ),
            SizedBox(height: 0.5.h,),
            Text(title, style:TextStyle(fontSize: 8.0.sp,color:currentIndex == index ? Color(0xffFFD400) :  Colors.grey ))
          ]
        )
      ),
    );
  }

  Padding _profileTypeTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:3.0.w, vertical: 1.0.h),
      child: TextFormField(
        controller: publicNameController,
        key: _keypublicNameController,
        onChanged: (String value){
          _keypublicNameController.currentState.validate();
        },
        validator: (String value){
          if (value.length < 3) {
          return "Minimo 3 caracteres";
          }
          return null;
        },
        maxLength: 50,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          suffixIcon: Icon(Icons.person, color:Colors.white, size: 14.0.sp),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
              borderSide: BorderSide( color: Colors.red[600])
          ),
          
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all( Radius.circular(5.0)),
              borderSide: BorderSide( color: Colors.red[600])
          ),
          errorStyle: TextStyle(fontSize: 8.0.sp),
          contentPadding: EdgeInsets.all(10),
          labelText: cliWoinSelected == false ? "Nombre de su empresa ó negocio" : "Nombre cliente",
          labelStyle: TextStyle(color: Color(0xfc979797), fontSize: 11.0.sp),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
            borderSide: BorderSide( color: Colors.grey[300])
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[500])
          ),
        ),
      ),
    );
  }

  Padding _textTypeUser(EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: cliWoinSelected == true 
      ? RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: "Clientes que desean comprar y ",
            style: TextStyle(fontSize: 12.0.sp, color: Color(0xff1BA6D2),fontFamily: "Roboto-ligth"),
            children: <TextSpan>[
              TextSpan(
                text: "ganar puntos ",
                style: TextStyle(fontSize: 12.0.sp, color: Color(0xff1BA6D2), fontWeight: FontWeight.bold,fontFamily: "Roboto-bold"),
              ),
              TextSpan(
                text: "para adquirir bienes, productos o servicios.",
                style: TextStyle(fontSize: 12.0.sp, color: Color(0xff1BA6D2),fontFamily: "Roboto-ligth") 
              )
            ]
          )
        )
      : RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: "Empresas que buscan visibilidad para ",
          style: TextStyle(fontSize: 12.0.sp, color: Color(0xffFFD400),fontFamily: "Roboto-ligth"),
          children: <TextSpan>[
            TextSpan(
              text: "incrementar sus ventas ",
              style: TextStyle(fontSize: 12.0.sp, color: Color(0xffFFD400),fontFamily: "Roboto-bold", fontWeight: FontWeight.bold) 
            ),
            TextSpan(
              text: "y ",
              style: TextStyle(fontSize: 12.0.sp, color: Color(0xffFFD400),fontFamily: "Roboto-ligth") 
            ),
            TextSpan(
              text: "fidelizar ",
              style: TextStyle(fontSize: 12.0.sp, color: Color(0xffFFD400),fontFamily: "Roboto-bold", fontWeight: FontWeight.bold) 
            ),
            TextSpan(
              text: "clientes.",
              style: TextStyle(fontSize: 12.0.sp, color: Color(0xffFFD400),fontFamily: "Roboto-ligth") 
            ),
          ]
        )
      ),
    );
  }

  Card _enWoinCard() {
    return Card(
      //elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cliWoinSelected == true ? Colors.white : Color.fromRGBO(194, 159, 0, 1)),
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: InkWell(
        onTap: (){
          if(cliWoinSelected == true){
            setState(() {
              cliWoinSelected = false;
              heigthProfileType = 74.0.h;
            });
          }
        },
        child: Stack(
          children: [
            Container(
              height: 15.0.h,
              width: 40.0.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cliWoinSelected == false ? SizedBox(width:1.0.w ) : Container(),
                    Text("Emwoin", style:TextStyle(color: cliWoinSelected == false ? Color.fromRGBO(194, 159, 0, 1) : Colors.grey, fontSize:16.0.sp, fontWeight: FontWeight.bold)),
                  ],
                )
              )
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: ClipPath(
                clipper: BottomGreyClipperCurve(),
                child:Container(
                  height: 15.0.h,
                  width: 40.0.w,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(235, 237, 242, 1),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                  ),
                )
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: ClipPath(
                clipper: BottomWaveClipper(),
                child:Container(
                  height: 15.0.h,
                  width: 40.0.w,
                  decoration: BoxDecoration(
                    gradient: cliWoinSelected == false ? LinearGradient(
                      colors: [Color.fromRGBO(255, 238, 0, 1),Color.fromRGBO(194, 159, 0, 1),  Color.fromRGBO(128, 73, 0, 1)],
                      stops: [0.08,0.22, 0.8],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft
                    ) : LinearGradient(
                      colors: [
                        Colors.grey[100],
                        Colors.grey[400],
                        Colors.grey[700]
                      ],
                      stops:[
                        0.01,
                        0.15,
                        0.5
                      ],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft
                    ),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                  ),
                )
              ),
            ),
            Positioned(
              right: 2.0.w,
              top: 2.0.w,
              child: cliWoinSelected == false ? Icon(Icons.check_circle, color: Colors.white) : Container(),
            )
          ],
        ),
      ),
    );
  }

  Card _cliWoinCard() {
    return Card(
      //elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cliWoinSelected == true ?  Color.fromRGBO(13, 183, 203, 1) : Colors.white),
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: InkWell(
        onTap: (){
          if(cliWoinSelected == false){
            setState(() {
              cliWoinSelected = true;
              heigthProfileType = 59.0.h;
            });
          }
        },
        child: Stack(
          children: [
            Container(
              height: 15.0.h,
              width: 40.0.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cliWoinSelected == true ? SizedBox(width:1.0.w ) : Container(),
                    Text("Cliwoin", style:TextStyle(color: cliWoinSelected == true ? Color.fromRGBO(13, 183, 203, 1) : Colors.grey, fontSize:16.0.sp, fontWeight: FontWeight.bold)),
                  ],
                )
              )
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: ClipPath(
                clipper: BottomGreyClipperCurve(),
                child:Container(
                  height: 15.0.h,
                  width: 40.0.w,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(235, 237, 242, 1),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                  ),
                )
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: ClipPath(
                clipper: BottomWaveClipperCurve(),
                child:Container(
                  height: 15.0.h,
                  width: 40.0.w,
                  decoration: BoxDecoration(
                    gradient: cliWoinSelected == true ? LinearGradient(
                      colors: [Color.fromRGBO(0, 255, 229, 1), Color.fromRGBO(13, 183, 203, 1), Color.fromRGBO(0, 117, 177, 1)],
                      stops: [0.01,0.15,0.5],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft
                    ) : LinearGradient(
                      colors: [
                        Colors.grey[100],
                        Colors.grey[400],
                        Colors.grey[700]
                      ],
                      stops:[
                        0.01,
                        0.15,
                        0.5
                      ],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft
                    ),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                  ),
                )
              ),
            ),
            Positioned(
              right: 2.0.w,
              top: 2.0.w,
              child: cliWoinSelected == true ? Icon(Icons.check_circle, color: Colors.white) : Container(),
            )
          ],
        ),
      ),
    );
  }

  Container _buttonsRegister(){
    return Container(
      height: 7.0.h,
      width: 100.0.w,
      color:Colors.white,
      child:Row(
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context)=> Login()
                )
              );
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
                    size: ResponsiveFlutter.of(context).fontSize(2.7),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Color(0xff1ba6d2),
            onPressed: (){
              if ( _formKey.currentState.validate() ) {
                showPopTermsConditions(
                context: context,
                funcOkButton:  () async{
                  geoLocation gl = new geoLocation();
                  await gl.obtenerGeolocalizacion();
                  showDialogV2( context: context, builder: (BuildContext context) => CustomDialogLoading());
                  User user = User(
                    email: emailController.text,
                    keyWord: pclaveController.text.trim(),
                    password:  passwordController.text.trim(),
                    phoneNumber: telefonoController.text,
                    publicName: publicNameController.text.trim(),
                    referenceCodeWoiner: codigoController.text == null
                      ? ""
                      : codigoController.text.trim(),
                    serviceBool: false,
                    typeVehicleId: 0,
                    username: usernameController.text.trim(),
                    woinerType: cliWoinSelected == true ? 0 : 1,
                    device: gl.getDevices,
                    woinLocation: gl.getLocation,
                    category: cliWoinSelected == false ?  comercialActivity : null
                  );
                  userService.registrarUsuario(user: user, context: context, device:gl.getDevices, location: gl.getLocation );
                }
              );
              }else {
                setState(() {
                  heigthUserInfo =51.0.h;
                  heigthPassword = 66.0.h;
                  heigthProfileType = cliWoinSelected == true ? 63.0.h : 77.0.h;
                }); 
                showAlerts(context,"Por favor, revise los campos...", false,closeModal, null,"Aceptar", "", null);
              }
              //_inputController.clear();
              //_outputController.clear();
              //codigoController.clear();
              //publicNameController.clear();
              //usernameController.clear();
              //passwordController.clear();
              //confirmpasswordController.clear();
              //telefonoController.clear();
              //emailController.clear();
              //confirmEmailController.clear();
              //pclaveController.clear();
              //pclaveconfirmController.clear();
            }
          ),
        ],
      ),
    );
  }

  TextFormField textFieldKeyWord(BuildContext context) {
    return TextFormField(
      validator: (val) {
        setState(() {
          errcPClave= 1;
        });
        if (val.length < 1) {
          return "Ingresar una palabra clave";
        }
        return null;
      },
      onChanged: (String value){
        _keypclaveController.currentState.validate();
      },
      key: _keypclaveController,
      maxLength: 50,
      maxLines: 1,
      controller: pclaveController,
      style: TextStyle(
        color: Colors.black,
        fontSize: 11.0.sp
      ),
      keyboardType: TextInputType.text,
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.help,
            size: 14.0.sp,
            color: Colors.grey[400],
          ),
          onPressed: (){
            showgeneralDialogRegister(
              context: context,
              title: "Escriba una palabra clave",
              buttonText: "Ok" ,
              popContent: "Cuando no recuerde su usuario y/o contraseña, la palabra clave le ayudará a recuperar sus credenciales ",
              onPressed: (){
                Navigator.of(context).pop();
              }
            );
          },
        ), 
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorStyle: TextStyle(
          fontSize: 8.0.sp
        ),
        contentPadding: EdgeInsets.all(10),
        labelText: "Escribe una palabra clave",
        labelStyle: TextStyle(color: Color(0xfc979797)),
        enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  TextFormField _textFieldEmail(BuildContext context) {
    return TextFormField(
      validator: (val) {
        bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val);
        if (!emailValid) {
          return "Correo incorrecto";
        } else {
          return null;
        }
      },
      key: _keyemailController,
      onChanged: (String value){
        _keyemailController.currentState.validate();
      },
      maxLength: 80,
      maxLines: 1,
      controller: emailController,
      style: TextStyle( 
        color:Colors.black,
        fontSize:11.0.sp
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.email, color:Colors.white, size:14.0.sp),
        counterText: "",
        isDense: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: Colors.red[600]
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorStyle: TextStyle( fontSize:8.0.sp),
        contentPadding: EdgeInsets.all(10),
        labelText: "Correo electrónico",
        labelStyle: TextStyle(color: Color(0xfc979797)),
        enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  TextFormField _textFieldConfirmEmail(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if(val.length < 1){
          return "Correo incorrecto";
        }
        if (emailController.text != val ) {
          return "El correo no coincide";
        } else {
          return null;
        }
      },
      key: _keyConfirmEmailController,
      onChanged: (String value){
        _keyConfirmEmailController.currentState.validate();
      },
      maxLength: 80,
      maxLines: 1,
      controller: confirmEmailController,
      style: TextStyle( 
        color: Colors.black,
        fontSize:11.0.sp
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.email, color:Colors.white, size:14.0.sp),
        counterText: "",
        isDense: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: Colors.red[600]
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorStyle: TextStyle( fontSize:8.0.sp),
        contentPadding: EdgeInsets.all(10),
        labelText: "Confirmar Correo electrónico",
        labelStyle: TextStyle(color: Color(0xfc979797)),
        enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  TextFormField _textFieldPhoneNumber(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val.length < 10) {
          return "telefono mínimo con 10 dígitos";
        }
        return null;
      },
      key: _keytelefonoController,
      onChanged: (String value){
        _keytelefonoController.currentState.validate();
      },
      maxLength: 17,
      maxLines: 1,
      controller: telefonoController,
      style: TextStyle( 
        color: Colors.black,
        fontSize: 11.0.sp
      ),
      keyboardType: TextInputType.number,
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        suffixIcon: Icon(Icons.phone, size:14.0.sp, color:Colors.white),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0)
          ),
          borderSide: BorderSide(
            color: Colors.red[600]
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0)
          ),
          borderSide: BorderSide(
            color: Colors.red[600]
          )
        ),
        alignLabelWithHint: false,
        errorStyle: TextStyle(fontSize:8.0.sp),
        contentPadding: EdgeInsets.all(10),
        labelText: "Número de teléfono móvil",
        labelStyle: TextStyle(
            color: Color(0xfc979797)),
        enabledBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all( Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  TextFormField _textFieldConfirmPassword(BuildContext context) {
    return TextFormField(
      obscuringCharacter: "*",
      validator: (val) {
        setState(() {
          errorConfim = 1;
        });
        if (val.length < 1) {
          return "Debe ingresar una contraseña";
        }
        if (val != passwordController.text) {
          return "Contraseñas no coinciden";
        }
        return null;
      },
      key: _keyconfirmpasswordController,
      onChanged: (String value){
        _keyconfirmpasswordController.currentState.validate();
      },
      maxLength: 15,
      controller:
      confirmpasswordController,
      style: TextStyle( 
        color: Colors.black,
        fontSize:11.0.sp
      ),
      keyboardType: TextInputType.text,
      autocorrect: true,
      autofocus: false,
      obscureText: visibleconfirm == 0
        ? true
        : false,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              visibleconfirm == 1
                ? visibleconfirm = 0
                : visibleconfirm = 1;
            });
          },
          icon: Icon(
            visibleconfirm == 0
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey[300],
            size: 14.0.sp,
          ),
        ),
        suffixStyle: TextStyle(fontSize: 0),
        isDense: true,
        labelText: "Confirmar contraseña",
        counterText: "",
        focusedErrorBorder:
        OutlineInputBorder(
            borderRadius:
            BorderRadius.all(
                Radius.circular(
                    5.0)),
            borderSide:
            BorderSide(
                color: Colors
                      .red[600])
            // borderSide: new BorderSide(color: Colors.teal)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(
                Radius.circular(
                    5.0)),
            borderSide: BorderSide(
                color: Colors.red[600])
          // borderSide: new BorderSide(color: Colors.teal)
        ),
        errorStyle:
        TextStyle(fontSize: 8.0.sp),
        contentPadding:
        EdgeInsets.all(10),
        // fillColor: Colors.white,
        labelStyle: TextStyle(
            color: Color(0xfc979797)),
        enabledBorder:
        new OutlineInputBorder(
            borderRadius:
            BorderRadius.all(
                Radius.circular(
                    5.0)),
            borderSide: BorderSide(
                color: Colors
                    .grey[300])
          // borderSide: new BorderSide(color: Colors.teal)
        ),
        focusedBorder:
        new OutlineInputBorder(
            borderRadius:
            BorderRadius.all(
                Radius.circular(
                    5.0)),
            borderSide: BorderSide(
                color: Colors
                    .grey[500])
          // borderSide: new BorderSide(color: Colors.teal)
        ),
        // labelText: 'Correo'
      ),
    );
  }

  TextFormField _textFieldPassword(BuildContext context) {
    return TextFormField(
      obscuringCharacter: "*",
      validator: (val) {
        bool emailValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$")
            .hasMatch(val);
        if (!emailValid) {
          return "Debe contener mayúsculas minúsculas y números";
        } else {
          return null;
        }
      },
      onChanged: (String value){
        paswword = value;
        _keypasswordController.currentState.validate();
      },
      key: _keypasswordController,
      maxLength: 15,
      controller: passwordController,
      style: TextStyle(
        color: Colors.black,
        fontSize: 11.0.sp
      ),
      keyboardType: TextInputType.text,
      autocorrect: true,
      autofocus: false,
      obscureText:
      vpassword == 0 ? true : false,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              vpassword == 1
                  ? vpassword = 0
                  : vpassword = 1;
            });
          },
          icon: Icon(
            vpassword == 0
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey[300],
            size: 14.0.sp,
          ),
        ),
        suffixStyle:
        TextStyle(fontSize: 0),
        isDense: true,
        counterText: "",
        labelText: "Contraseña alfanumérica",
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all( Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorStyle:TextStyle(fontSize: 8.0.sp),
        contentPadding:EdgeInsets.all(10),
        labelStyle: TextStyle( color: Color(0xfc979797)),
        enabledBorder:new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.grey[300])
        ),
        focusedBorder:new OutlineInputBorder( 
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Crear cuenta",
        style: TextStyle(color: Color(0xff1ba6d2),fontSize: 17),
      ),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(
          Icons.chevron_left,
          size: 35,
          color: Colors.grey[400],
        ),
        alignment: Alignment.centerLeft,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  TextFormField _textFieldUserName(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val.length < 4) {
          return "Cedula, Nit ó Rut mínimo con 4 caracteres";
        }
        if (val.length >12) {
          return "Cedula, Nit ó Rut  máximo con 12 caracteres";
        }
        return null;
      },
      key: _keyusernameController,
      onChanged: (String value){
        _keyusernameController.currentState.validate();
      },
      maxLength: 12,
      maxLines: 1,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(r"\s")
        )
      ],
      controller: usernameController,
      style: TextStyle(
        color: Colors.black,
        fontSize: 11.0.sp
      ),
      keyboardType: TextInputType.number,
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        suffixIcon: Icon(Icons.person, color:Colors.white, size: 14.0.sp),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all( Radius.circular(5.0)),
            borderSide: BorderSide( color: Colors.red[600])
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
            borderSide: BorderSide( color: Colors.red[600])
        ),
        errorStyle: TextStyle(fontSize: 8.0.sp),
        contentPadding: EdgeInsets.all(10),
        labelText: "Cedula de ciudadanía, Nit o RUT",
        labelStyle: TextStyle(color: Color(0xfc979797)),
        enabledBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all( Radius.circular(5.0)),
          borderSide: BorderSide( color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all( Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  TextFormField _textFieldReferredCode(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val.length > 0 &&val.length < 8) {
          return "Código mínimo con 8 dígitos";
        }
        return null;
      },
      key: _keycodigoController,
      maxLength: 12,
      maxLines: 1,
      controller: codigoController,
      onChanged: (String value){
        _keycodigoController.currentState.validate();
      },
      style: TextStyle( color: Colors.black,fontSize: 11.0.sp),
        keyboardType: TextInputType.number,
        autocorrect: true,
        autofocus: false,
        decoration: InputDecoration(
          counterText: "",
          labelText: "Código de referido (opcional)",
          isDense: true,
          //suffixIcon: IconButton(
          //  icon: Icon(Icons.help, size: 14.0.sp ),
          //  color: Colors.grey[400],
          //  onPressed: (){
          //    showgeneralDialogRegister(
          //      context: context,
          //      title: "Código de referido(Opcional)",
          //      buttonText: "Aceptar",
          //      onPressed:(){
          //        Navigator.of(context).pop();
          //      },
          //      popContent: "Cuando registra el código de referido ó código QR del usuario que lo invita, usted ingresa como miembro de la red de ese usuario. "
          //    );
          //  },
          //),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)),
              borderSide: BorderSide(
                  color: Colors.red[600])
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)),
              borderSide: BorderSide(
                  color: Colors.red[600])
          ),
          errorStyle: TextStyle(
              fontSize: 8.0.sp),
          contentPadding: EdgeInsets.all(10),
          labelStyle: TextStyle(
              color: Color(0xfc979797)),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(5.0)),
            borderSide: BorderSide(
                color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(5.0)),
            borderSide: BorderSide(
                color: Colors.grey[500])
        ),
      ),
    );
  }


  showScanQRDialog({context, String content, String title}){
    TextStyle style = TextStyle(fontSize:12.0.sp, color:Colors.white);
    showGeneralDialog(
      context: context, 
      pageBuilder: (_, __, ___)=> AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        content: Container(
          width: 80.0.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.w),
                child: Text(
                  title, 
                  style:TextStyle(fontSize:18.0, color:Colors.grey, fontFamily: "Roboto-bold"), 
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0.w),
                child: Text(
                  content, 
                  style:TextStyle(fontSize:16.0, color:Colors.grey, fontFamily: "Roboto-ligth" ), 
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _cardScanQR(
                    "Escanear QR", 
                    (){
                      Navigator.of(context).pop();
                      _scan();
                    }, 
                    Icon(Icons.center_focus_strong_outlined, size: 35.0.sp, color: cliWoinSelected == true ? Color(0xff1BA6D2) : Color(0xffD2A409) ),
                  ),
                  _cardScanQR(
                    "Seleccionar QR", 
                    (){
                      Navigator.of(context).pop();
                      _scanPhoto();
                    }, 
                    Icon(Icons.image, size: 35.0.sp, color: cliWoinSelected == true ? Color(0xff1BA6D2) : Color(0xffD2A409)),
                  )
                ],
              ),
              SizedBox(height: 2.0.h),
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 20.0.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, color: Colors.white ),
                      Text(" Cerrar", style:style),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                color:  cliWoinSelected == true ? Color(0xff1BA6D2) : Color(0xffD2A409) ,
              )
            ],
          ),
        ) ,
      )
    ); 
  }

  Container _cardScanQR(String title, Function onPressed, Widget icon) {
    return Container(
      height: 12.0.h,
      width: 33.0.w,
      child: InkWell(
        onTap:onPressed ,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(title, style: TextStyle(fontSize:12.0.sp, color:Colors.grey))

            ],
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        this.codigoController.text = barcode;
      });
    }
  }

  Future _scanPhoto() async {
    await Permission.storage.request();
    String barcode = await scanner.scanPhoto();
    setState(() {
      this.codigoController.text = barcode;
    });
  }


}