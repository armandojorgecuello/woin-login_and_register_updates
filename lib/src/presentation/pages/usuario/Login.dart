import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/main.dart';
import 'package:woin/src/models/response_htttp_get.dart';
import 'package:woin/src/models/user_detail.dart';

import 'package:woin/src/models/user_login.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/tab-principal/home_page.dart';

import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/presentation/pages/usuario/recoveryPassword/RecoverPassword.dart';
import 'package:woin/src/providers/login_provider.dart';

import 'package:woin/src/services/SesionPersistence/db_SQLite.dart';
import 'package:woin/src/providers/user_service.dart';

import 'codeActivacion.dart';
import 'register_user/user_register.dart';


class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  USerProviderDB _db;
  int vista = 1;

  Future<int> loguearseAutomatic(String user, String password, BuildContext context) async {
    geoLocation gl = new geoLocation();
    await gl.obtenerGeolocalizacion();

    UserLoguin ul = new UserLoguin(
      device: gl.getDevices,
      woinLocation: gl.getLocation,
      password: password,
      username: user,
      code: 0
    );
    RespUserLoguin resp = await userService.loguin(ul, context);
  }

  @override
  void initState() {
    super.initState();

    _db = USerProviderDB();
  }

  Future<int> isLogin() async {
    userdetalle sesion = userdetalle();
    if (sesion.getSession == null) {
      UserSQLite user = await _db.getUserLogueado();
      if (user != null) {
        var resp=await loguearseAutomatic(user.username, user.password, context);
        return resp;
      } else {
        return 0;
      }
    } else {
      return 2;
    }
  }

  Widget pageLoguin(BuildContext context1) {

    return FutureBuilder(
      future: _db.getUserLogueado(),
      builder: (BuildContext context, AsyncSnapshot<UserSQLite> snapshot) {
        // print("DATO=>" + snapshot.data.id.toString());
        if (snapshot.data == null) {
          return loginPage(db: _db,);
        } else {
          return sinInternet();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: isLogin(),
      builder: (BuildContext context2, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data==-1){
            return sinInternet();
          }
          if (snapshot.data == 1) {
            return TabMain();
          } else if (snapshot.data == 2) {
            return TabMain();
          } else {
            return pageLoguin(context);
          }
        }
          return WoinLoading();
      },
    ); 
  }
}

class loginPage extends StatefulWidget {
  USerProviderDB db;
  loginPage({this.db});

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  //int visiblec = 1;
  bool togglevalue = false;
  int visiblepass = 0;

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormFieldState> _user = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _password = GlobalKey<FormFieldState>();

  //UserLoguin ulg;

