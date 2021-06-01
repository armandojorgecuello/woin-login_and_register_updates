import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Persons/userViews.dart';

class Contactoswoiner extends StatefulWidget {
  contactoWoiner contacto;
  int typeWoiner;
  Contactoswoiner({this.contacto, this.typeWoiner});
  @override
  _ContactoswoinerState createState() => _ContactoswoinerState();
}

class _ContactoswoinerState extends State<Contactoswoiner> {
  int visibletec = 0;
  final _formKey = GlobalKey<FormState>();
  var myFormat = new DateFormat('yyyy-MM-dd');
  TextEditingController telcontactoController = new TextEditingController();
  TextEditingController whatsappController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController callcenterController = new TextEditingController();
  int errfecha = 0;
  int errgenero = 0;

  // Navigator.of(context).pop();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.contacto != null) {
      if (widget.contacto.telContacto != null) {
        telcontactoController.text = widget.contacto.telContacto;
      }
      if (widget.contacto.whatsapp != null) {
        whatsappController.text = widget.contacto.whatsapp;
      }
      if (widget.contacto.email != null) {
        emailController.text = widget.contacto.email;
      }
      if (widget.contacto.callCenter != null) {
        callcenterController.text = widget.contacto.callCenter;
      }
    }
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
      tag: "contacto",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Contacto y otros",
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
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(
                    top: ResponsiveFlutter.of(context).verticalScale(10),
                    bottom: ResponsiveFlutter.of(context).verticalScale(10)),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveFlutter.of(context).wp(2),
                      vertical: ResponsiveFlutter.of(context).hp(0)),
                  children: <Widget>[
                    Form(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).hp(2),
                              bottom: ResponsiveFlutter.of(context).hp(3)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(6),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(1.5)),
                                      child: Text(
                                        "Telefono de Contacto",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(3),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(0)),
                                      child: SizedBox(
                                        // height: ResponsiveFlutter.of(context)              .hp(8),
                                        child: TextFormField(
                                          maxLength: 10,
                                          validator: (val) {
                                            if (val.length > 0 &&
                                                val.length < 10) {
                                              return "teléfono incorrecto (min= 10 digitos)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: telcontactoController,
                                          style: TextStyle(
                                              color: Color(0xfc979797),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018),
                                          keyboardType: TextInputType.number,
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
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(1.5)),
                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Teléfono de contacto",

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
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(6),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(1.5)),
                                      child: Text(
                                        "Whatsapp",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(3),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(0)),
                                      child: SizedBox(
                                        // height: ResponsiveFlutter.of(context)                            .hp(5),
                                        child: TextFormField(
                                          maxLength: 10,
                                          validator: (val) {
                                            if (val.length > 0 &&
                                                val.length < 10) {
                                              return "Número incorrecto (min= 10 dígitos)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: whatsappController,
                                          style: TextStyle(
                                              color: Color(0xfc979797),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018),
                                          keyboardType: TextInputType.number,
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

                                            hintText: "Número de whatsapp",

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
                                    ),
                                  ),
                                ],
                              ),
                              widget.typeWoiner == 2
                                  ? Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .wp(6),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .hp(1.5)),
                                            child: Text(
                                              "Email de contacto ",
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ))
                                      ],
                                    )
                                  : SizedBox(),
                              widget.typeWoiner == 2
                                  ? Row(
                                      mainAxisSize: MainAxisSize.max,
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
                                                    .hp(0)),
                                            child: SizedBox(
                                              // height: ResponsiveFlutter.of(context)                                         .hp(5),
                                              child: TextFormField(
                                                maxLength: 30,
                                                validator: (val) {
                                                  bool emailValid = RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(val);
                                                  if (val.length > 0 &&
                                                      !emailValid) {
                                                    return "Email incorrecto";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller: emailController,
                                                style: TextStyle(
                                                    color: Color(0xfc979797),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.018),
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
                                                                          50.0)),
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
                                                                  50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.red[600])
                                                      // borderSide: new BorderSide(color: Colors.teal)
                                                      ),
                                                  errorStyle: TextStyle(
                                                    fontSize:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .fontSize(1.5),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),

                                                  hintText: "email de contacto",

                                                  // fillColor: Colors.white,
                                                  labelStyle: TextStyle(
                                                      color: Color(0xfc979797)),
                                                  enabledBorder:
                                                      new OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50.0)),
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
                                                                          50.0)),
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
                                    )
                                  : SizedBox(),
                              widget.typeWoiner == 2
                                  ? Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .wp(6),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .hp(1.5)),
                                            child: Text(
                                              "Número de call center",
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ))
                                      ],
                                    )
                                  : SizedBox(),
                              widget.typeWoiner == 2
                                  ? Row(
                                      mainAxisSize: MainAxisSize.max,
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
                                                    .hp(0)),
                                            child: SizedBox(
                                              // height: ResponsiveFlutter.of(context)                                         .hp(5),
                                              child: TextFormField(
                                                maxLength: 30,
                                                validator: (val) {
                                                  if (val.length > 0 &&
                                                      val.length < 7) {
                                                    return "Call center incorrecto";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller:
                                                    callcenterController,
                                                style: TextStyle(
                                                    color: Color(0xfc979797),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.018),
                                                keyboardType:
                                                    TextInputType.number,
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
                                                                          50.0)),
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
                                                                  50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.red[600])
                                                      // borderSide: new BorderSide(color: Colors.teal)
                                                      ),
                                                  errorStyle: TextStyle(
                                                    fontSize:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .fontSize(1.5),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),

                                                  hintText:
                                                      "Número de call center",

                                                  // fillColor: Colors.white,
                                                  labelStyle: TextStyle(
                                                      color: Color(0xfc979797)),
                                                  enabledBorder:
                                                      new OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50.0)),
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
                                                                          50.0)),
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
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            visibletec == 0
                ? Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                : SizedBox(),
            Expanded(
              flex: visibletec == 0 ? 2 : 3,
              child: Container(
                color: Colors.white,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
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
                              if (_formKey.currentState.validate()) {
                                contactoWoiner contacto;
                                if (emailController.text == "" &&
                                    telcontactoController.text == "" &&
                                    whatsappController.text == "" &&
                                    callcenterController.text == "") {
                                  contacto = null;
                                } else {
                                  contacto = new contactoWoiner(
                                      callCenter: callcenterController.text,
                                      email: emailController.text,
                                      telContacto: telcontactoController.text,
                                      whatsapp: whatsappController.text);
                                }

                                Navigator.of(context).pop(contacto);
                              } else {
                                print("Errores");
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
            ),
          ],
        ),
      ),
    );
  }
}
