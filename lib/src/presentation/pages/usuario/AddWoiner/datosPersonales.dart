import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sizer/sizer.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Persons/gender.dart';
import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/genderPerson.dart';

class DatosPersonaleswoiner extends StatefulWidget {
  @override
  _DatosPersonaleswoinerState createState() => _DatosPersonaleswoinerState();
}

class _DatosPersonaleswoinerState extends State<DatosPersonaleswoiner> {
  DateTime fechaNacimiento;
  genero gender;
  int validformgen = 0;
  int validformfec = 0;
  int visibletec = 0;
  var myFormat = new DateFormat('yyyy-MM-dd');
  final _formKey = GlobalKey<FormState>();
  TextEditingController papellidoController = new TextEditingController();
  TextEditingController sapellidoController = new TextEditingController();
  TextEditingController pnombreController = new TextEditingController();
  TextEditingController snombreController = new TextEditingController();
  int errfecha = 0;
  int errgenero = 0;

  // Navigator.of(context).pop();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          visible ? visibletec = 1 : visibletec = 0;
          print(visibletec);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "UserData",
      child: Scaffold(
        appBar: _appBar(context),
        backgroundColor: Colors.grey[300],
        body: _body(context),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      height: 90.0.h,
      width: 100.0.w,
      child: Stack(
        children: <Widget>[
          _formUpdateProfile(context),
          Positioned(
            bottom: 0.0,
            child: _continueAndCancelButtons(context)
          ),
        ],
      ),
    );
  }

  Container _continueAndCancelButtons(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 8.0.h,
      width: 100.0.w,
      child: Row(
        children: <Widget>[
          Padding(
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
          Expanded(child: Container()),
          Padding(
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
                  if (fechaNacimiento == null) {
                    setState(() {
                      errfecha = 1;
                      validformfec++;
                    });
                  } else {
                    setState(() {
                      errfecha = 0;
                      if (validformfec > 0) {
                        validformfec--;
                      }
                    });
                  }
                  if (gender == null) {
                    print("Entro gen");
                    setState(() {
                      errgenero = 1;
                      validformgen++;
                    });
                  } else {
                    setState(() {
                      errgenero = 0;
                      if (validformgen > 0) {
                        validformgen--;
                      }
                    });
                  }
                  //if (_formKey.currentState.validate() &&
                  //    validformgen == 0 &&
                  //    validformfec == 0) {
                  //  print("TODO BIEN");
                  //  nameForm nameuser = new nameForm(
                  //      fechaNacimiento:
                  //          myFormat.format(fechaNacimiento),
                  //      gender: gender,
                  //      primerApellido: toBeginningOfSentenceCase(
                  //          papellidoController.text),
                  //      primerNombre: toBeginningOfSentenceCase(
                  //          pnombreController.text),
                  //      segundoApellido: toBeginningOfSentenceCase(
                  //          sapellidoController.text),
                  //      segundoNombre: toBeginningOfSentenceCase(
                  //          snombreController.text));
                  //  Navigator.of(context).pop(nameuser);
                  //} else {
                  //  print("Errores");
                  //}
                  // Navigator.of(context).pop(imgFile);
                }
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                ),
          ),
        ],
      ),
    );
  }

  Padding _formUpdateProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 2.0.w,
        vertical: 1.5.h
      ),
      child: Container(
        height: 63.0.h,
        child: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: EdgeInsets.only(
                top: 2.0.h,
                bottom: 3.0.h
              ),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _titleTextFIelds("Primer apellido *"),
                  _fitstLastNameTextField(),
                  _titleTextFIelds("Segundo apellido *"),
                  _scondLastNameTextField(context),
                  _titleTextFIelds("Primer nombre  *"),
                  _firstNameTetField(context),
                  _titleTextFIelds("Segundo nombre *"),
                  _secondNameTextField(context),
                  _birthdayDate(context),
                  _genderSelector(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _genderSelector(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.0.w,
        vertical: .0.h
      ),
      child: SizedBox(
        // height:  ResponsiveFlutter.of(context).hp(5),
        child: RaisedButton(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 10, right: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: <Widget>[
                  Text(
                    gender == null
                        ? "Género *"
                        : gender.name,
                    style: TextStyle(
                        fontSize:
                            MediaQuery.of(context)
                                    .size
                                    .height *
                                0.018,
                        color: Color(0xfc979797),
                        fontFamily: "Roboto",
                        fontWeight:
                            FontWeight.w400),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xff757575),
                    size: 18,
                  )
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30),
                side: BorderSide(
                    color: errgenero == 0
                        ? Color(0xffd3d7db)
                        : Colors.red[600])),
            padding: EdgeInsets.all(4),
            color: Colors.white,
            elevation: 0,
            onPressed: () async {
              final gen = await showDialogGender(
                  context, gender);
              if (gen != null) {
                setState(() {
                  gender = gen;
                });
              }
            }),
      ),
    );
  }

  Padding _birthdayDate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left:3.0.w,
        right:3.0.w,
        top: 1.0.h
      ),
      child: SizedBox(
        //height:ResponsiveFlutter.of(context).hp(5),
        child: RaisedButton(
          child: Padding(
            padding: EdgeInsets.only(
                left: 10, right: 10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  fechaNacimiento == null
                      ? "Fecha de nacimiento *"
                      : myFormat.format(
                          fechaNacimiento),
                  style: TextStyle(
                      fontSize:
                          MediaQuery.of(context)
                                  .size
                                  .height *
                              0.018,
                      color: Color(0xfc979797),
                      fontFamily: "Roboto",
                      fontWeight:
                          FontWeight.w400),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff757575),
                  size: 18,
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(30),
              side: BorderSide(
                  color: errfecha == 0
                      ? Color(0xffd3d7db)
                      : Colors.red[600])),
          padding: EdgeInsets.all(4),
          color: Colors.white,
          elevation: 0,
          onPressed: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1920),
                    lastDate: DateTime(2022))
                .then((date) {
              if (date != null) {
                setState(() {
                  fechaNacimiento = date;
                });
              }
            });
          },
        ),
      ),
    );
  }

  Padding _secondNameTextField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:3.0.w,
        vertical: 0
      ),
      child: SizedBox(
        // height: ResponsiveFlutter.of(context).hp(5),
        child: TextFormField(
          maxLength: 15,
          validator: (val) {
            if (val.length > 0 &&
                val.length < 3) {
              return "Nombre incorrecto (min= 3 letras)";
            } else {
              return null;
            }
          },
          controller: snombreController,
          style: TextStyle(
              color: Color(0xfc979797),
              fontSize: MediaQuery.of(context)
                      .size
                      .height *
                  0.018),
          keyboardType: TextInputType.text,
          autocorrect: true,
          autofocus: false,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.red[600])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.red[600])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            errorStyle: TextStyle(
              fontSize:
                  ResponsiveFlutter.of(context)
                      .fontSize(1.5),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText:
                "Segundo nombre del usuario",
            // fillColor: Colors.white,
            labelStyle: TextStyle(
                color: Color(0xfc979797)),
            enabledBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.grey[300])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.grey[500])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            // labelText: 'Correo'
          ),
        ),
      ),
    );
  }

  Padding _firstNameTetField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:3.0.w,
        vertical:0
      ),
      child: SizedBox(
        // height: ResponsiveFlutter.of(context)                                         .hp(5),
        child: TextFormField(
          maxLength: 15,
          validator: (val) {
            if (val.length < 3) {
              return "Nombre incorrecto (min= 3 letras)";
            } else {
              return null;
            }
          },
          controller: pnombreController,
          style: TextStyle(
              color: Color(0xfc979797),
              fontSize: MediaQuery.of(context)
                      .size
                      .height *
                  0.018),
          keyboardType: TextInputType.text,
          autocorrect: true,
          autofocus: false,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.red[600])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.red[600])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            errorStyle: TextStyle(
              fontSize:
                  ResponsiveFlutter.of(context)
                      .fontSize(1.5),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: "primer nombre del usuario",
            // fillColor: Colors.white,
            labelStyle: TextStyle(
                color: Color(0xfc979797)),
            enabledBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.grey[300])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.grey[500])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            // labelText: 'Correo'
          ),
        ),
      ),
    );
  }

  Padding _scondLastNameTextField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:3.0.w,
        vertical: 0
      ),
      child: SizedBox(
        // height: ResponsiveFlutter.of(context)                            .hp(5),
        child: TextFormField(
          maxLength: 15,
          validator: (val) {
            if (val.length < 3) {
              return "Apellido incorrecto (min= 3 letras)";
            } else {
              return null;
            }
          },
          controller: sapellidoController,
          style: TextStyle(
              color: Color(0xfc979797),
              fontSize: MediaQuery.of(context)
                      .size
                      .height *
                  0.018),
          keyboardType: TextInputType.text,
          autocorrect: true,
          autofocus: false,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.red[600])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.red[600])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            errorStyle: TextStyle(
              fontSize:
                  ResponsiveFlutter.of(context)
                      .fontSize(1.5),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText:
                "Segundo apellido del usuario",
            // fillColor: Colors.white,
            labelStyle: TextStyle(
                color: Color(0xfc979797)),
            enabledBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.grey[300])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Colors.grey[500])
                // borderSide: new BorderSide(color: Colors.teal)
                ),
            // labelText: 'Correo'
          ),
        ),
      ),
    );
  }

  Padding _titleTextFIelds(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:6.0.w,
        vertical: 1.5.h
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey[700]),
      )
    );
  }

  Padding _fitstLastNameTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:3.0.w,vertical: 0),
      child: TextFormField(
        maxLength: 15,
        validator: (val) {
          if (val.length < 3) {
            return "Apellido incorrecto (min= 3 letras)";
          } else {
            return null;
          }
        },
        controller: papellidoController,
        style: TextStyle(
          color: Color(0xfc979797),
          fontSize:11.0.sp
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        autofocus: false,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.red[600])
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.red[600])
          ),
          errorStyle: TextStyle(
            fontSize:8.0.sp
          ),
          contentPadding: EdgeInsets.all(10),
          hintText:
            "Primer apellido del usuario",
          labelStyle: TextStyle(color: Color(0xfc979797)),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.grey[300])
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.grey[500])
          ),
        ),
      ), 
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Datos de Usuario",
        style: TextStyle(color: Color(0xff1ba6d2)),
      ),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.dashboard,
            size: 30,
            color: Colors.grey[400],
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
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
}
