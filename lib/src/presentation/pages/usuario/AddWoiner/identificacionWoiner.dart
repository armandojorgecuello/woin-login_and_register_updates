import 'package:flutter/material.dart';

import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';

import 'package:woin/src/entities/Persons/typeDocument.dart';
import 'package:woin/src/entities/Persons/userViews.dart';

import 'package:woin/src/presentation/pages/Personalizados_Widgets/typeDocument.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/ubicacion.dart';

class Identificacionwoiner extends StatefulWidget {
  typeAndDocument identificacion;

  Identificacionwoiner({this.identificacion});
  @override
  _IdentificaciowoinerState createState() => _IdentificaciowoinerState();
}

class _IdentificaciowoinerState extends State<Identificacionwoiner> {
  typeDocument tipodocument;
  countryCity lugarDocumento;

  int validformtipodoc = 0;
  int validformlugar = 0;
  int visibletec = 0;
  final _formKey = GlobalKey<FormState>();

  TextEditingController numeroDocumento = new TextEditingController();
  int errtipo = 0;
  int errlugar = 0;

  // Navigator.of(context).pop();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.identificacion != null) {
      numeroDocumento.text = widget.identificacion.numero;
      tipodocument = widget.identificacion.tipodocumento;
      lugarDocumento = widget.identificacion.lugarExpedicion;
      //snombreController.text = widget.nameUser.segundoNombre;

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
      tag: "identificacion",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Identificación Woiner",
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
                      key: _formKey,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).hp(2),
                              bottom: ResponsiveFlutter.of(context).hp(3)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ResponsiveFlutter.of(context)
                                              .wp(3),
                                          right: ResponsiveFlutter.of(context)
                                              .wp(3),
                                          top: ResponsiveFlutter.of(context)
                                              .hp(.8)),
                                      child: SizedBox(
                                        //height:ResponsiveFlutter.of(context).hp(5),
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
                                                  tipodocument == null
                                                      ? "Tipo de documento"
                                                      : tipodocument.name,
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
                                                  color: errtipo == 0
                                                      ? Color(0xffd3d7db)
                                                      : Colors.red[600])),
                                          padding: EdgeInsets.all(4),
                                          color: Colors.white,
                                          elevation: 0,
                                          onPressed: () async {
                                            final rt =
                                                await showDialogTypeDocument(
                                                    context, tipodocument);
                                            if (rt != null) {
                                              setState(() {
                                                tipodocument = rt;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ResponsiveFlutter.of(context)
                                              .wp(3),
                                          right: ResponsiveFlutter.of(context)
                                              .wp(3),
                                          top: ResponsiveFlutter.of(context)
                                              .hp(.8)),
                                      child: SizedBox(
                                        //height:ResponsiveFlutter.of(context).hp(5),
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
                                                  lugarDocumento == null
                                                      ? "Lugar de expedición del documento"
                                                      : lugarDocumento
                                                              .getcountry.name +
                                                          " - " +
                                                          lugarDocumento
                                                              .getCity.name,
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
                                                  color: errlugar == 0
                                                      ? Color(0xffd3d7db)
                                                      : Colors.red[600])),
                                          padding: EdgeInsets.all(4),
                                          color: Colors.white,
                                          elevation: 0,
                                          onPressed: () async {
                                            var respuesta =
                                                await showDialogUbicacion(
                                                    context, lugarDocumento);

                                            if (respuesta != null) {
                                              setState(() {
                                                lugarDocumento = respuesta;
                                              });
                                            }
                                          },
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
                                        "Numero de Documento *",
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
                                        // height: ResponsiveFlutter.of(context).hp(5),
                                        child: TextFormField(
                                          maxLength: 15,
                                          validator: (val) {
                                            if (val.length < 7) {
                                              return "Documento incorrecto (min= 7 digitos)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: numeroDocumento,
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

                                            hintText: "Documento del usuario",

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
                              if (tipodocument == null) {
                                setState(() {
                                  errtipo = 1;
                                  validformtipodoc++;
                                });
                              } else {
                                setState(() {
                                  errtipo = 0;
                                  if (validformtipodoc > 0) {
                                    validformtipodoc--;
                                  }
                                });
                              }
                              if (lugarDocumento == null) {
                                setState(() {
                                  errlugar = 1;
                                  validformlugar++;
                                });
                              } else {
                                setState(() {
                                  errlugar = 0;
                                  if (validformlugar > 0) {
                                    validformlugar--;
                                  }
                                });
                              }
                              if (_formKey.currentState.validate() &&
                                  validformlugar == 0 &&
                                  validformtipodoc == 0) {
                                typeAndDocument document = new typeAndDocument(
                                    lugarExpedicion: lugarDocumento,
                                    numero: numeroDocumento.text,
                                    tipodocumento: tipodocument);

                                Navigator.of(context).pop(document);
                                // print("TODO BIEN");

                                // Navigator.of(context).pop(nameuser);
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
