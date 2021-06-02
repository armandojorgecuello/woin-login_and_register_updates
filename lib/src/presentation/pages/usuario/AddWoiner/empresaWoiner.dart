import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sizer/sizer.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';
import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/category.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/country_popup.dart';


class Empresaswoiner extends StatefulWidget {
  infoEmpresa dataEmpresa;
  Empresaswoiner({this.dataEmpresa});
  @override
  _EmpresaswoinerswoinerState createState() => _EmpresaswoinerswoinerState();
}

class _EmpresaswoinerswoinerState extends State<Empresaswoiner> {
  DateTime fechaCreacion;
  int validformfec = 0;
  int validformcat = 0;
  int validformUb = 0;
  int visibletec = 0;
  final _formKey = GlobalKey<FormState>();
  var myFormat = new DateFormat('yyyy-MM-dd');
  countryCity ubicacionEmpresa;
  Category categoriaEmpresa;
  TextEditingController nombreController = new TextEditingController();
  TextEditingController nitController = new TextEditingController();
  TextEditingController direccionController = new TextEditingController();

  int errfecha = 0;
  int errcat = 0;
  int errUb = 0;

  @override
  void initState() {
    super.initState();
    //if (widget.dataEmpresa != null) {
    //  nombreController.text = widget.dataEmpresa.nombre;
    //  nitController.text = widget.dataEmpresa.nit;
    //  fechaCreacion = DateTime.parse(widget.dataEmpresa.fechaCreacion);
    //  categoriaEmpresa = widget.dataEmpresa.categoria;
    //  ubicacionEmpresa = widget.dataEmpresa.lugarUbicacion;
    //}
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
      tag: "empresa",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Mi Empresa",
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
                                        "Nit de la empresa *",
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
                                        child: _nitTextField(context),
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
                                        "Nombre de la empresa *",
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
                                        child: _businessNameTextField(context),
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
                                        child: _businessCreatinDate(context),
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
                                        child:  _businessLocation(context),
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
                                        "Dirección de la empresa *",
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
                                        child: _addressLocationTextField(context),
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
                                        child:  _businessCategory(context),
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
                    _buttons(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   Padding _buttons(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 3.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
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
                  width: MediaQuery.of(context).size.width *
                      0.03,
                ),
                Text(
                  'Cancelar',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0xff1ba6d2),
                    fontSize: MediaQuery.of(context).size.height * 0.019),
                ),
              ],
            ),
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.only( left: 30, right: 30, top: 12, bottom: 12),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
          ),
          RaisedButton(
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Siguiente',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.019
                  ),
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
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.only( left: 30, right: 30, top: 12, bottom: 12),
            color: Color(0xff1ba6d2),
            onPressed: () {
              if (fechaCreacion == null) {
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
              if (categoriaEmpresa == null) {
                setState(() {
                  errcat = 1;
                  validformcat++;
                });
              } else {
                setState(() {
                  errcat = 0;
                  if (validformcat > 0) {
                    validformcat--;
                  }
                });
              }
              if (ubicacionEmpresa == null) {
                setState(() {
                  errUb = 1;
                  validformUb++;
                });
              } else {
                setState(() {
                  errUb = 0;
                  if (validformUb > 0) {
                    validformUb--;
                  }
                });
              }
              if (_formKey.currentState.validate() &&
                  validformUb == 0 &&
                  validformfec == 0 &&
                  validformcat == 0) {
                //print("TODO BIEN");
                infoEmpresa info = new infoEmpresa(
                    categoria: categoriaEmpresa,
                    fechaCreacion:
                        myFormat.format(fechaCreacion),
                    lugarUbicacion: ubicacionEmpresa,
                    nit: nitController.text,
                    direccion: direccionController.text,
                    nombre:
                        nombreController.text.toUpperCase());
                Navigator.of(context).pop(info);
              } else {
                print("Errores");
              }
              // Navigator.of(context).pop(imgFile);
            }

          ) 
        ]
      )
    );
  }

  RaisedButton _businessCategory(BuildContext context)  {
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.only(
            left: 10, right: 10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
          children: <Widget>[
            Text(
              categoriaEmpresa == null
                  ? "Categoria"
                  : categoriaEmpresa.name,
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
              color: errcat == 0
                  ? Color(0xffd3d7db)
                  : Colors.red[600])),
      padding: EdgeInsets.all(4),
      color: Colors.white,
      elevation: 0,
      onPressed: () async {
        final rc = await showDialogCategory(
            context, categoriaEmpresa);
        if (rc != null) {
          setState(() {
            categoriaEmpresa = rc;
          });
        }
      },
    );
  }

  TextFormField _addressLocationTextField(BuildContext context) {
    return TextFormField(
      maxLength: 25,
      validator: (val) {
        if (val.length < 7) {
          return "Dirección incorrecta (min= 12 letras)";
        } else {
          return null;
        }
      },
      controller: direccionController,
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
            fontSize: ResponsiveFlutter.of(
                    context)
                .fontSize(1.5)),
        contentPadding: EdgeInsets.all(10),
        hintText: widget.dataEmpresa?.lugarUbicacion ?? "Dirección de su empresa",
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
    );
  }

  RaisedButton _businessLocation(BuildContext context)  {
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.only(
            left: 10, right: 10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
          children: <Widget>[
            Text(
              ubicacionEmpresa == null
                  ? "Ubicación de la empresa"
                  : ubicacionEmpresa
                          .getcountry.name +
                      " - " +
                      ubicacionEmpresa
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
              color: errUb == 0
                  ? Color(0xffd3d7db)
                  : Colors.red[600])),
      padding: EdgeInsets.all(4),
      color: Colors.white,
      elevation: 0,
      onPressed: () async {
        var respuesta =
            await showDialogUbicacion(
                context);
        if (respuesta != null) {
          setState(() {
            ubicacionEmpresa = respuesta;
          });
        }
      },
    );
  }

  RaisedButton _businessCreatinDate(BuildContext context) {
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.only(
            left: 10, right: 10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
          children: <Widget>[
            Text(
              fechaCreacion == null
                  ? "Fecha de Creación de la empresa *"
                  : myFormat.format(
                      fechaCreacion),
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
              fechaCreacion = date;
            });
          }
        });
      },
    );
  }

  TextFormField _businessNameTextField(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      validator: (val) {
        if (val.length < 7) {
          return "Nombre incorrecto (min= 7 letras)";
        } else {
          return null;
        }
      },
      controller: nombreController,
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
        hintText:widget.dataEmpresa?.nombre ?? "Nombre de su empresa",
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
    );
  }

  TextFormField _nitTextField(BuildContext context) {
    return TextFormField(
        maxLength: 12,
        validator: (val) {
          if (val.length < 7) {
            return "Nit incorrecto (min= 7 dígitos)";
          } else {
            return null;
          }
        },
        controller: nitController,
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
          hintText: widget.dataEmpresa?.nit ?? "Nit de su empresa",
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
      );
  }
}