  @override
  void initState() {
    super.initState();

    usernameController.clear();
    passwordController.clear();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      setState(() {});
    });
  }

  closeModal() {
    Navigator.of(context).pop(1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () { 
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.0.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 8.0.h,),
                    _logoAndSloganWoin(context),
                    SizedBox(
                      height:6.0.h,
                    ),
                    _userTextField(context),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    _passwordTextField(context),
                    SizedBox(height: 2.0.h),
                    _recoveryPassword(context),
                    SizedBox( height: 2.0.h,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * .92,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _visitantButton(context),
                          SizedBox(width:3.0.w),
                          _loginButton(context)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    _fingerPrintButton(context),
                    SizedBox(
                      height: 8.0.h,
                    ),
                    SizedBox(height: 2.0.h,),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(60),
                      child: Container(
                        //color: Colors.black12,
                        padding: EdgeInsets.only(
                            top: ResponsiveFlutter.of(context).moderateScale(8)),
                        child: _signInButton(context),
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextButton _signInButton(BuildContext context) {
    return TextButton(
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder:(context) => mainRegisterUser()));
      },
      child: Container(
        height: 6.0.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No tienes una cuenta?",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: ResponsiveFlutter.of(context)
                      .fontSize(1.8)),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              child: Text(
                "Regístrese",
                style: TextStyle(
                    color: Color(0xff1ba6d2),
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context)
                        .fontSize(1.8)),
              ),
              onTap: () => {
                Navigator.push(context,MaterialPageRoute(builder:(context) => mainRegisterUser()))
              },
            )
          ],
        ),
      ),
    );
  }

  Container _fingerPrintButton(BuildContext context) {
    return Container(
      height:10.0.h,
      width:40.0.w,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.fingerprint,
          size: 12.0.h,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Container _loginButton(context){
    return Container(
      width: 43.0.w,
      child: RaisedButton(
        elevation: 0,
        child: Text(
          'Iniciar sesión',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Roboto",
            color: Colors.white,
            fontSize: 11.0.sp,
          ),
        ),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
        color: Color(0xff1ba6d2),
        onPressed: () async {
          String username = usernameController.text.toString();
          String password = passwordController.text.toString();
          if (username != "" && password != "") {
            showDialogV2(
              context: context,
              builder: (BuildContext context) =>CustomDialogLoading()
            );
            geoLocation gl = new geoLocation();
            await gl.obtenerGeolocalizacion();
            UserLoguin userLogin = new UserLoguin(
              device: gl.getDevices,
              woinLocation: gl.getLocation,
              password: password,
              username: username,
              code: 0
            );
            //ulg = userLogin;
            RespUserLoguin resp = await userService.loguin(userLogin, context);
            if(resp.status == true){
              List<UserDetailResponse> _userDetail = List();
              resp.entities.forEach((userDetail) async{ 
                final temporalUserDetail = UserDetailResponse.fromJson(userDetail);
                Provider.of<LoginProvider>(context, listen:false).userDetail = temporalUserDetail;
                print(userDetail);
                _userDetail.add(temporalUserDetail);
              });
              Navigator.of(context).pop();
              _userDetail.forEach((UserDetailResponse element) { 
                if(element.state == 2){
                  showAlerts(
                    context,
                    resp.message, 
                    false,
                    null,
                    navigateToActivateAccount(password, username, gl),
                    "Ingresar Código", 
                    "", 
                    null
                  );
                }else{
                  Provider.of<LoginProvider>(context, listen:false).userLogin = userLogin;
                  Provider.of<LoginProvider>(context, listen:false).isLogin = true;
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> FirstPage()));
                }
              });
            }else{
              Navigator.of(context).pop();
              showAlerts(context,resp.message, false,closeModal, null,"Aceptar", "", null);
            }
          }
        },
      ),
    );
  }

  navigateToActivateAccount(String password, String username, geoLocation gl){
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) =>  CodeActivacion(
        pageTitle: "Activar Cuenta",
        device:  gl.getDevices,
        location:  gl.getLocation,
        //user: user,
        password: password,
        userName: username,
      )
    ));
  }

  
 
  Container _visitantButton(BuildContext context) {
    return Container(
      width: 43.0.w,
      child: RaisedButton(
        child: Text(
          'Visitante',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Roboto",
            color: Color(0xff1ba6d2),
            fontSize: 11.0.sp,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Color(0xff1ba6d2))
        ),
        color: Colors.white,
        elevation: 0,
        onPressed: () async{
          geoLocation gl = new geoLocation();
          await gl.obtenerGeolocalizacion();
          UserLoguin userLogin = new UserLoguin(
            device: gl.getDevices,
            woinLocation: gl.getLocation,
            password: "",
            username: "",
            code: 0
          );
          Provider.of<LoginProvider>(context, listen:false).userLogin = userLogin;
          UserDetailResponse visitant = UserDetailResponse(
            id : 0,
            username : null,
            email : "",
            token : "",
            refreshToken: "",
            state: null,
            roleId: null,
            createdAt: null,
            updatedAt:null ,
            type: "" ,
            code: null,
            number: "",
            woinerType: [],
            lastConnection: "",
            person: "",
            residences:[] ,
            typeDefault: 0 ,
            typeDefaultName: "" ,
            image: "",
          );
          Provider.of<LoginProvider>(context, listen:false).userDetail = visitant;
          //userdetalle sesion = new userdetalle();
          //sesion.setSesion = new UserDetailResponse();
          //sesion.setPersonWoiner = null;
          //sesion.setWoinerType = [];
          //sesion.setCuentaActiva = 0;
          //sesion.setImageCli = "";
          //sesion.setImageEm = "";
          //sesion.setPassword = "";
          //sesion.setSesion1 = null;
          //sesion.setSesion2 = null;
          //sesion.setTokenCli = "";
          //sesion.setTokenEm = "";
          //sesion.setTokenUser = "";
          //sesion.visitante = 1;
          //tipoUser.userSesionGSink.add(sesion);
          Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
        }
      ),
    );
  }

  Row _recoveryPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>RecoverPassword())
          );
          },
          child: Text(
            "Olvidó su contraseña?",
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize:12.0.sp
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
      ],
    );
  }

  TextFormField _passwordTextField(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      style: TextStyle( color: Colors.grey[600], fontSize: 12.0.sp),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: true,
      autofocus: false,
      validator: (val) {
        bool emailValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$")
            .hasMatch(val);
        if (!emailValid) {
          return "Debe contener mayúsculas minúsculas y números";
        } else {
          return null;
        }
      },
      key: _password,
      onChanged: (String value){
        _password.currentState.validate();
      },
      obscureText: visiblepass == 1 ? false : true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              visiblepass == 1
                ? visiblepass = 0
                : visiblepass = 1;
            });
          },
          child: Icon(
            visiblepass == 0
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey[400],
            size: MediaQuery.of(context).size.height * 0.034,
          ),
        ),
        prefixIcon:
          Icon(Icons.lock_outline, color: Colors.grey[500]),
        labelText: 'Contraseña',
        labelStyle: TextStyle( color: Colors.grey[400], fontSize: 12.0.sp),
        enabledBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.grey[400]
          ),
        ),
        focusedBorder: new UnderlineInputBorder(
          borderSide: new BorderSide( color: Colors.grey[600]),
        ),
      ),
    );
  }

  Container _userTextField(BuildContext context) {
    return Container(
      width: 100.0.w,
      child: TextFormField(
        controller: usernameController,
        validator: (val) {
        if (val.length < 8) {
          return "Cedula, Nit ó Rut mínimo con 8 caracteres";
        }
        if (val.length >12) {
          return "Cedula, Nit ó Rut  máximo con 12 caracteres";
        }
        return null;
      },
      key: _user,
      onChanged: (String value){
        _user.currentState.validate();
      },
        style: TextStyle( color: Colors.grey[600], fontSize: 12.0.sp),
        keyboardType: TextInputType.number,
        autocorrect: true,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          prefixIcon: Icon(Icons.person_outline, color: Colors.grey[500]),
          labelText: 'Cedula de ciudadanía, Nit ó Rut',
          labelStyle: TextStyle( color: Colors.grey[400], fontSize: 12.0.sp),
          enabledBorder: new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.grey[400]),),
          focusedBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }

  Row _logoAndSloganWoin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/LOGO_WOIN_DEF.png',
          height: 25.0.w,
          width: 25.0.w,
        ),
        SizedBox(width:5.0.w ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Woin",
              style: TextStyle(
                fontFamily: "Arial-Rounded",
                fontSize:30.0.sp,
                color: Color(0xff1ba6d2),
                fontWeight: FontWeight.bold,
                letterSpacing: 1
              ),
            ),
            Text(
              "Suma puntos a tu vida",
              style: TextStyle(
                fontFamily: "Roboto-ligth",
                fontSize: 14.0.sp,
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
                letterSpacing: 1
              ),
            ),
          ],
        )
      ],
    );
  }
}

class WoinLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Woin",style: TextStyle(fontSize:20.0.sp)),
                        Text("Suma puntos a tu vida",style: TextStyle(color: Colors.grey[500],fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveFlutter.of(context).hp(5),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ],
                )
              ],
            ),
          ),
      ),
    );

  }
}

class sinInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
      // title: Text("Woin",style: TextStyle( fontFamily: "Arial-Rounded",   color: Color(0xff1ba6d2),  letterSpacing: .8,   fontWeight: FontWeight.bold,
      // fontSize: 25),),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           SizedBox(
             height: ResponsiveFlutter.of(context).hp(28),
             child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 12),
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Expanded(
                     child: Card(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Icon(Icons.info_outline,size: 75,color: Theme.of(context).accentColor,),
                           Text("Upss.. No tienes conexión a internet",style: TextStyle(color: Colors.grey[500]),textAlign: TextAlign.center,),
                         ],
                       ),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15)
                       ),
                       elevation: 5,
                     ),
                   )
                 ],
               ),
             ),
           ),
            SizedBox(
              height: ResponsiveFlutter.of(context).hp(10),
            )
          ],

        ),
      ),
    );
  }
}


