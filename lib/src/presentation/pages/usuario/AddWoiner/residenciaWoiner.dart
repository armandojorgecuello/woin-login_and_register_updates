import 'package:flutter/material.dart';

import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';

import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/country_popup.dart';
import 'package:woin/src/providers/document_type_provider.dart';


class ResidenciaWoiner extends StatefulWidget {
  ubicacionWoiner ubicacion;

  ResidenciaWoiner({this.ubicacion});
  @override
  _ResidenciaWoinerState createState() => _ResidenciaWoinerState();
}

class _ResidenciaWoinerState extends State<ResidenciaWoiner> {
  countryCity lugar;

  int validformlugar = 0;
  int visibletec = 0;

  TextEditingController direccion = new TextEditingController();

  int errlugar = 0;

  // Navigator.of(context).pop();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.ubicacion != null) {
      //  numeroDocumento.text = widget.identificacion.numero;
      //tipodocument = widget.identificacion.tipodocumento;
      lugar = widget.ubicacion.lugarUbicacion;
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
      tag: "residencia",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: _appBar(context),
        backgroundColor: Colors.grey[300],
        body:  _body(context),
      ),
    );
  }

  Column _body(BuildContext context)  {
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: ResponsiveFlutter.of(context).verticalScale(10),
                bottom: ResponsiveFlutter.of(context).verticalScale(10)),
            child: _listUbication(context),
          ),
          Expanded(
            child: SizedBox(),
          ),
           _buttons(context),   
        ],
      );
  }

  Container _buttons(BuildContext context) {
    return Container(
      height: 8.0.h,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            }
          ),
        ],
      ),
    );
  }

  ListView _listUbication(BuildContext context)  {
    Country country = Provider.of<DoumentTypeProvider>(context).getCountry;
    Cities city = Provider.of<DoumentTypeProvider>(context).getCity;
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.
      symmetric(
        horizontal: 2.0.w,
        vertical: 0.0
      ),
      children: <Widget>[
        Form(
          child: Card(
            child: Padding(
              padding: EdgeInsets.only(
                top:2.0.h,
                bottom: 3.0.h
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.w,vertical:0.08.h),
                    child:_userLocation(context)
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(  horizontal:  6.0.w,  vertical:  1.5.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dirección *",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:3.0.w,
                      vertical:0
                    ),
                    child: _adressTextField(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextFormField _adressTextField(BuildContext context) {
    return TextFormField(
                            maxLength: 25,
                            validator: (val) {
                              if (val.length < 12) {
                                return "Dirección incorrecta (min= 12 carácteres)";
                              } else {
                                return null;
                              }
                            },
                            controller: direccion,
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
                              hintText: "Dirección del usuario",
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

  RaisedButton _userLocation(BuildContext context)  {
    Country country = Provider.of<DoumentTypeProvider>(context).getCountry;
    Cities city = Provider.of<DoumentTypeProvider>(context).getCity;
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
              country?.name != null ? "${country?.name} " +  "${city?.name}"  : "Ubicación del usuario",
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
        showDialogUbicacion(context);
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: Text(
          "Ubicación del Woiner",
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
