import 'package:flutter/material.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/users/SecurityPassword/PasswordSecurity.dart';
import 'package:woin/src/services/serviceSplash/ServiceSplash.dart';


class SecurityValidation extends StatefulWidget {
  DatosVSeguridad datosVSeguridad;

  SecurityValidation({Key key}) : super(key: key);

  @override
  _SecurityValidationState createState() => _SecurityValidationState();
}

class _SecurityValidationState extends State<SecurityValidation> {
  int validDatosTitular = 1;
  int validDatosCuenta = 1;
  int validDatosEntidadBancaria = 1;
  int errorpassword = 0;
  int errorConfim = 0;
  int vpassword = 0;
  int visibleconfirm = 0;

  final _formKey = GlobalKey<FormState>();
  final _formNewPassKey = GlobalKey<FormState>();
  //bool _autoValidate = true;

  //int visibletec = 0;

  double wCPass = 0.0;
  double hCPass = 0.0;

  TextEditingController _avatarController = new TextEditingController();
  TextEditingController _questionController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmpasswordController =
      new TextEditingController();

  List<DropdownMenuItem> _listAvatars = new List<DropdownMenuItem>();

  int _valorItemAvatar = 1;

  @override
  void initState() {
    super.initState();

    //KeyboardVisibilityNotification().addNewListener(onChange: (bool visible){
    //  setState(() {
    //    visible ? visibletec = 1 : visibletec = 0;
    //    print(visibletec);
    //  });
    //});


    _listAvatars.add(DropdownMenuItem(value: 1, child: Text('Avatar 1')));
    _listAvatars.add(DropdownMenuItem(value: 2, child: Text('Avatar 2')));
    _listAvatars.add(DropdownMenuItem(value: 3, child: Text('Avatar 3')));
    _listAvatars.add(DropdownMenuItem(value: 4, child: Text('Avatar 4')));
    _listAvatars.add(DropdownMenuItem(value: 5, child: Text('Avatar 5')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Validacion de Seguridad",
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
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 18,
            child: Padding(
              padding: EdgeInsets.only(
                  top: ResponsiveFlutter.of(context).verticalScale(10),
                  bottom: ResponsiveFlutter.of(context).verticalScale(10)),
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveFlutter.of(context).wp(2),
                    vertical: ResponsiveFlutter.of(context).hp(0)),
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: ResponsiveFlutter.of(context).hp(2),
                          bottom: ResponsiveFlutter.of(context).hp(3)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0195),
                          AnimatedContainer(

                              duration: Duration(milliseconds: 650),
                              curve: Curves.easeIn,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[

                                    Container(
                                      height: ResponsiveFlutter.of(context).hp(22),
                                      child: Container(
                                          width: ResponsiveFlutter.of(context).wp(35),
                                          height: ResponsiveFlutter.of(context).wp(35),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.grey[300], width: 0.7)
                                          ),
                                          child: Icon(Icons.lock,size: ResponsiveFlutter.of(context).hp(13),color: Colors.green[300],)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                        child: Divider()),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .wp(3),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .hp(1)),
                                            child: Container(
                                              height: ResponsiveFlutter.of(context).verticalScale(36),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey[300],
                                                ),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text("Seleccione su avatar",style: TextStyle(color: Colors.grey[500]),),
                                                  Icon(Icons.chevron_right,color: Colors.grey[500],)
                                                ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .wp(3),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .hp(1)),
                                            child: SizedBox(
                                              // height: ResponsiveFlutter.of(context).verticalScale(48),
                                              child: TextFormField(
                                                validator: (val) {
                                                  if (val.length < 3) {
                                                    return "Respuesta mínimo con 3 caracteres";
                                                  }
                                                  return null;
                                                },
                                                maxLength: 12,
                                                maxLines: 1,
                                                controller: _questionController,
                                                style: TextStyle(
                                                    color: Color(0xfc979797),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.0195),
                                                keyboardType:
                                                    TextInputType.text,
                                                autocorrect: true,
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                  counterText: "",
                                                  isDense: true,
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                                          color:
                                                              Colors.red[600])
                                                      // borderSide: new BorderSide(color: Colors.teal)
                                                      ),
                                                  errorStyle:
                                                      TextStyle(fontSize: 10),
                                                  contentPadding:
                                                      EdgeInsets.all(10),

                                                  hintText:
                                                      "Cual es su mascota favorita ?",

                                                  // fillColor: Colors.white,
                                                  labelStyle: TextStyle(
                                                      color: Color(0xfc979797)),
                                                  enabledBorder:
                                                      new OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      300])
                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                          ),
                                                  focusedBorder:
                                                      new OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      500])
                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                          ),

                                                  // labelText: 'Correo'
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 650),
                            curve: Curves.easeIn,
                            height: hCPass,
                            width: wCPass,
                            child: Form(
                              key: _formNewPassKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    child: Text('Nueva Contraseña',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff1ba6d2))),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  ResponsiveFlutter.of(context)
                                                      .wp(3),
                                              vertical:
                                                  ResponsiveFlutter.of(context)
                                                      .hp(1)),
                                          child: SizedBox(
                                            //height: ResponsiveFlutter.of(context).verticalScale(48),
                                            child: Stack(
                                              alignment: Alignment(
                                                  1,
                                                  errorpassword == 1
                                                      ? -ResponsiveFlutter.of(
                                                              context)
                                                          .hp(0.36)
                                                      : 0.15),
                                              children: <Widget>[
                                                TextFormField(
                                                  obscuringCharacter: "*",
                                                  validator: (val) {
                                                    setState(() {
                                                      errorpassword = 1;
                                                    });
                                                    if (val.length < 8) {
                                                      return "Contraseña mínima de 8 caracteres";
                                                    }

                                                    return null;
                                                  },
                                                  maxLength: 15,
                                                  controller:
                                                      _passwordController,
                                                  style: TextStyle(
                                                      color: Color(0xfc979797),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0195),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  autocorrect: true,
                                                  autofocus: false,
                                                  obscureText: vpassword == 0
                                                      ? true
                                                      : false,
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
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                        color: Colors.grey[300],
                                                        size: ResponsiveFlutter
                                                                .of(context)
                                                            .hp(3),
                                                      ),
                                                    ),
                                                    suffixStyle:
                                                        TextStyle(fontSize: 0),
                                                    isDense: true,

                                                    counterText: "",
                                                    hintText:
                                                        "Ingrese contraseña",

                                                    focusedErrorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.red[600])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.red[600])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),
                                                    errorStyle:
                                                        TextStyle(fontSize: 10),
                                                    contentPadding:
                                                        EdgeInsets.all(10),

                                                    // fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Color(0xfc979797)),
                                                    enabledBorder: new OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey[300])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),
                                                    focusedBorder: new OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey[500])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),

                                                    // labelText: 'Correo'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  ResponsiveFlutter.of(context)
                                                      .wp(3),
                                              vertical:
                                                  ResponsiveFlutter.of(context)
                                                      .hp(1)),
                                          child: SizedBox(
                                            // height: ResponsiveFlutter.of(context).verticalScale(48),
                                            child: Stack(
                                              children: <Widget>[
                                                TextFormField(
                                                  obscuringCharacter: "*",
                                                  validator: (val) {
                                                    setState(() {
                                                      errorConfim = 1;
                                                    });
                                                    if (val.length < 1) {
                                                      return "Debe ingresar una contraseña";
                                                    }
                                                    if (val !=
                                                        _passwordController
                                                            .text) {
                                                      return "Contraseñas no coinciden";
                                                    }
                                                    return null;
                                                  },
                                                  maxLength: 15,
                                                  controller:
                                                      _confirmpasswordController,
                                                  style: TextStyle(
                                                      color: Color(0xfc979797),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0195),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  autocorrect: true,
                                                  autofocus: false,
                                                  obscureText:
                                                      visibleconfirm == 0
                                                          ? true
                                                          : false,
                                                  decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        setState(() {
                                                          visibleconfirm == 1
                                                              ? visibleconfirm =
                                                                  0
                                                              : visibleconfirm =
                                                                  1;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        visibleconfirm == 0
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                        color: Colors.grey[300],
                                                        size: ResponsiveFlutter
                                                                .of(context)
                                                            .hp(3),
                                                      ),
                                                    ),
                                                    suffixStyle:
                                                        TextStyle(fontSize: 0),
                                                    isDense: true,
                                                    hintText:
                                                        "Confirma tu contraseña",

                                                    counterText: "",

                                                    focusedErrorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.red[600])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.red[600])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),
                                                    errorStyle:
                                                        TextStyle(fontSize: 10),
                                                    contentPadding:
                                                        EdgeInsets.all(10),

                                                    // fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Color(0xfc979797)),
                                                    enabledBorder: new OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey[300])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),
                                                    focusedBorder: new OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey[500])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                        ),

                                                    // labelText: 'Correo'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300],width: 1)
                ),
              ),

              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                size: 20,
                                color: Color(0xff1ba6d2),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                'Cancelar',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Color(0xff1ba6d2),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.019),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }

                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.03,
                          left: MediaQuery.of(context).size.width * 0.03),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Siguiente',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.019),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Color(0xff1ba6d2),
                          onPressed: () {
                            if (wCPass == 0.0 &&
                                _formKey.currentState.validate()) {
                              setState(() {
                                wCPass = 350;
                                hCPass = 250;
                              });
                            }
                            if (_formNewPassKey.currentState.validate()) {
                              setState(() {
                                errorConfim = 0;
                                errorpassword = 0;
                              });
                              Navigator.of(context).pop();
                            }
                            // Navigator.of(context).pop(imgFile);
                          }

                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

                          ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
