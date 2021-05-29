import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Persons/gender.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/genderPerson.dart';
import 'package:woin/src/services/Scope/countryService.dart';

class mercadoObjetivo extends StatefulWidget {
  mercadoObjetivoClass mercado;

  mercadoObjetivo({this.mercado});

  @override
  _mercadoObjetivoState createState() => _mercadoObjetivoState();
}

class _mercadoObjetivoState extends State<mercadoObjetivo> {
  int errEdad1 = 0, errEdad2 = 0, errGenero = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController edesde = TextEditingController();
  TextEditingController ehasta = TextEditingController();
  int visiblec = 1;

  bool checkedValue = false;
  bool checkedSex = false;
  void initState() {
    super.initState();
    if (widget.mercado != null) {
      if (widget.mercado.isTodaEdad()) {
        checkedValue = true;
      } else {
        edesde.text = widget.mercado.edadDesde.toString();
        ehasta.text = widget.mercado.edadHasta.toString();
      }

      if (widget.mercado.gender.id == 1000) {
        checkedSex = true;
      }
    }
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {

      setState(() {
        visiblec = visible ? 0 : 1;
        //print(visiblec);
      });
      // print(MediaQuery.of(context).size.height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "mercadoObjetivo",
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Mercado Objetivo",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: MediaQuery.of(context).size.height * 0.0195,
              color: Color(0xff1ba6d2),
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(shape: BoxShape.circle),
            alignment: Alignment.centerLeft,
            //color: Colors.amber,
            padding: EdgeInsets.all(0),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              splashColor: Colors.white10,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 18,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex:  visiblec == 1?8:10,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListView(
                          padding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).hp(3),
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.03),
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Edad *",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              // height: 42,
                              padding: EdgeInsets.only(
                                  top: ResponsiveFlutter.of(context).hp(1)),

                              //color: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: edesde,
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          if (val[0] == "0") {
                                            val = "";
                                            edesde.text = val;
                                          }
                                          setState(() {
                                            checkedValue = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        if (val.length > 0) {
                                          checkedValue = false;

                                          if (int.parse(val) < 1 ||
                                              int.parse(val) > 99) {
                                            return "edad incorrecta";
                                          }else
                                          if (ehasta.text == "") {
                                            return "";
                                          }else
                                          if (ehasta.text != "") {
                                            if (int.parse(ehasta.text) <
                                                int.parse(val)) {
                                              return "";
                                            }
                                          }else{
                                            return null;
                                          }
                                        }
                                        if (val.length == 0 && ehasta.text != "") {
                                          return "Ingrese edad";
                                        }else{
                                          return null;
                                        }
                                      },
                                      maxLength: 2,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              .018),
                                      keyboardType: TextInputType.number,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        counterText: "",
                                        contentPadding: EdgeInsets.all(10),

                                        hintText: "Edad desde",

                                        // fillColor: Colors.white,
                                        labelStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize:
                                            MediaQuery.of(context).size.height *
                                                .018),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.grey[300])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.grey[500])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.red[500])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.red[500])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),

                                        // labelText: 'Correo'
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ResponsiveFlutter.of(context).wp(2),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          if (val[0] == "0") {
                                            val = "";
                                            ehasta.text = val;
                                          }
                                          setState(() {
                                            checkedValue = false;
                                          });
                                        }
                                      },
                                      controller: ehasta,
                                      validator: (val) {
                                        if (edesde.text != "" && val == "") {
                                          checkedValue = false;
                                          return "Ingrese edad límite";
                                        }else
                                        if (val.length > 0 && edesde.text != "") {
                                          checkedValue = false;
                                          if (int.parse(val) <=
                                              int.parse(edesde.text)) {
                                            return "Límite edad incorrecto";
                                          }else
                                          if (int.parse(val) < 1 ||
                                              int.parse(val) > 99) {
                                            return "edad incorrecta";
                                          }else{
                                            return null;
                                          }
                                        }else
                                        if (val.length > 0 && edesde.text == "") {
                                          checkedValue = false;
                                          return "";
                                        }else{
                                          return null;
                                        }
                                      },
                                      maxLength: 2,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              .018),
                                      keyboardType: TextInputType.number,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        counterText: "",
                                        contentPadding: EdgeInsets.all(10),

                                        hintText: 'Edad hasta',

                                        // fillColor: Colors.white,
                                        labelStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize:
                                            MediaQuery.of(context).size.height *
                                                .018),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.grey[300])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.grey[500])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.red[500])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                            BorderSide(color: Colors.red[500])
                                          // borderSide: new BorderSide(color: Colors.teal)
                                        ),

                                        // labelText: 'Correo'
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Checkbox(
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                    value: checkedValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkedValue = newValue;
                                        edesde.text = "";
                                        ehasta.text = "";
                                      });
                                    },
                                    //  <-- leading Checkbox
                                  ),
                                  Text("Todas las edades",
                                      style: TextStyle(color: Colors.grey[700])),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveFlutter.of(context).hp(2),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Género *",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: ResponsiveFlutter.of(context).verticalScale(48),
                             // color: Colors.blue,
                              padding: EdgeInsets.only(
                                  top: ResponsiveFlutter.of(context).verticalScale(0)),

                              //color: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                        disabledColor: Colors.grey[300],
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(left: 10, right: 10,top:ResponsiveFlutter.of(context).verticalScale(2),bottom: ResponsiveFlutter.of(context).verticalScale(2) ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  widget.mercado != null
                                                      ? widget.mercado.gender != null
                                                      ? widget.mercado.gender.name
                                                      : "Genero"
                                                      : "Género",
                                                  style: TextStyle(
                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0175,
                                                      color: Color(0xfc979797),
                                                      fontFamily: "Roboto",
                                                      fontWeight: FontWeight.w400)),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    .12 *
                                                    .21,
                                                color: Color(0xff757575),
                                              )
                                            ],
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: BorderSide(
                                                color: errGenero == 0
                                                    ? Color(0xffd3d7db)
                                                    : Colors.red[500])),
                                        padding: EdgeInsets.all(4),
                                        color: Colors.white,
                                        elevation: 0,
                                        onPressed: () {
                                          genero generosel;
                                          if (widget.mercado == null) {
                                            generosel = null;
                                          } else {
                                            generosel = widget.mercado.gender;
                                          }
                                          showDialogGender(context, generosel)
                                              .then((gen) {
                                            if (gen != null) {
                                              setState(() {
                                                errGenero = 0;

                                                if (widget.mercado == null) {
                                                  widget.mercado =
                                                  new mercadoObjetivoClass();
                                                }
                                                widget.mercado.gender = gen;
                                                checkedSex = false;
                                              });
                                            }
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Checkbox(
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                    value: checkedSex,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkedSex = newValue;
                                        if (checkedSex) {
                                          setState(() {
                                            errGenero = 0;
                                          });
                                          if (widget.mercado == null) {
                                            widget.mercado = mercadoObjetivoClass();
                                          }
                                          widget.mercado.gender =
                                          new genero(id: 1000, name: "Unisex");
                                        } else {
                                          if (widget.mercado == null) {
                                            widget.mercado = mercadoObjetivoClass();
                                          }
                                          widget.mercado.gender = null;
                                        }
                                      });
                                    },
                                    //  <-- leading Checkbox
                                  ),
                                  Text("Unisex",
                                      style: TextStyle(color: Colors.grey[700])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: visiblec == 1? 9:3,child: SizedBox(),)
                  ],

                ),
              ),
            ),

            Expanded(
              flex: visiblec == 1 ? 2 : 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1,color: Colors.grey[300])
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
                              int error = 0;
                              if (_formKey.currentState.validate()) {
                                if (checkedValue) {
                                  if (widget.mercado == null) {
                                    widget.mercado = new mercadoObjetivoClass();
                                  }
                                  widget.mercado.todaEdad = 1;
                                } else {
                                  if (widget.mercado == null) {
                                    widget.mercado = new mercadoObjetivoClass();
                                  }

                                  if (edesde.text != "" && ehasta.text != "") {
                                    widget.mercado.edadDesde =
                                        int.parse(edesde.text);
                                    widget.mercado.edadHasta =
                                        int.parse(ehasta.text);
                                    widget.mercado.todaEdad = 0;
                                  } else {
                                    error = 1;
                                  }
                                }
                                if (widget.mercado != null) {
                                  //print(widget.mercado.gender.name);

                                  if (widget.mercado.gender == null) {
                                    setState(() {
                                      errGenero = 1;
                                    });
                                    error = 1;
                                  }
                                  if (!widget.mercado.isTodaEdad() &&
                                      !widget.mercado.tieneEdad()) {
                                    error = 1;
                                  }
                                } else {
                                  error = 1;
                                }
                              } else {
                                error = 1;
                              }
                              if (error == 1) {
                                closeModal() {
                                  Navigator.of(context).pop();
                                }

                                showAlerts(
                                    context,
                                    "Todos los campos son obligatorios",
                                    false,
                                    closeModal,
                                    null,
                                    "Aceptar",
                                    "",
                                    null);
                              } else {
                                Navigator.of(context).pop(widget.mercado);
                              }
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
