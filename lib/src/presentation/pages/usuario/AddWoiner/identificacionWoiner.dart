import 'package:flutter/material.dart';

import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Countries/Country.dart';

import 'package:woin/src/entities/Persons/typeDocument.dart';
import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/country_popup.dart';

import 'package:woin/src/providers/document_type_provider.dart';
import 'package:woin/src/providers/login_provider.dart';
import 'package:woin/src/widgets/type_document_selector.dart';

class Identificacionwoiner extends StatefulWidget {
 
  @override
  _IdentificaciowoinerState createState() => _IdentificaciowoinerState();
}

class _IdentificaciowoinerState extends State<Identificacionwoiner> {

  int validformtipodoc = 0;
  int validformlugar = 0;
  int visibletec = 0;
  final _formKey = GlobalKey<FormState>();

  TextEditingController numeroDocumento = new TextEditingController();
  int errtipo = 0;
  int errlugar = 0;

  // Navigator.of(context).pop();
  //String documentType = "Tipo de documento";

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
      tag: "identificacion",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: _appBar(context),
        backgroundColor: Colors.grey[300],
        body: _body(context),
      ),
    );
  }

  Column _body(BuildContext context) {
    UserDetailResponse userData =Provider.of<LoginProvider>(context, listen: false).userDetail;
    typeDocument tipodocument = Provider.of<DoumentTypeProvider>(context).typeDoc;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 3.0,
            bottom: 0.0
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 2.0.w,
              vertical: 0.5.h
            ),
            children: <Widget>[
              Form(
                //key: _formKey,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 0.0.h),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 2.0.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 0.0.h),
                          child: _documentType(context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0.w,vertical: 0.0.h),
                          child:_expeditionPlace(context),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:6.0.w,
                                vertical: 1.0.h
                              ),
                              child: Text(
                                "Numero de Documento *",
                                style: TextStyle(color: Colors.grey[700]),
                              )
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  ResponsiveFlutter.of(context).wp(3),
                              vertical:
                                  ResponsiveFlutter.of(context).hp(0)),
                          child:_textFormFieldDocumentNumber(context, userData)
                        ),
                        SizedBox(height: 2.0.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
        Container(
          height: 8.0.h,
          color: Colors.white,
          child: _buttons(context, tipodocument),
        ),
      ],
    );
  }

  Container _buttons(BuildContext context, typeDocument tipodocument) {
    return Container(
      height: 5.0.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Text(
                  'Cancelar',
                  style: TextStyle(
                      fontFamily: "Roboto",
                      color: Color(0xff1ba6d2),
                      fontSize: MediaQuery.of(context).size.height *
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
                      fontSize: MediaQuery.of(context).size.height *
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
              // if (lugarDocumento == null) {
              //   setState(() {
              //     errlugar = 1;
              //     validformlugar++;
              //   });
              // } else {
              //   setState(() {
              //     errlugar = 0;
              //     if (validformlugar > 0) {
              //       validformlugar--;
              //     }
              //   });
              // }
              if (_formKey.currentState.validate() &&
                  validformlugar == 0 &&
                  validformtipodoc == 0) {
                typeAndDocument document = new typeAndDocument(
                  numero: numeroDocumento.text,
                  tipodocumento: tipodocument
                );
                Navigator.of(context).pop(document);
              } else {
                print("Errores");
              }
              
            }

          ),
        ],
      ),
    );
  }

  TextFormField _textFormFieldDocumentNumber(BuildContext context, UserDetailResponse userData) {
    return TextFormField(
      maxLength: 15,
      validator: (val) {
        if (val.length < 7) {
          return "Documento incorrecto (min= 7 digitos)";
        } else {
          return null;
        }
      },
      focusNode: FocusNode(),
      enableInteractiveSelection: false,
      enabled: false,
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
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(50.0)),
            borderSide: BorderSide(
                color: Colors.grey[300])
            // borderSide: new BorderSide(color: Colors.teal)
            ),
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
        hintText: userData.username,
        // fillColor: Colors.white,
        labelStyle:
            TextStyle(color: Color(0xfc979797)),
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

  RaisedButton _expeditionPlace(BuildContext context)  {
    Country country = Provider.of<DoumentTypeProvider>(context).getCountry;
    Cities city = Provider.of<DoumentTypeProvider>(context).getCity;
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.only(
            left: 10, right: 10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              country?.name != null ? "${country?.name} " +  "${city?.name}" : "Lugar de expedición del documento",
              style: TextStyle(
                fontSize:11.0.sp,
                color: Color(0xfc979797),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400
              ),
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
        borderRadius:BorderRadius.circular(30),
        side: BorderSide(
          color: errlugar == 0
          ? Color(0xffd3d7db)
          : Colors.red[600]
        )
      ),
      padding: EdgeInsets.all(4),
      color: Colors.white,
      elevation: 0,
      onPressed: () async {
        showDialogUbicacion(context, );
      },
    );
  }

  RaisedButton _documentType(BuildContext context) {
    typeDocument tipodocument = Provider.of<DoumentTypeProvider>(context).typeDoc;
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              tipodocument == null ? "Tipo de documento" : tipodocument.name,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  color: Color(0xfc979797),
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400),
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
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
              color: errtipo == 0 ? Color(0xffd3d7db) : Colors.red[600])),
      padding: EdgeInsets.all(4),
      color: Colors.white,
      elevation: 0,
      onPressed: () async {
        final rt = await showDialogTypeDocument(context, tipodocument);
        if (rt != null) {
          setState(() {
            tipodocument = rt;
          });
        }
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
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
    );
  }
}
