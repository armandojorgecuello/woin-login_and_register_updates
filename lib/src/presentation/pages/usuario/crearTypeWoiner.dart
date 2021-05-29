/*import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';
import 'package:woin/src/entities/Persons/gender.dart';
import 'package:woin/src/entities/Persons/typeDocument.dart';
import 'package:woin/src/entities/users/regCliWoiner.dart';
import 'package:woin/src/entities/users/regEmwoiner.dart';
import 'package:woin/src/entities/users/user.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alertValidacion.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/category.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/genderPerson.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/typeDocument.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/ubicacion.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/services/usuario/blocUser.dart';
import 'package:woin/src/services/usuario/userService.dart';

class typeWoiner extends StatefulWidget {
  @override
  _typeWoinerState createState() => _typeWoinerState();
}

class _typeWoinerState extends State<typeWoiner> {
  //PRUEBA
  final _formKey = GlobalKey<FormState>();
  userdetalle sesion = new userdetalle();
  int n = 1;
  final numdocNode = FocusNode();
  int errnumdoc = 0;
  genero gender;
  genero gendere;
  DateTime fechaNacimiento;
  DateTime fechaNacimientoe;
  typeDocument tipodocument;
  typeDocument tipodocumente;
  DateTime fechaCreacionEmpresa;
  Category categoriaSel;
  countryCity ccsel;
  countryCity lugarNacimiento;
  countryCity lugarDocumentoe;
  int typeCuenta = 0;
  int cindex = 1;
  int index = 1;
  int indexe = 1;
  countryCity ccem;

  var myFormat = new DateFormat('yyyy-MM-dd');
  int visibleredCliwoin = 0;
  int opcionalCliwoin = 1;
  ScrollController ctrl = PageController();
  TextEditingController nombreController = new TextEditingController();
  TextEditingController nombreControllere = new TextEditingController();
  TextEditingController nombreEmpresa = new TextEditingController();
  TextEditingController cedulaController = new TextEditingController();
  TextEditingController cedulaControllere = new TextEditingController();
  TextEditingController acercademiController = new TextEditingController();
  TextEditingController telefonoContactoController =
      new TextEditingController();
  TextEditingController whatsappController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController nitController = new TextEditingController();
  TextEditingController acercaEmpresaController = new TextEditingController();
  TextEditingController telefonoContactoEmController =
      new TextEditingController();
  TextEditingController whatsappEmController = new TextEditingController();
  TextEditingController callCenterController = new TextEditingController();
  TextEditingController emailEmController = new TextEditingController();
  TextEditingController paginaWebController = new TextEditingController();
  TextEditingController facebookController = new TextEditingController();
  TextEditingController instagramController = new TextEditingController();
  TextEditingController twitterController = new TextEditingController();
  TextEditingController linkedController = new TextEditingController();
  int visiblep = 1;
  File imgFile;

  _openGallery(BuildContext context) async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = img;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgFile = img;
    });
    Navigator.of(context).pop();
  }

  crearEmwoin() {
    if (typeCuenta == 1) {
      ctrl.animateTo(MediaQuery.of(context).size.width * .9,
          duration: Duration(milliseconds: 800), curve: Curves.easeIn);

      setState(() {
        typeCuenta = 2;
      });
    }
  }

  void initState() {
    typeCuenta =
        sesion.isTipoUser(2) == true ? 2 : sesion.isTipoUser(3) == true ? 1 : 1;
    opcionalCliwoin = sesion.isTipoUser(3) ? 0 : 1;

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      //print("ACA CARE VERGA");
      setState(() {
        visiblep = visible ? 0 : 1;
        //print(visiblec);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Perfil",
            style: TextStyle(
                color: Color(0xff1ba6d2),
                fontSize: MediaQuery.of(context).size.height * 0.022),
          ),
          actions: <Widget>[],
          centerTitle: true,
          titleSpacing: 0,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 12,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      color: Colors.grey[200],
                      height: MediaQuery.of(context).size.height * .748,
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  AnimatedContainer(
                                    height: (visiblep == 1 &&
                                            visibleredCliwoin == 0)
                                        ? MediaQuery.of(context).size.height *
                                            .33
                                        : 0,
                                    duration: Duration(milliseconds: 400),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: ListView(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: false,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Center(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showBotomModal();
                                                            },
                                                            child: Container(
                                                                //color: Colors.blue,
                                                                width: MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .width *
                                                                    .18,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .18,
                                                                child: Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Positioned(
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .18,
                                                                        height: MediaQuery.of(context).size.width *
                                                                            .18,
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundImage: imgFile != null
                                                                              ? FileImage(imgFile)
                                                                              : null,
                                                                          radius:
                                                                              MediaQuery.of(context).size.width * .20,
                                                                          backgroundColor:
                                                                              Colors.grey[200],
                                                                          foregroundColor:
                                                                              Colors.grey[600],
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 5),
                                                                            child: imgFile == null
                                                                                ? Text(
                                                                                    userdetalle().getSession.username[0],
                                                                                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                                                                                  )
                                                                                : SizedBox(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          .1 *
                                                                          .02,
                                                                      right: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .20 *
                                                                          0.08,
                                                                      child: Container(
                                                                          decoration: BoxDecoration(color: Colors.grey[600], shape: BoxShape.circle),
                                                                          child: GestureDetector(
                                                                            onTap: () =>
                                                                                {
                                                                              showBotomModal()
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(MediaQuery.of(context).size.height * .002),
                                                                              child: Icon(
                                                                                Icons.edit,
                                                                                color: Colors.white,
                                                                                size: MediaQuery.of(context).size.height * .019,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    )
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            sesion.tieneTipo() ==
                                                                    false
                                                                ? "Sin nombre para mostrar"
                                                                : sesion
                                                                    .getSession
                                                                    .person
                                                                    .fullName,
                                                            style: TextStyle(
                                                                fontSize: sesion.tieneTipo() ==
                                                                        false
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.018
                                                                    : 18,
                                                                color: sesion
                                                                            .tieneTipo() ==
                                                                        false
                                                                    ? Colors
                                                                        .black26
                                                                    : Colors
                                                                        .black,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: visibleredCliwoin == 0
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .002
                                                      : 0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    RatingBarIndicator(
                                                      itemSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.018,
                                                      rating:
                                                          sesion.tieneTipo() ==
                                                                  false
                                                              ? 0.0
                                                              : 2.5,
                                                      itemCount: 5,
                                                      unratedColor:
                                                          Colors.black12,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Color(
                                                            0xff0075b1), //Theme.of(context).primaryColor
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '0.0',
                                                      style: TextStyle(
                                                          color: sesion
                                                                      .tieneTipo() ==
                                                                  false
                                                              ? Colors.black26
                                                              : Color(
                                                                  0xff0075b1),
                                                          fontFamily: 'Roboto',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.018),
                                                    ),
                                                    Text(
                                                      sesion.tieneTipo() ==
                                                              false
                                                          ? ""
                                                          : sesion
                                                              .getSession
                                                              .woinerType[0]
                                                              .typeName,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff0075b1),
                                                          fontFamily: 'Roboto'),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: visibleredCliwoin == 0
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .015
                                                      : 0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    sesion.isTipoUser(2) ==
                                                            false
                                                        ? Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .35,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () => {
                                                                if (typeCuenta ==
                                                                    2)
                                                                  {
                                                                    ctrl.animateTo(
                                                                        0,
                                                                        duration: Duration(
                                                                            milliseconds:
                                                                                800),
                                                                        curve: Curves
                                                                            .easeIn),
                                                                  },
                                                                setState(() {
                                                                  typeCuenta =
                                                                      1;
                                                                }),
                                                              },
                                                              child: Card(
                                                                  elevation:
                                                                      typeCuenta ==
                                                                              1
                                                                          ? 3
                                                                          : 1,
                                                                  color: typeCuenta ==
                                                                          1
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.grey[
                                                                          100],
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            17,
                                                                        left:
                                                                            17,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                      "Cliwoin",
                                                                      style: TextStyle(
                                                                          color: typeCuenta == 1
                                                                              ? Color(
                                                                                  0xff1ba6d2)
                                                                              : Colors.grey[
                                                                                  500],
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height * 0.018),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  )),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    sesion.isTipoUser(3) ==
                                                            false
                                                        ? Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .35,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () => {
                                                                sesion.isTipoUser(
                                                                            2) ==
                                                                        true
                                                                    ? null
                                                                    : crearEmwoin()
                                                              },
                                                              child: Card(
                                                                  elevation:
                                                                      typeCuenta ==
                                                                              2
                                                                          ? 3
                                                                          : 1,
                                                                  color: typeCuenta ==
                                                                          2
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.grey[
                                                                          100],
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            17,
                                                                        left:
                                                                            17,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                      "Emwoin",
                                                                      style: TextStyle(
                                                                          color: typeCuenta == 2
                                                                              ? Color(
                                                                                  0xff1ba6d2)
                                                                              : Colors.grey[
                                                                                  500],
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height * 0.018),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  )),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: visibleredCliwoin == 0
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .02
                                                      : 0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        typeCuenta == 1
                                                            ? "Usuarios(Woiner) que desean comprar en promoción y ganar puntos para adquirir bienes, productos o servicios."
                                                            : "Comercios que buscan ser visibles, aumentar sus ventas y fidelizar clientes.",
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.016,
                                                          color:
                                                              Colors.grey[500],
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //PAGE VIEW
                            Container(
                              height: opcionalCliwoin == 1
                                  ? MediaQuery.of(context).size.height * .375
                                  : MediaQuery.of(context).size.height * .7,
                              //color: Colors.blue,
                              child:
                                  sesion.isTipoUser(2) == false &&
                                          sesion.isTipoUser(3) == false
                                      ? PageView(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          controller: ctrl,
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                    ),
                                                    Card(
                                                      elevation: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (visibleredCliwoin ==
                                                                    0) {
                                                                  visibleredCliwoin =
                                                                      1;
                                                                  opcionalCliwoin =
                                                                      0;
                                                                } else {
                                                                  visibleredCliwoin =
                                                                      0;
                                                                  opcionalCliwoin =
                                                                      1;
                                                                }
                                                              });
                                                              print(
                                                                  visibleredCliwoin);
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.055,
                                                              color:
                                                                  Colors.white,
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              14,
                                                                          top:
                                                                              15,
                                                                          bottom:
                                                                              10),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (visibleredCliwoin ==
                                                                            0) {
                                                                          visibleredCliwoin =
                                                                              1;
                                                                          opcionalCliwoin =
                                                                              0;
                                                                        } else {
                                                                          visibleredCliwoin =
                                                                              0;
                                                                          opcionalCliwoin =
                                                                              1;
                                                                        }
                                                                        // print("ROW");
                                                                      });
                                                                    },
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              if (visibleredCliwoin == 0) {
                                                                                visibleredCliwoin = 1;
                                                                                opcionalCliwoin = 0;
                                                                              } else {
                                                                                visibleredCliwoin = 0;
                                                                                opcionalCliwoin = 1;
                                                                              }
                                                                            });
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Información personal",
                                                                            style: TextStyle(
                                                                                color: Color.fromRGBO(34, 129, 168, 1),
                                                                                fontWeight: FontWeight.w500,
                                                                                fontFamily: "Roboto",
                                                                                fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              if (visibleredCliwoin == 0) {
                                                                                visibleredCliwoin = 1;
                                                                                opcionalCliwoin = 0;
                                                                              } else {
                                                                                visibleredCliwoin = 0;
                                                                                opcionalCliwoin = 1;
                                                                              }
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                17,
                                                                            child:
                                                                                IconButton(
                                                                              icon: visibleredCliwoin == 1 ? Icon(Icons.keyboard_arrow_down, size: 20) : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                              padding: EdgeInsets.all(0),
                                                                              onPressed: () => {
                                                                                setState(() {
                                                                                  if (visibleredCliwoin == 0) {
                                                                                    visibleredCliwoin = 1;
                                                                                    opcionalCliwoin = 0;
                                                                                  } else {
                                                                                    visibleredCliwoin = 0;
                                                                                    opcionalCliwoin = 1;
                                                                                  }
                                                                                })
                                                                              },
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                          AnimatedContainer(
                                                            height: visibleredCliwoin ==
                                                                    0
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .22
                                                                : 0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            12,
                                                                        right:
                                                                            12,
                                                                        top: 4,
                                                                        bottom:
                                                                            4),
                                                                    child:
                                                                        Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.18,
                                                                      child:
                                                                          PageView(
                                                                        onPageChanged:
                                                                            (page) {
                                                                          setState(
                                                                              () {
                                                                            cindex =
                                                                                page + 1;
                                                                          });
                                                                        },
                                                                        children: <
                                                                            Widget>[
                                                                          Column(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: ListView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  children: <Widget>[
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.01,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: <Widget>[
                                                                                                          Text(
                                                                                                            tipodocument == null ? "Tipo de documento" : tipodocument.name,
                                                                                                            style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                          ),
                                                                                                          Icon(
                                                                                                            Icons.keyboard_arrow_down,
                                                                                                            color: Color(0xff757575),
                                                                                                            size: 18,
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
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
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextFormField(
                                                                                                    focusNode: numdocNode,
                                                                                                    controller: cedulaController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.number,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    validator: (value) {
                                                                                                      //print("Value=>" + value);
                                                                                                      if (value.length < 7 || value.length > 10 || value.isEmpty) {
                                                                                                        setState(() {
                                                                                                          errnumdoc = 1;
                                                                                                        });
                                                                                                        return '';
                                                                                                      } else {
                                                                                                        setState(() {
                                                                                                          errnumdoc = 0;
                                                                                                        });
                                                                                                        return null;
                                                                                                      }
                                                                                                    },
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),
                                                                                                      errorStyle: TextStyle(height: 0),
                                                                                                      focusedErrorBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red, width: 1), borderRadius: BorderRadius.all(Radius.circular(50.0))),
                                                                                                      errorBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red, width: 1), borderRadius: BorderRadius.all(Radius.circular(50.0))),
                                                                                                      suffixIcon: errnumdoc == 1
                                                                                                          ? GestureDetector(
                                                                                                              child: Icon(
                                                                                                                Icons.error_outline,
                                                                                                                color: Colors.grey[500],
                                                                                                              ),
                                                                                                              onTap: () {
                                                                                                                numdocNode.unfocus();
                                                                                                                numdocNode.canRequestFocus = false;
                                                                                                                showDialogV2(context: context, builder: (BuildContext context) => alertValidation("* Numero de documento minimo 7 numeros y maximo 10"));
                                                                                                                Future.delayed(Duration(milliseconds: 100), () {
                                                                                                                  numdocNode.canRequestFocus = true;
                                                                                                                });
                                                                                                              },
                                                                                                            )
                                                                                                          : null,
                                                                                                      labelText: 'Numero de documento',
                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: <Widget>[
                                                                                                            Text(
                                                                                                              lugarNacimiento == null ? "Lugar de expedición del documento" : lugarNacimiento.getcountry.name + " - " + lugarNacimiento.getCity.name,
                                                                                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                            ),
                                                                                                            Icon(
                                                                                                              Icons.keyboard_arrow_down,
                                                                                                              color: Color(0xff757575),
                                                                                                              size: 18,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                      padding: EdgeInsets.all(4),
                                                                                                      color: Colors.white,
                                                                                                      elevation: 0,
                                                                                                      onPressed: () async {
                                                                                                        var respuesta = await showDialogUbicacion(context, lugarNacimiento);

                                                                                                        if (respuesta != null) {
                                                                                                          setState(() {
                                                                                                            lugarNacimiento = respuesta;
                                                                                                          });
                                                                                                        }
                                                                                                      }),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: ListView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  children: <Widget>[
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.01,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: nombreController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Nombre(Woiner)',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: <Widget>[
                                                                                                          Text(
                                                                                                            fechaNacimiento == null ? "Fecha de nacimiento" : myFormat.format(fechaNacimiento),
                                                                                                            style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                          ),
                                                                                                          Icon(
                                                                                                            Icons.keyboard_arrow_down,
                                                                                                            color: Color(0xff757575),
                                                                                                            size: 18,
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                    padding: EdgeInsets.all(4),
                                                                                                    color: Colors.white,
                                                                                                    elevation: 0,
                                                                                                    onPressed: () {
                                                                                                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(2022)).then((date) {
                                                                                                        if (date != null) {
                                                                                                          setState(() {
                                                                                                            fechaNacimiento = date;
                                                                                                          });
                                                                                                        }
                                                                                                      });
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: <Widget>[
                                                                                                            Text(
                                                                                                              gender == null ? "Género" : gender.name,
                                                                                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                            ),
                                                                                                            Icon(
                                                                                                              Icons.keyboard_arrow_down,
                                                                                                              color: Color(0xff757575),
                                                                                                              size: 18,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                      padding: EdgeInsets.all(4),
                                                                                                      color: Colors.white,
                                                                                                      elevation: 0,
                                                                                                      onPressed: () async {
                                                                                                        final gen = await showDialogGender(context, gender);

                                                                                                        if (gen != null) {
                                                                                                          setState(() {
                                                                                                            gender = gen;
                                                                                                          });
                                                                                                        }
                                                                                                      }),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: MediaQuery.of(context).size.height *
                                                                            .0),
                                                                    child: SizedBox(
                                                                        height: MediaQuery.of(context).size.height * .02,
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              height: MediaQuery.of(context).size.height * .01,
                                                                              width: MediaQuery.of(context).size.height * .01,
                                                                              decoration: new BoxDecoration(
                                                                                color: cindex == 1 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.01,
                                                                            ),
                                                                            Container(
                                                                              height: MediaQuery.of(context).size.height * .01,
                                                                              width: MediaQuery.of(context).size.height * .01,
                                                                              decoration: new BoxDecoration(
                                                                                color: cindex == 2 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .005,
                                                    ),
                                                    Card(
                                                      elevation: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (opcionalCliwoin ==
                                                                    0) {
                                                                  opcionalCliwoin =
                                                                      1;
                                                                  visibleredCliwoin =
                                                                      0;
                                                                } else {
                                                                  opcionalCliwoin =
                                                                      0;
                                                                  visibleredCliwoin =
                                                                      1;
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.055,
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              14,
                                                                          top:
                                                                              15,
                                                                          bottom:
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Opcional para mostar al público",
                                                                        style: TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                34,
                                                                                129,
                                                                                168,
                                                                                1),
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                                "Roboto",
                                                                            fontSize:
                                                                                MediaQuery.of(context).size.height * 0.018),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            17,
                                                                        child:
                                                                            IconButton(
                                                                          icon: opcionalCliwoin == 1
                                                                              ? Icon(Icons.keyboard_arrow_down, size: 20)
                                                                              : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                          padding:
                                                                              EdgeInsets.all(0),
                                                                          onPressed:
                                                                              () => {
                                                                            setState(() {
                                                                              if (opcionalCliwoin == 0) {
                                                                                opcionalCliwoin = 1;
                                                                                visibleredCliwoin = 0;
                                                                              } else {
                                                                                opcionalCliwoin = 0;
                                                                                visibleredCliwoin = 1;
                                                                              }
                                                                            })
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )),
                                                            ),
                                                          ),
                                                          AnimatedContainer(
                                                            height: opcionalCliwoin ==
                                                                    0
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .25
                                                                : 0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            //color: Colors.grey,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(12),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        ListView(
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: <
                                                                              Widget>[
                                                                            opcionalCliwoin == 1
                                                                                ? SizedBox()
                                                                                : Expanded(
                                                                                    child: SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * .042,
                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                      child: TextField(
                                                                                        controller: acercademiController,
                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.017),
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        autocorrect: true,
                                                                                        autofocus: false,
                                                                                        maxLines: null,
                                                                                        expands: true,

                                                                                        //textInputAction: TextInputAction.newline,
                                                                                        decoration: InputDecoration(
                                                                                          contentPadding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),

                                                                                          labelText: 'Acerca de mí',

                                                                                          // fillColor: Colors.white,
                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                              ),
                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                              ),

                                                                                          // labelText: 'Correo'
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: opcionalCliwoin == 0
                                                                              ? MediaQuery.of(context).size.height * .013
                                                                              : 0,
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: <
                                                                              Widget>[
                                                                            opcionalCliwoin == 1
                                                                                ? SizedBox()
                                                                                : Expanded(
                                                                                    child: SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * .042,
                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                      child: TextField(
                                                                                        controller: telefonoContactoController,
                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                        keyboardType: TextInputType.number,
                                                                                        autocorrect: true,
                                                                                        autofocus: false,
                                                                                        decoration: InputDecoration(
                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                          labelText: 'Teléfono de contacto',

                                                                                          // fillColor: Colors.white,
                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                              ),
                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                              ),

                                                                                          // labelText: 'Correo'
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: opcionalCliwoin == 0
                                                                              ? MediaQuery.of(context).size.height * .013
                                                                              : 0,
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: <
                                                                              Widget>[
                                                                            opcionalCliwoin == 1
                                                                                ? SizedBox()
                                                                                : Expanded(
                                                                                    child: SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * .042,
                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                      child: TextField(
                                                                                        controller: whatsappController,
                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                        keyboardType: TextInputType.number,
                                                                                        autocorrect: true,
                                                                                        autofocus: false,
                                                                                        decoration: InputDecoration(
                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                          labelText: 'Whatsapp',

                                                                                          // fillColor: Colors.white,
                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                              ),
                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                              ),

                                                                                          // labelText: 'Correo'
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: opcionalCliwoin == 0
                                                                              ? MediaQuery.of(context).size.height * .013
                                                                              : 0,
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: <
                                                                              Widget>[
                                                                            opcionalCliwoin == 1
                                                                                ? SizedBox()
                                                                                : Expanded(
                                                                                    child: SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * .042,
                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                      child: RaisedButton(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: <Widget>[
                                                                                                Text(
                                                                                                  ccsel == null ? "País de ubicación" : ccsel.getcountry.name + " - " + ccsel.getCity.name,
                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                ),
                                                                                                Icon(
                                                                                                  Icons.keyboard_arrow_down,
                                                                                                  color: Color(0xff757575),
                                                                                                  size: 18,
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                          padding: EdgeInsets.all(4),
                                                                                          color: Colors.white,
                                                                                          elevation: 0,
                                                                                          onPressed: () async {
                                                                                            var respuesta = await showDialogUbicacion(context, ccsel);

                                                                                            if (respuesta != null) {
                                                                                              print(respuesta.getCity);
                                                                                              setState(() {
                                                                                                ccsel = respuesta;
                                                                                              });
                                                                                            }
                                                                                          }),
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: opcionalCliwoin == 1
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .008
                                                        : 0,
                                                  ),
                                                  Card(
                                                    elevation: 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (visibleredCliwoin ==
                                                                  0) {
                                                                visibleredCliwoin =
                                                                    1;
                                                                opcionalCliwoin =
                                                                    0;
                                                              } else {
                                                                visibleredCliwoin =
                                                                    0;
                                                                opcionalCliwoin =
                                                                    1;
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            color: Colors.white,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.055,
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            14,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Información visible en la red",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              34,
                                                                              129,
                                                                              168,
                                                                              1),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height * 0.018),
                                                                    ),
                                                                    Container(
                                                                      width: 40,
                                                                      height:
                                                                          17,
                                                                      child:
                                                                          IconButton(
                                                                        icon: visibleredCliwoin ==
                                                                                1
                                                                            ? Icon(Icons.keyboard_arrow_down,
                                                                                size: 20)
                                                                            : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                        padding:
                                                                            EdgeInsets.all(0),
                                                                        onPressed:
                                                                            () =>
                                                                                {
                                                                          setState(
                                                                              () {
                                                                            if (visibleredCliwoin ==
                                                                                0) {
                                                                              visibleredCliwoin = 1;
                                                                              opcionalCliwoin = 0;
                                                                            } else {
                                                                              visibleredCliwoin = 0;
                                                                              opcionalCliwoin = 1;
                                                                            }
                                                                          })
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        AnimatedContainer(
                                                          height: visibleredCliwoin ==
                                                                  0
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .22
                                                              : 0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              12,
                                                                          left:
                                                                              12,
                                                                          top:
                                                                              0),
                                                                  child:
                                                                      Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .195,
                                                                    child: sesion.tienePerson() ==
                                                                            0
                                                                        ? PageView(
                                                                            onPageChanged: (page) =>
                                                                                {
                                                                              setState(() {
                                                                                indexe = page + 1;
                                                                              }),
                                                                            },
                                                                            children: <Widget>[
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.01,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                tipodocumente == null ? "Tipo de documento" : tipodocumente.name,
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                        padding: EdgeInsets.all(4),
                                                                                                        color: Colors.white,
                                                                                                        elevation: 0,
                                                                                                        onPressed: () async {
                                                                                                          final rt = await showDialogTypeDocument(context, tipodocumente);
                                                                                                          if (rt != null) {
                                                                                                            setState(() {
                                                                                                              tipodocumente = rt;
                                                                                                            });
                                                                                                          }
                                                                                                        },
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: cedulaControllere,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Numero de documento',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  lugarDocumentoe == null ? "Lugar de expedición del documento" : lugarDocumentoe.getcountry.name + " - " + lugarDocumentoe.getCity.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            var respuesta = await showDialogUbicacion(context, lugarDocumentoe);

                                                                                                            if (respuesta != null) {
                                                                                                              setState(() {
                                                                                                                lugarDocumentoe = respuesta;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.01,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: nombreControllere,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Nombre(Woiner)',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                fechaNacimientoe == null ? "Fecha de nacimiento" : myFormat.format(fechaNacimientoe),
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                        padding: EdgeInsets.all(4),
                                                                                                        color: Colors.white,
                                                                                                        elevation: 0,
                                                                                                        onPressed: () {
                                                                                                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(2022)).then((date) {
                                                                                                            if (date != null) {
                                                                                                              setState(() {
                                                                                                                fechaNacimientoe = date;
                                                                                                              });
                                                                                                            }
                                                                                                          });
                                                                                                        },
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  gendere == null ? "Género" : gendere.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            final gen = await showDialogGender(context, gendere);

                                                                                                            if (gen != null) {
                                                                                                              setState(() {
                                                                                                                gendere = gen;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.007,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: nombreEmpresa,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Nombre de su empresa',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: nitController,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Identificacón-Nit',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  fechaCreacionEmpresa == null ? "Fecha Creación de su Empresa" : myFormat.format(fechaCreacionEmpresa),
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () {
                                                                                                            showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime(2030)).then((date) {
                                                                                                              if (date != null) {
                                                                                                                setState(() {
                                                                                                                  fechaCreacionEmpresa = date;
                                                                                                                });
                                                                                                              }
                                                                                                            });
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  categoriaSel == null ? "Categoria" : categoriaSel.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            final rc = await showDialogCategory(context, categoriaSel);
                                                                                                            if (rc != null) {
                                                                                                              setState(() {
                                                                                                                categoriaSel = rc;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Column(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: ListView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  children: <Widget>[
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.008,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: nombreEmpresa,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Nombre de su empresa',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: nitController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.number,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Identificacón-Nit',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: <Widget>[
                                                                                                            Text(
                                                                                                              fechaCreacionEmpresa == null ? "Fecha Creación de su Empresa" : myFormat.format(fechaCreacionEmpresa),
                                                                                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                            ),
                                                                                                            Icon(
                                                                                                              Icons.keyboard_arrow_down,
                                                                                                              color: Color(0xff757575),
                                                                                                              size: 18,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                      padding: EdgeInsets.all(4),
                                                                                                      color: Colors.white,
                                                                                                      elevation: 0,
                                                                                                      onPressed: () {
                                                                                                        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime(2030)).then((date) {
                                                                                                          if (date != null) {
                                                                                                            setState(() {
                                                                                                              fechaCreacionEmpresa = date;
                                                                                                            });
                                                                                                          }
                                                                                                        });
                                                                                                      }),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: <Widget>[
                                                                                                            Text(
                                                                                                              categoriaSel == null ? "Categoria" : categoriaSel.name,
                                                                                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                            ),
                                                                                                            Icon(
                                                                                                              Icons.keyboard_arrow_down,
                                                                                                              color: Color(0xff757575),
                                                                                                              size: 18,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                      padding: EdgeInsets.all(4),
                                                                                                      color: Colors.white,
                                                                                                      elevation: 0,
                                                                                                      onPressed: () async {
                                                                                                        final rc = await showDialogCategory(context, categoriaSel);
                                                                                                        if (rc != null) {
                                                                                                          setState(() {
                                                                                                            categoriaSel = rc;
                                                                                                          });
                                                                                                        }
                                                                                                      }),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                  ),
                                                                ),
                                                                sesion.tienePerson() ==
                                                                        0
                                                                    ? Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: MediaQuery.of(context).size.height * .0),
                                                                        child: SizedBox(
                                                                            height: MediaQuery.of(context).size.height * .02,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: indexe == 1 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.01,
                                                                                ),
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: indexe == 2 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.01,
                                                                                ),
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: indexe == 3 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .007,
                                                  ),
                                                  Card(
                                                    elevation: 2,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (opcionalCliwoin ==
                                                                    0) {
                                                                  opcionalCliwoin =
                                                                      1;
                                                                  visibleredCliwoin =
                                                                      0;
                                                                } else {
                                                                  opcionalCliwoin =
                                                                      0;
                                                                  visibleredCliwoin =
                                                                      1;
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.055,
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              1,
                                                                          left:
                                                                              12,
                                                                          top:
                                                                              2),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Opcional para mostar al público",
                                                                        style: TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                34,
                                                                                129,
                                                                                168,
                                                                                1),
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                                "Roboto",
                                                                            fontSize:
                                                                                MediaQuery.of(context).size.height * 0.018),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            17,
                                                                        child:
                                                                            IconButton(
                                                                          icon: visibleredCliwoin == 1
                                                                              ? Icon(Icons.keyboard_arrow_down, size: 20)
                                                                              : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                          padding:
                                                                              EdgeInsets.all(0),
                                                                          onPressed:
                                                                              () => {
                                                                            setState(() {
                                                                              if (visibleredCliwoin == 0) {
                                                                                visibleredCliwoin = 1;
                                                                                opcionalCliwoin = 0;
                                                                              } else {
                                                                                visibleredCliwoin = 0;
                                                                                opcionalCliwoin = 1;
                                                                              }
                                                                            })
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ),
                                                          ),
                                                          AnimatedContainer(
                                                            height: typeCuenta ==
                                                                        2 &&
                                                                    opcionalCliwoin ==
                                                                        0
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .4
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    400),
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            12,
                                                                        left:
                                                                            12,
                                                                        top: opcionalCliwoin ==
                                                                                1
                                                                            ? 8
                                                                            : 0,
                                                                        bottom:
                                                                            0),
                                                                    child: Container(
                                                                        //color: Colors.blueAccent,
                                                                        height: visibleredCliwoin == 0 ? 0 : MediaQuery.of(context).size.height * .358,
                                                                        child: PageView(
                                                                          onPageChanged:
                                                                              (page) => {
                                                                            setState(() {
                                                                              index = page + 1;
                                                                            }),
                                                                            // print(page)
                                                                          },
                                                                          children: <
                                                                              Widget>[
                                                                            Column(
                                                                              children: <Widget>[
                                                                                Expanded(
                                                                                  child: ListView(
                                                                                    scrollDirection: Axis.vertical,
                                                                                    shrinkWrap: false,
                                                                                    children: <Widget>[
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: acercaEmpresaController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.text,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Acerca de mi empresa',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: telefonoContactoEmController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Teléfono de Contacto',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: whatsappEmController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Número WhatsApp',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: callCenterController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Call Center-Línea 018000',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: emailEmController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.emailAddress,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Correo Electrónico',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: paginaWebController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.text,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Página Web',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                ccem == null ? "País de Ubicación" : ccem.getcountry.name + " - " + ccem.getCity.name,
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                        padding: EdgeInsets.all(4),
                                                                                                        color: Colors.white,
                                                                                                        elevation: 0,
                                                                                                        onPressed: () async {
                                                                                                          var respuesta = await showDialogUbicacion(context, ccem);

                                                                                                          if (respuesta != null) {
                                                                                                            setState(() {
                                                                                                              ccem = respuesta;
                                                                                                            });
                                                                                                          }
                                                                                                        }),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Column(
                                                                              children: <Widget>[
                                                                                Expanded(
                                                                                    child: ListView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  children: <Widget>[
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * .01,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: facebookController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Facebook',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: instagramController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Instagram',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: twitterController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Twitter',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: linkedController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'LinkedIn',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ))
                                                                              ],
                                                                            )
                                                                          ],
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: MediaQuery.of(context).size.height *
                                                                            .015),
                                                                    child: SizedBox(
                                                                        height: MediaQuery.of(context).size.height * .02,
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              height: MediaQuery.of(context).size.height * .01,
                                                                              width: MediaQuery.of(context).size.height * .01,
                                                                              decoration: new BoxDecoration(
                                                                                color: index == 1 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.01,
                                                                            ),
                                                                            Container(
                                                                              height: MediaQuery.of(context).size.height * .01,
                                                                              width: MediaQuery.of(context).size.height * .01,
                                                                              decoration: new BoxDecoration(
                                                                                color: index == 2 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                ],
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
                                          ],
                                        )
                                      : sesion.isTipoUser(2) == false
                                          ? SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .01,
                                                  ),
                                                  sesion.tienePerson() == 0
                                                      ? Card(
                                                          elevation: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (visibleredCliwoin ==
                                                                        0) {
                                                                      visibleredCliwoin =
                                                                          1;
                                                                      opcionalCliwoin =
                                                                          0;
                                                                    } else {
                                                                      visibleredCliwoin =
                                                                          0;
                                                                      opcionalCliwoin =
                                                                          1;
                                                                    }
                                                                  });
                                                                  print(
                                                                      visibleredCliwoin);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.055,
                                                                  color: Colors
                                                                      .white,
                                                                  child:
                                                                      Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 14,
                                                                              top: 15,
                                                                              bottom: 10),
                                                                          child: GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (visibleredCliwoin == 0) {
                                                                                  visibleredCliwoin = 1;
                                                                                  opcionalCliwoin = 0;
                                                                                } else {
                                                                                  visibleredCliwoin = 0;
                                                                                  opcionalCliwoin = 1;
                                                                                }
                                                                                // print("ROW");
                                                                              });
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      if (visibleredCliwoin == 0) {
                                                                                        visibleredCliwoin = 1;
                                                                                        opcionalCliwoin = 0;
                                                                                      } else {
                                                                                        visibleredCliwoin = 0;
                                                                                        opcionalCliwoin = 1;
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Información personal",
                                                                                    style: TextStyle(color: Color.fromRGBO(34, 129, 168, 1), fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      if (visibleredCliwoin == 0) {
                                                                                        visibleredCliwoin = 1;
                                                                                        opcionalCliwoin = 0;
                                                                                      } else {
                                                                                        visibleredCliwoin = 0;
                                                                                        opcionalCliwoin = 1;
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    width: 40,
                                                                                    height: 17,
                                                                                    child: IconButton(
                                                                                      icon: visibleredCliwoin == 1 ? Icon(Icons.keyboard_arrow_down, size: 20) : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                                      padding: EdgeInsets.all(0),
                                                                                      onPressed: () => {
                                                                                        setState(() {
                                                                                          if (visibleredCliwoin == 0) {
                                                                                            visibleredCliwoin = 1;
                                                                                            opcionalCliwoin = 0;
                                                                                          } else {
                                                                                            visibleredCliwoin = 0;
                                                                                            opcionalCliwoin = 1;
                                                                                          }
                                                                                        })
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                              AnimatedContainer(
                                                                height: visibleredCliwoin ==
                                                                        0
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .22
                                                                    : 0,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                12,
                                                                            right:
                                                                                12,
                                                                            top:
                                                                                4,
                                                                            bottom:
                                                                                4),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.18,
                                                                          child:
                                                                              PageView(
                                                                            onPageChanged:
                                                                                (page) {
                                                                              setState(() {
                                                                                cindex = page + 1;
                                                                              });
                                                                            },
                                                                            children: <Widget>[
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.01,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                tipodocument == null ? "Tipo de documento" : tipodocument.name,
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
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
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: cedulaController,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Numero de documento',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  lugarNacimiento == null ? "Lugar de expedición del documento" : lugarNacimiento.getcountry.name + " - " + lugarNacimiento.getCity.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            var respuesta = await showDialogUbicacion(context, lugarNacimiento);

                                                                                                            if (respuesta != null) {
                                                                                                              setState(() {
                                                                                                                lugarNacimiento = respuesta;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.01,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: nombreController,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Nombre(Woiner)',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                fechaNacimiento == null ? "Fecha de nacimiento" : myFormat.format(fechaNacimiento),
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                        padding: EdgeInsets.all(4),
                                                                                                        color: Colors.white,
                                                                                                        elevation: 0,
                                                                                                        onPressed: () {
                                                                                                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(2022)).then((date) {
                                                                                                            if (date != null) {
                                                                                                              setState(() {
                                                                                                                fechaNacimiento = date;
                                                                                                              });
                                                                                                            }
                                                                                                          });
                                                                                                        },
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  gender == null ? "Género" : gender.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            final gen = await showDialogGender(context, gender);

                                                                                                            if (gen != null) {
                                                                                                              setState(() {
                                                                                                                gender = gen;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: MediaQuery.of(context).size.height * .0),
                                                                        child: SizedBox(
                                                                            height: MediaQuery.of(context).size.height * .02,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: cindex == 1 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.01,
                                                                                ),
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: cindex == 2 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                  sesion.tienePerson() == 0
                                                      ? SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .005,
                                                        )
                                                      : SizedBox(),
                                                  Card(
                                                    elevation: 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (opcionalCliwoin ==
                                                                  0) {
                                                                opcionalCliwoin =
                                                                    1;
                                                                visibleredCliwoin =
                                                                    0;
                                                              } else {
                                                                opcionalCliwoin =
                                                                    0;
                                                                visibleredCliwoin =
                                                                    1;
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            color: Colors.white,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.055,
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            14,
                                                                        top: 15,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Opcional para mostar al público",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              34,
                                                                              129,
                                                                              168,
                                                                              1),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height * 0.018),
                                                                    ),
                                                                    Container(
                                                                      width: 40,
                                                                      height:
                                                                          17,
                                                                      child:
                                                                          IconButton(
                                                                        icon: opcionalCliwoin ==
                                                                                1
                                                                            ? Icon(Icons.keyboard_arrow_down,
                                                                                size: 20)
                                                                            : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                        padding:
                                                                            EdgeInsets.all(0),
                                                                        onPressed:
                                                                            () =>
                                                                                {
                                                                          setState(
                                                                              () {
                                                                            if (opcionalCliwoin ==
                                                                                0) {
                                                                              opcionalCliwoin = 1;
                                                                              visibleredCliwoin = 0;
                                                                            } else {
                                                                              opcionalCliwoin = 0;
                                                                              visibleredCliwoin = 1;
                                                                            }
                                                                          })
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        AnimatedContainer(
                                                          height: opcionalCliwoin ==
                                                                  0
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .25
                                                              : 0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          //color: Colors.grey,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child:
                                                                      ListView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    shrinkWrap:
                                                                        true,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: <
                                                                            Widget>[
                                                                          opcionalCliwoin == 1
                                                                              ? SizedBox()
                                                                              : Expanded(
                                                                                  child: SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * .042,
                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                    child: TextField(
                                                                                      controller: acercademiController,
                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.017),
                                                                                      keyboardType: TextInputType.multiline,
                                                                                      autocorrect: true,
                                                                                      autofocus: false,
                                                                                      maxLines: null,
                                                                                      expands: true,

                                                                                      //textInputAction: TextInputAction.newline,
                                                                                      decoration: InputDecoration(
                                                                                        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),

                                                                                        labelText: 'Acerca de mí',

                                                                                        // fillColor: Colors.white,
                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                            ),
                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                            ),

                                                                                        // labelText: 'Correo'
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: opcionalCliwoin ==
                                                                                0
                                                                            ? MediaQuery.of(context).size.height *
                                                                                .013
                                                                            : 0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: <
                                                                            Widget>[
                                                                          opcionalCliwoin == 1
                                                                              ? SizedBox()
                                                                              : Expanded(
                                                                                  child: SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * .042,
                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                    child: TextField(
                                                                                      controller: telefonoContactoController,
                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                      keyboardType: TextInputType.number,
                                                                                      autocorrect: true,
                                                                                      autofocus: false,
                                                                                      decoration: InputDecoration(
                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                        labelText: 'Teléfono de contacto',

                                                                                        // fillColor: Colors.white,
                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                            ),
                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                            ),

                                                                                        // labelText: 'Correo'
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: opcionalCliwoin ==
                                                                                0
                                                                            ? MediaQuery.of(context).size.height *
                                                                                .013
                                                                            : 0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: <
                                                                            Widget>[
                                                                          opcionalCliwoin == 1
                                                                              ? SizedBox()
                                                                              : Expanded(
                                                                                  child: SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * .042,
                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                    child: TextField(
                                                                                      controller: whatsappController,
                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                      keyboardType: TextInputType.number,
                                                                                      autocorrect: true,
                                                                                      autofocus: false,
                                                                                      decoration: InputDecoration(
                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                        labelText: 'Whatsapp',

                                                                                        // fillColor: Colors.white,
                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                            ),
                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                            ),

                                                                                        // labelText: 'Correo'
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: opcionalCliwoin ==
                                                                                0
                                                                            ? MediaQuery.of(context).size.height *
                                                                                .013
                                                                            : 0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: <
                                                                            Widget>[
                                                                          opcionalCliwoin == 1
                                                                              ? SizedBox()
                                                                              : Expanded(
                                                                                  child: SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * .042,
                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                    child: RaisedButton(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                ccsel == null ? "País de ubicación" : ccsel.getcountry.name + " - " + ccsel.getCity.name,
                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                              ),
                                                                                              Icon(
                                                                                                Icons.keyboard_arrow_down,
                                                                                                color: Color(0xff757575),
                                                                                                size: 18,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                        padding: EdgeInsets.all(4),
                                                                                        color: Colors.white,
                                                                                        elevation: 0,
                                                                                        onPressed: () async {
                                                                                          var respuesta = await showDialogUbicacion(context, ccsel);

                                                                                          print(respuesta);

                                                                                          if (respuesta != null) {
                                                                                            print("ENTRA A MODIFICAR");
                                                                                            print(respuesta.getCity);
                                                                                            setState(() {
                                                                                              ccsel = respuesta;
                                                                                            });
                                                                                          }
                                                                                        }),
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SingleChildScrollView(
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: opcionalCliwoin == 1
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .008
                                                        : 0,
                                                  ),
                                                  Card(
                                                    elevation: 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (visibleredCliwoin ==
                                                                  0) {
                                                                visibleredCliwoin =
                                                                    1;
                                                                opcionalCliwoin =
                                                                    0;
                                                              } else {
                                                                visibleredCliwoin =
                                                                    0;
                                                                opcionalCliwoin =
                                                                    1;
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            color: Colors.white,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.055,
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            14,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Información visible en la red",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              34,
                                                                              129,
                                                                              168,
                                                                              1),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height * 0.018),
                                                                    ),
                                                                    Container(
                                                                      width: 40,
                                                                      height:
                                                                          17,
                                                                      child:
                                                                          IconButton(
                                                                        icon: visibleredCliwoin ==
                                                                                1
                                                                            ? Icon(Icons.keyboard_arrow_down,
                                                                                size: 20)
                                                                            : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                        padding:
                                                                            EdgeInsets.all(0),
                                                                        onPressed:
                                                                            () =>
                                                                                {
                                                                          setState(
                                                                              () {
                                                                            if (visibleredCliwoin ==
                                                                                0) {
                                                                              visibleredCliwoin = 1;
                                                                              opcionalCliwoin = 0;
                                                                            } else {
                                                                              visibleredCliwoin = 0;
                                                                              opcionalCliwoin = 1;
                                                                            }
                                                                          })
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        AnimatedContainer(
                                                          height: visibleredCliwoin ==
                                                                  0
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .22
                                                              : 0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              12,
                                                                          left:
                                                                              12,
                                                                          top:
                                                                              0),
                                                                  child:
                                                                      Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .195,
                                                                    child: sesion.tienePerson() ==
                                                                            0
                                                                        ? PageView(
                                                                            onPageChanged: (page) =>
                                                                                {
                                                                              setState(() {
                                                                                indexe = page + 1;
                                                                              }),
                                                                            },
                                                                            children: <Widget>[
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.01,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                tipodocumente == null ? "Tipo de documento" : tipodocumente.name,
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                        padding: EdgeInsets.all(4),
                                                                                                        color: Colors.white,
                                                                                                        elevation: 0,
                                                                                                        onPressed: () async {
                                                                                                          final rt = await showDialogTypeDocument(context, tipodocumente);
                                                                                                          if (rt != null) {
                                                                                                            setState(() {
                                                                                                              tipodocumente = rt;
                                                                                                            });
                                                                                                          }
                                                                                                        },
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: cedulaControllere,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Numero de documento',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  lugarDocumentoe == null ? "Lugar de expedición del documento" : lugarDocumentoe.getcountry.name + " - " + lugarDocumentoe.getCity.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            var respuesta = await showDialogUbicacion(context, lugarDocumentoe);

                                                                                                            if (respuesta != null) {
                                                                                                              setState(() {
                                                                                                                lugarDocumentoe = respuesta;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.01,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: nombreControllere,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Nombre(Woiner)',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                fechaNacimientoe == null ? "Fecha de nacimiento" : myFormat.format(fechaNacimientoe),
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                        padding: EdgeInsets.all(4),
                                                                                                        color: Colors.white,
                                                                                                        elevation: 0,
                                                                                                        onPressed: () {
                                                                                                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(2022)).then((date) {
                                                                                                            if (date != null) {
                                                                                                              setState(() {
                                                                                                                fechaNacimientoe = date;
                                                                                                              });
                                                                                                            }
                                                                                                          });
                                                                                                        },
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? MediaQuery.of(context).size.height * .013 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  gendere == null ? "Género" : gendere.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            final gen = await showDialogGender(context, gendere);

                                                                                                            if (gen != null) {
                                                                                                              setState(() {
                                                                                                                gendere = gen;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  Expanded(
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      shrinkWrap: true,
                                                                                      children: <Widget>[
                                                                                        SizedBox(
                                                                                          height: MediaQuery.of(context).size.height * 0.008,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: nombreEmpresa,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Nombre de su empresa',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: TextField(
                                                                                                        controller: nitController,
                                                                                                        style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        autocorrect: true,
                                                                                                        autofocus: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: EdgeInsets.all(10),

                                                                                                          labelText: 'Identificacón-Nit',

                                                                                                          // fillColor: Colors.white,
                                                                                                          labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                              // borderSide: new BorderSide(color: Colors.teal)
                                                                                                              ),

                                                                                                          // labelText: 'Correo'
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  fechaCreacionEmpresa == null ? "Fecha Creación de su Empresa" : myFormat.format(fechaCreacionEmpresa),
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () {
                                                                                                            showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime(2030)).then((date) {
                                                                                                              if (date != null) {
                                                                                                                setState(() {
                                                                                                                  fechaCreacionEmpresa = date;
                                                                                                                });
                                                                                                              }
                                                                                                            });
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            visibleredCliwoin == 1
                                                                                                ? SizedBox()
                                                                                                : Expanded(
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.of(context).size.height * .038,
                                                                                                      width: MediaQuery.of(context).size.width * .85,
                                                                                                      child: RaisedButton(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: <Widget>[
                                                                                                                Text(
                                                                                                                  categoriaSel == null ? "Categoria" : categoriaSel.name,
                                                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.keyboard_arrow_down,
                                                                                                                  color: Color(0xff757575),
                                                                                                                  size: 18,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                          padding: EdgeInsets.all(4),
                                                                                                          color: Colors.white,
                                                                                                          elevation: 0,
                                                                                                          onPressed: () async {
                                                                                                            final rc = await showDialogCategory(context, categoriaSel);
                                                                                                            if (rc != null) {
                                                                                                              setState(() {
                                                                                                                categoriaSel = rc;
                                                                                                              });
                                                                                                            }
                                                                                                          }),
                                                                                                    ),
                                                                                                  )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Column(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: ListView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  children: <Widget>[
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.008,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: nombreEmpresa,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Nombre de su empresa',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: nitController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.number,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Identificacón-Nit',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: <Widget>[
                                                                                                            Text(
                                                                                                              fechaCreacionEmpresa == null ? "Fecha Creación de su Empresa" : myFormat.format(fechaCreacionEmpresa),
                                                                                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                            ),
                                                                                                            Icon(
                                                                                                              Icons.keyboard_arrow_down,
                                                                                                              color: Color(0xff757575),
                                                                                                              size: 18,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                      padding: EdgeInsets.all(4),
                                                                                                      color: Colors.white,
                                                                                                      elevation: 0,
                                                                                                      onPressed: () {
                                                                                                        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime(2030)).then((date) {
                                                                                                          if (date != null) {
                                                                                                            setState(() {
                                                                                                              fechaCreacionEmpresa = date;
                                                                                                            });
                                                                                                          }
                                                                                                        });
                                                                                                      }),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: visibleredCliwoin == 0 ? 8 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        visibleredCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: RaisedButton(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: <Widget>[
                                                                                                            Text(
                                                                                                              categoriaSel == null ? "Categoria" : categoriaSel.name,
                                                                                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                            ),
                                                                                                            Icon(
                                                                                                              Icons.keyboard_arrow_down,
                                                                                                              color: Color(0xff757575),
                                                                                                              size: 18,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                      padding: EdgeInsets.all(4),
                                                                                                      color: Colors.white,
                                                                                                      elevation: 0,
                                                                                                      onPressed: () async {
                                                                                                        final rc = await showDialogCategory(context, categoriaSel);
                                                                                                        if (rc != null) {
                                                                                                          setState(() {
                                                                                                            categoriaSel = rc;
                                                                                                          });
                                                                                                        }
                                                                                                      }),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                  ),
                                                                ),
                                                                sesion.tienePerson() ==
                                                                        0
                                                                    ? Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: MediaQuery.of(context).size.height * .0),
                                                                        child: SizedBox(
                                                                            height: MediaQuery.of(context).size.height * .02,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: indexe == 1 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.01,
                                                                                ),
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: indexe == 2 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.01,
                                                                                ),
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * .01,
                                                                                  width: MediaQuery.of(context).size.height * .01,
                                                                                  decoration: new BoxDecoration(
                                                                                    color: indexe == 3 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .007,
                                                  ),
                                                  Card(
                                                    elevation: 2,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (opcionalCliwoin ==
                                                                    0) {
                                                                  opcionalCliwoin =
                                                                      1;
                                                                  visibleredCliwoin =
                                                                      0;
                                                                } else {
                                                                  opcionalCliwoin =
                                                                      0;
                                                                  visibleredCliwoin =
                                                                      1;
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.055,
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              1,
                                                                          left:
                                                                              12,
                                                                          top:
                                                                              2),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Opcional para mostar al público",
                                                                        style: TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                34,
                                                                                129,
                                                                                168,
                                                                                1),
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                                "Roboto",
                                                                            fontSize:
                                                                                MediaQuery.of(context).size.height * 0.018),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            17,
                                                                        child:
                                                                            IconButton(
                                                                          icon: visibleredCliwoin == 1
                                                                              ? Icon(Icons.keyboard_arrow_down, size: 20)
                                                                              : Icon(Icons.keyboard_arrow_up, size: 20),
                                                                          padding:
                                                                              EdgeInsets.all(0),
                                                                          onPressed:
                                                                              () => {
                                                                            setState(() {
                                                                              if (visibleredCliwoin == 0) {
                                                                                visibleredCliwoin = 1;
                                                                                opcionalCliwoin = 0;
                                                                              } else {
                                                                                visibleredCliwoin = 0;
                                                                                opcionalCliwoin = 1;
                                                                              }
                                                                            })
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ),
                                                          ),
                                                          AnimatedContainer(
                                                            height: typeCuenta ==
                                                                        2 &&
                                                                    opcionalCliwoin ==
                                                                        0
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .4
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    400),
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            12,
                                                                        left:
                                                                            12,
                                                                        top: opcionalCliwoin ==
                                                                                1
                                                                            ? 8
                                                                            : 0,
                                                                        bottom:
                                                                            0),
                                                                    child: Container(
                                                                        //color: Colors.blueAccent,
                                                                        height: visibleredCliwoin == 0 ? 0 : MediaQuery.of(context).size.height * .358,
                                                                        child: PageView(
                                                                          onPageChanged:
                                                                              (page) => {
                                                                            setState(() {
                                                                              index = page + 1;
                                                                            }),
                                                                            // print(page)
                                                                          },
                                                                          children: <
                                                                              Widget>[
                                                                            Column(
                                                                              children: <Widget>[
                                                                                Expanded(
                                                                                  child: ListView(
                                                                                    scrollDirection: Axis.vertical,
                                                                                    shrinkWrap: false,
                                                                                    children: <Widget>[
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: acercaEmpresaController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.text,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Acerca de mi empresa',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: telefonoContactoEmController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Teléfono de Contacto',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: whatsappEmController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Número WhatsApp',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: callCenterController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Call Center-Línea 018000',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: emailEmController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.emailAddress,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Correo Electrónico',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: TextField(
                                                                                                      controller: paginaWebController,
                                                                                                      style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                      keyboardType: TextInputType.text,
                                                                                                      autocorrect: true,
                                                                                                      autofocus: false,
                                                                                                      decoration: InputDecoration(
                                                                                                        contentPadding: EdgeInsets.all(10),

                                                                                                        labelText: 'Página Web',

                                                                                                        // fillColor: Colors.white,
                                                                                                        labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                            // borderSide: new BorderSide(color: Colors.teal)
                                                                                                            ),

                                                                                                        // labelText: 'Correo'
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          opcionalCliwoin == 1
                                                                                              ? SizedBox()
                                                                                              : Expanded(
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.of(context).size.height * .038,
                                                                                                    width: MediaQuery.of(context).size.width * .85,
                                                                                                    child: RaisedButton(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: <Widget>[
                                                                                                              Text(
                                                                                                                ccem == null ? "País de Ubicación" : ccem.getcountry.name + " - " + ccem.getCity.name,
                                                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, color: Color(0xfc979797), fontFamily: "Roboto", fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                              Icon(
                                                                                                                Icons.keyboard_arrow_down,
                                                                                                                color: Color(0xff757575),
                                                                                                                size: 18,
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Color(0xffd3d7db))),
                                                                                                        padding: EdgeInsets.all(4),
                                                                                                        color: Colors.white,
                                                                                                        elevation: 0,
                                                                                                        onPressed: () async {
                                                                                                          var respuesta = await showDialogUbicacion(context, ccem);

                                                                                                          if (respuesta != null) {
                                                                                                            print(respuesta.getCity);
                                                                                                            setState(() {
                                                                                                              ccem = respuesta;
                                                                                                            });
                                                                                                          }
                                                                                                        }),
                                                                                                  ),
                                                                                                )
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Column(
                                                                              children: <Widget>[
                                                                                Expanded(
                                                                                    child: ListView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  children: <Widget>[
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * .01,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: facebookController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Facebook',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: instagramController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Instagram',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: twitterController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'Twitter',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: opcionalCliwoin == 0 ? MediaQuery.of(context).size.height * .010 : 0,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: <Widget>[
                                                                                        opcionalCliwoin == 1
                                                                                            ? SizedBox()
                                                                                            : Expanded(
                                                                                                child: SizedBox(
                                                                                                  height: MediaQuery.of(context).size.height * .038,
                                                                                                  width: MediaQuery.of(context).size.width * .85,
                                                                                                  child: TextField(
                                                                                                    controller: linkedController,
                                                                                                    style: TextStyle(color: Color(0xfc979797), fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    autocorrect: true,
                                                                                                    autofocus: false,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.all(10),

                                                                                                      labelText: 'LinkedIn',

                                                                                                      // fillColor: Colors.white,
                                                                                                      labelStyle: TextStyle(color: Color(0xfc979797)),
                                                                                                      enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[300])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),
                                                                                                      focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Colors.grey[500])
                                                                                                          // borderSide: new BorderSide(color: Colors.teal)
                                                                                                          ),

                                                                                                      // labelText: 'Correo'
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ))
                                                                              ],
                                                                            )
                                                                          ],
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: MediaQuery.of(context).size.height *
                                                                            .015),
                                                                    child: SizedBox(
                                                                        height: MediaQuery.of(context).size.height * .02,
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              height: MediaQuery.of(context).size.height * .01,
                                                                              width: MediaQuery.of(context).size.height * .01,
                                                                              decoration: new BoxDecoration(
                                                                                color: index == 1 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.01,
                                                                            ),
                                                                            Container(
                                                                              height: MediaQuery.of(context).size.height * .01,
                                                                              width: MediaQuery.of(context).size.height * .01,
                                                                              decoration: new BoxDecoration(
                                                                                color: index == 2 ? Color(0xff1ba6d2) : Colors.grey[300],
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                ],
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .12,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          child: RaisedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.close,
                                      size: 20, color: Color(0xff1ba6d2)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        color: Color(0xff1ba6d2),
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.019),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.only(
                                  left: 30, right: 30, top: 12, bottom: 12),
                              color: Colors.white,
                              elevation: 0,
                              onPressed: () {
                                tipoUser.tipoUserg.add(
                                    sesion.getSession.typeDefault == 2 ? 0 : 1);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TabMain()));
                                // print(username);

                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                              }),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.03),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
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
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (typeCuenta == 1) {
                                    if (sesion.tienePerson() == 0) {
                                      if (tipodocument != null &&
                                          cedulaController.text != "" &&
                                          cedulaController.text != null &&
                                          nombreController.text != "" &&
                                          nombreController.text != null &&
                                          fechaNacimiento != null &&
                                          gender != null &&
                                          lugarNacimiento != null &&
                                          acercademiController.text != "" &&
                                          acercademiController.text != null &&
                                          telefonoContactoController.text !=
                                              "" &&
                                          telefonoContactoController.text !=
                                              null &&
                                          ccsel != null) {
                                        Document doc = new Document(
                                            cityId: lugarNacimiento.getCity.id,
                                            number: cedulaController.text,
                                            type: tipodocument.id);
                                        person2 p = new person2(
                                            //fullName: nombreController.text,
                                            birthdate: myFormat
                                                .format(fechaNacimiento)
                                                .toString(),
                                            document: doc,
                                            gender: gender.id);
                                        List<Phones> phones = new List();

                                        if (telefonoContactoController.text !=
                                            "") {
                                          Phones phone = new Phones(
                                              number: telefonoContactoController
                                                  .text,
                                              typePhone: 1);
                                          phones.add(phone);
                                        }

                                        if (whatsappController.text != "") {
                                          Phones phone = new Phones(
                                              number: whatsappController.text,
                                              typePhone: 2);
                                          phones.add(phone);
                                        }

                                        WoinerType type = new WoinerType(
                                            calification: 0,
                                            type: 2,
                                            typeName: "Cliwoin",
                                            defaultType: 1);
                                        geoLocation gl = new geoLocation();
                                        await gl.obtenerGeolocalizacion();
                                        String imagenUser = "";

                                        if (imgFile != null) {
                                          List<int> imageBytes =
                                              imgFile.readAsBytesSync();
                                          imagenUser = base64Encode(imageBytes);
                                        }

                                        cliWoiner cli = new cliWoiner(
                                            device: gl.getDevices,
                                            person: p,
                                            phones: phones,
                                            woinLocation: gl.getLocation,
                                            userId: 0,
                                            woinerType: type,
                                            isDefault: 1,
                                            image: imagenUser,
                                            biography:
                                                acercademiController.text);

                                        final woinerReg = await userService
                                            .registroWoiner(cli);

                                        if (woinerReg.status) {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Cuenta creada correctamente.",
                                                      true));

                                          List<WoinDocuments> lwd = new List();
                                          WoinDocuments d1 = new WoinDocuments(
                                              cityId: p.document.cityId,
                                              id: 0,
                                              personId: 0,
                                              number: p.document.number,
                                              createdAt: 0,
                                              state: 1,
                                              type: p.document.type,
                                              updatedAt: 0);

                                          lwd.add(d1);

                                          Person p2 = new Person(
                                            birthdate: p.birthdate,
                                            //fullName: p.fullName,
                                            gender: p.gender,
                                            woinDocuments: lwd,
                                            createdAt: 0,
                                            firstLastname: "",
                                            id: 0,
                                            firstname: "",
                                            secondLastname: "",
                                            secondname: "",
                                            updatedAt: 0,
                                            userId: 0,
                                          );

                                          userdetalle sesion =
                                              new userdetalle();
                                          sesion.getSession.person = p2;
                                          sesion.getSession.typeDefault = 2;

                                          sesion.setImageCli = imagenUser;

                                          List<WoinerType> lw = new List();
                                          lw.add(type);
                                          sesion.setCuentaActiva = 2;
                                          sesion.getSession.woinerType = lw;
                                          sesion.setTokenCli =
                                              woinerReg.entities[0].token;

                                          tipoUser.userSesionGSink.add(sesion);
                                          tipoUser.tipoUserg.add(
                                              sesion.getSession.typeDefault == 2
                                                  ? 0
                                                  : 1);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabMain()),
                                          );
                                        } else {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Error al crear cuenta Cliwoin.",
                                                      false));
                                        }
                                      } else {
                                        showDialogV2(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog2(
                                                    "Complete los campos para continuar.",
                                                    false));
                                      }
                                    } else {
                                      print("A CREAR CLI SIN PERSONA");
                                      //EPAAAAA

                                      if (acercademiController.text != "" &&
                                          acercademiController.text != null &&
                                          telefonoContactoController.text !=
                                              "" &&
                                          telefonoContactoController.text !=
                                              null &&
                                          ccsel != null) {
                                        List<Phones> phones = new List();

                                        if (telefonoContactoController.text !=
                                            "") {
                                          Phones phone = new Phones(
                                              number: telefonoContactoController
                                                  .text,
                                              typePhone: 1);
                                          phones.add(phone);
                                        }

                                        if (whatsappController.text != "") {
                                          Phones phone = new Phones(
                                              number: whatsappController.text,
                                              typePhone: 2);
                                          phones.add(phone);
                                        }

                                        WoinerType type = new WoinerType(
                                            calification: 0,
                                            type: 2,
                                            typeName: "Cliwoin",
                                            defaultType: 1);
                                        geoLocation gl = new geoLocation();
                                        await gl.obtenerGeolocalizacion();
                                        String imagenUser = "";

                                        if (imgFile != null) {
                                          List<int> imageBytes =
                                              imgFile.readAsBytesSync();
                                          imagenUser = base64Encode(imageBytes);
                                        }

                                        cliWoiner cli = new cliWoiner(
                                            device: gl.getDevices,
                                            person: null,
                                            phones: phones,
                                            woinLocation: gl.getLocation,
                                            userId: 0,
                                            woinerType: type,
                                            isDefault: 1,
                                            image: imagenUser,
                                            biography:
                                                acercademiController.text);

                                        final woinerReg = await userService
                                            .registroWoiner(cli);

                                        if (woinerReg.status) {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Cuenta creada correctamente.",
                                                      true));

                                          userdetalle sesion =
                                              new userdetalle();
                                          detalleCuenta dc = new detalleCuenta(
                                              biography:
                                                  acercademiController.text,
                                              email: emailController.text,
                                              contacto:
                                                  telefonoContactoController
                                                      .text,
                                              ubicacion: ccsel.getcountry.name +
                                                  " - " +
                                                  ccsel.getCity.name,
                                              whatsapp:
                                                  whatsappController.text);
                                          sesion.addDetalle(dc);
                                          sesion.getSession.typeDefault = 2;

                                          sesion.setImageCli = imagenUser;

                                          List<WoinerType> lw = new List();
                                          lw.add(type);
                                          sesion.setCuentaActiva = 2;
                                          sesion.getSession.woinerType = lw;
                                          sesion.setTokenCli =
                                              woinerReg.entities[0].token;

                                          tipoUser.userSesionGSink.add(sesion);
                                          tipoUser.tipoUserg.add(
                                              sesion.getSession.typeDefault == 2
                                                  ? 0
                                                  : 1);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabMain()),
                                          );
                                        } else {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Error al crear cuenta Cliwoin.",
                                                      false));
                                        }
                                      } else {
                                        showDialogV2(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog2(
                                                    "Complete los campos para continuar.",
                                                    false));
                                      }
                                    }
                                  } else {
                                    if (sesion.tienePerson() == 0) {
                                      //"NO Tiene Person

                                      if (tipodocumente != null &&
                                          cedulaControllere.text != "" &&
                                          cedulaControllere.text != null &&
                                          nombreControllere.text != "" &&
                                          nombreControllere.text != null &&
                                          fechaNacimientoe != null &&
                                          gendere != null &&
                                          nombreEmpresa.text != null &&
                                          nombreEmpresa.text != "" &&
                                          fechaCreacionEmpresa != null &&
                                          nitController.text != null &&
                                          nitController.text != "" &&
                                          categoriaSel != null &&
                                          lugarDocumentoe != null &&
                                          acercaEmpresaController.text != "" &&
                                          acercaEmpresaController.text !=
                                              null &&
                                          telefonoContactoEmController.text !=
                                              "" &&
                                          callCenterController.text != "" &&
                                          callCenterController.text != null &&
                                          emailEmController.text != null &&
                                          emailEmController.text != "" &&
                                          paginaWebController.text != "" &&
                                          paginaWebController.text != null &&
                                          telefonoContactoEmController.text !=
                                              null &&
                                          whatsappEmController.text != "" &&
                                          whatsappEmController.text != null &&
                                          ccem != null &&
                                          facebookController.text != "" &&
                                          twitterController.text != "" &&
                                          instagramController.text != "" &&
                                          linkedController.text != "") {
                                        //EMWOIN

                                        Document doc = new Document(
                                            cityId: lugarDocumentoe.getCity.id,
                                            number: cedulaControllere.text,
                                            type: tipodocumente.id);

                                        person2 p = new person2(
                                            //  fullName: nombreControllere.text,
                                            birthdate: myFormat
                                                .format(fechaNacimientoe)
                                                .toString(),
                                            document: doc,
                                            gender: gendere.id);
                                        List<Phones> phones = new List();

                                        if (telefonoContactoEmController.text !=
                                            "") {
                                          Phones phone = new Phones(
                                              number:
                                                  telefonoContactoEmController
                                                      .text,
                                              typePhone: 1);
                                          phones.add(phone);
                                        }

                                        if (whatsappEmController.text != "") {
                                          Phones phone = new Phones(
                                              number: whatsappEmController.text,
                                              typePhone: 2);
                                          phones.add(phone);
                                        }

                                        WoinerType type = new WoinerType(
                                            calification: 0,
                                            type: 3,
                                            typeName: "Emwoin",
                                            defaultType: 1);
                                        geoLocation gl = new geoLocation();
                                        await gl.obtenerGeolocalizacion();
                                        String imagenUser = "";

                                        if (imgFile != null) {
                                          List<int> imageBytes =
                                              imgFile.readAsBytesSync();
                                          imagenUser = base64Encode(imageBytes);
                                        }

                                        Document docCompany = new Document(
                                            cityId: ccem.getCity.id,
                                            number: nitController.text,
                                            type: 6);

                                        WoinLocationCompany wlc =
                                            new WoinLocationCompany(
                                          altitude: 0,
                                          createdAt: 0,
                                          id: 0,
                                          latitude: 0,
                                          longitude: 0,
                                          updatedAt: 0,
                                        );

                                        List<SocialProfiles> lsp = new List();

                                        SocialProfiles sp = new SocialProfiles(
                                          urlProfile: facebookController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp);
                                        SocialProfiles sp1 = new SocialProfiles(
                                          urlProfile: instagramController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp1);

                                        SocialProfiles sp2 = new SocialProfiles(
                                          urlProfile: twitterController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp2);

                                        SocialProfiles sp3 = new SocialProfiles(
                                          urlProfile: linkedController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp3);

                                        WoinLocationCompany wlc2 =
                                            new WoinLocationCompany(
                                          altitude:
                                              gl.getLocation.altitude.toInt(),
                                          createdAt: 0,
                                          id: 0,
                                          latitude:
                                              gl.getLocation.latitude.toInt(),
                                          longitude:
                                              gl.getLocation.longitude.toInt(),
                                          updatedAt: 0,
                                        );

                                        Device2 dv2 = new Device2(
                                            id: 0,
                                            ip: gl.getDevices.ip,
                                            mac: gl.getDevices.mac,
                                            name: gl.getDevices.name,
                                            state: gl.getDevices.state,
                                            createdAt: 0,
                                            updatedAt: 0,
                                            userId: 0);

                                        emWoiner em = new emWoiner(
                                            person: p,
                                            categoryId: categoriaSel.id,
                                            cityId: ccem.getCity.id,
                                            companyName: nombreEmpresa.text,
                                            dateCompanyCreate: myFormat
                                                .format(fechaCreacionEmpresa),
                                            device: dv2,
                                            documentCompany: docCompany,
                                            email: emailEmController.text,
                                            image: imagenUser,
                                            isDefault: 1,
                                            phones: phones,
                                            socialProfiles: lsp,
                                            userId: 0,
                                            webPage: paginaWebController.text,
                                            woinLocation: wlc2,
                                            woinLocationCompany: wlc,
                                            woinerType: type,
                                            biography:
                                                acercaEmpresaController.text);

                                        final woinerReg = await userService
                                            .registroEmWoiner(em);

                                        if (woinerReg.status) {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Cuenta creada correctamente.",
                                                      true));

                                          userdetalle sesion =
                                              new userdetalle();
                                          List<WoinDocuments> lwd = new List();
                                          WoinDocuments d1 = new WoinDocuments(
                                              cityId: p.document.cityId,
                                              id: 0,
                                              personId: 0,
                                              number: p.document.number,
                                              createdAt: 0,
                                              state: 1,
                                              type: p.document.type,
                                              updatedAt: 0);

                                          //aca
                                          //lwd.add(sesion.getSession.person.woinDocuments[0]);
                                          lwd.add(d1);

                                          Person p2 = new Person(
                                            birthdate: p.birthdate,
                                            // fullName: p.fullName,
                                            gender: p.gender,
                                            woinDocuments: lwd,
                                            createdAt: 0,
                                            firstLastname: "",
                                            id: 0,
                                            firstname: "",
                                            secondLastname: "",
                                            secondname: "",
                                            updatedAt: 0,
                                            userId: 0,
                                          );

                                          sesion.getSession.person = p2;

                                          sesion.getSession.typeDefault = 3;
                                          List<WoinerType> lw = new List();
                                          lw.add(type);
                                          sesion.setCuentaActiva = 3;
                                          sesion.setImageEm = imagenUser;
                                          sesion.getSession.woinerType = lw;
                                          sesion.setTokenCli =
                                              woinerReg.entities[0].token;

                                          tipoUser.userSesionGSink.add(sesion);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabMain()),
                                          );
                                        } else {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Error al crear cuenta Emwoin.",
                                                      false));
                                        }
                                      } else {
                                        //print(categoriaSel.id);

                                        //print(whatsappEmController.text);
                                        // print(callCenterController.text);
                                        // print(emailEmController.text);
                                        showDialogV2(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog2(
                                                    "Complete los campos para continuar",
                                                    false));
                                      }
                                    } else {
                                      //"SI Tiene"

                                      if (nombreEmpresa.text != null &&
                                          nombreEmpresa.text != "" &&
                                          fechaCreacionEmpresa != null &&
                                          nitController.text != null &&
                                          nitController.text != "" &&
                                          categoriaSel != null &&
                                          acercaEmpresaController.text != "" &&
                                          acercaEmpresaController.text !=
                                              null &&
                                          telefonoContactoEmController.text !=
                                              "" &&
                                          callCenterController.text != "" &&
                                          callCenterController.text != null &&
                                          emailEmController.text != null &&
                                          emailEmController.text != "" &&
                                          paginaWebController.text != "" &&
                                          paginaWebController.text != null &&
                                          telefonoContactoEmController.text !=
                                              null &&
                                          whatsappEmController.text != "" &&
                                          whatsappEmController.text != null &&
                                          ccem != null &&
                                          facebookController.text != "" &&
                                          twitterController.text != "" &&
                                          instagramController.text != "" &&
                                          linkedController.text != "") {
                                        List<Phones> phones = new List();

                                        if (telefonoContactoEmController.text !=
                                            "") {
                                          Phones phone = new Phones(
                                              number:
                                                  telefonoContactoEmController
                                                      .text,
                                              typePhone: 1);
                                          phones.add(phone);
                                        }

                                        if (whatsappEmController.text != "") {
                                          Phones phone = new Phones(
                                              number: whatsappEmController.text,
                                              typePhone: 2);
                                          phones.add(phone);
                                        }

                                        WoinerType type = new WoinerType(
                                            calification: 0,
                                            type: 3,
                                            typeName: "Emwoin",
                                            defaultType: 1);
                                        geoLocation gl = new geoLocation();
                                        await gl.obtenerGeolocalizacion();
                                        String imagenUser = "";

                                        if (imgFile != null) {
                                          List<int> imageBytes =
                                              imgFile.readAsBytesSync();
                                          imagenUser = base64Encode(imageBytes);
                                        }

                                        Document docCompany = new Document(
                                            cityId: ccem.getCity.id,
                                            number: nitController.text,
                                            type: 6);

                                        WoinLocationCompany wlc =
                                            new WoinLocationCompany(
                                          altitude: 0,
                                          createdAt: 0,
                                          id: 0,
                                          latitude: 0,
                                          longitude: 0,
                                          updatedAt: 0,
                                        );

                                        List<SocialProfiles> lsp = new List();

                                        SocialProfiles sp = new SocialProfiles(
                                          urlProfile: facebookController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp);
                                        SocialProfiles sp1 = new SocialProfiles(
                                          urlProfile: instagramController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp1);

                                        SocialProfiles sp2 = new SocialProfiles(
                                          urlProfile: twitterController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp2);

                                        SocialProfiles sp3 = new SocialProfiles(
                                          urlProfile: linkedController.text,
                                          woinSocialNetworkId: 1,
                                        );
                                        lsp.add(sp3);

                                        WoinLocationCompany wlc2 =
                                            new WoinLocationCompany(
                                          altitude:
                                              gl.getLocation.altitude.toInt(),
                                          createdAt: 0,
                                          id: 0,
                                          latitude:
                                              gl.getLocation.latitude.toInt(),
                                          longitude:
                                              gl.getLocation.longitude.toInt(),
                                          updatedAt: 0,
                                        );

                                        Device2 dv2 = new Device2(
                                            id: 0,
                                            ip: gl.getDevices.ip,
                                            mac: gl.getDevices.mac,
                                            name: gl.getDevices.name,
                                            state: gl.getDevices.state,
                                            createdAt: 0,
                                            updatedAt: 0,
                                            userId: 0);

                                        emWoiner em = new emWoiner(
                                            person: null,
                                            categoryId: categoriaSel.id,
                                            cityId: ccem.getCity.id,
                                            companyName: nombreEmpresa.text,
                                            dateCompanyCreate: myFormat
                                                .format(fechaCreacionEmpresa),
                                            device: dv2,
                                            documentCompany: docCompany,
                                            email: emailEmController.text,
                                            image: imagenUser,
                                            isDefault: 1,
                                            phones: phones,
                                            socialProfiles: lsp,
                                            userId: 0,
                                            webPage: paginaWebController.text,
                                            woinLocation: wlc2,
                                            woinLocationCompany: wlc,
                                            woinerType: type,
                                            biography:
                                                acercaEmpresaController.text);

                                        final woinerReg = await userService
                                            .registroEmWoiner(em);

                                        if (woinerReg.status) {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Cuenta creada correctamente.",
                                                      true));

                                          userdetalle sesion =
                                              new userdetalle();

                                          sesion.getSession.typeDefault = 3;
                                          List<WoinerType> lw = new List();
                                          lw.add(type);
                                          sesion.setCuentaActiva = 3;
                                          sesion.getSession.woinerType = lw;
                                          sesion.setTokenEm =
                                              woinerReg.entities[0].token;
                                          sesion.setImageEm = imagenUser;

                                          tipoUser.userSesionGSink.add(sesion);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabMain()),
                                          );
                                        } else {
                                          showDialogV2(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog2(
                                                      "Error al crear Emwoin",
                                                      false));
                                        }
                                      } else {
                                        showDialogV2(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog2(
                                                    "Complete los campos para continuar",
                                                    false));
                                      }
                                    }
                                  }
                                } //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void showBotomModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: MediaQuery.of(context).size.height * .18,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15)),
              ),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_alt, size: 30),
                    title: Text(
                      "Tomar foto",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                  Ink(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(
                        Icons.add_photo_alternate,
                        size: 30,
                      ),
                      title: Text(
                        "Ir a Galeria",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
*/
