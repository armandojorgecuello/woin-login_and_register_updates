import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/services/Vehicles/vehicles.dart';
import 'package:woin/src/services/Vehicles/vehiclesBloc.dart';
import 'package:woin/src/services/avatars/avatarsBloc.dart';
import 'package:woin/src/services/avatars/avatarsJson.dart';
import 'package:woin/src/services/avatars/respSeguridad.dart';
import 'package:flutter/material.dart';
import 'package:woin/src/services/preguntaSeguridad/preguntaSeguridadBloc.dart';
import 'package:woin/src/services/preguntaSeguridad/preguntaSeguridadJson.dart';

Future<respSeguridad> showDialogSeguridad(
    BuildContext context, respSeguridad rs) async {
  var altura = MediaQuery.of(context).size.height;
  var ancho = MediaQuery.of(context).size.width;
  var widthScreen = MediaQuery.of(context).size.width;
  var heightScreen = MediaQuery.of(context).size.height;
  var _spacing = widthScreen * 0.03;
  var _crossAxisCount = 2;
  var celHeight = heightScreen * .08 + 30;
  var width =
      ((widthScreen - (_crossAxisCount - 1) * _spacing)) / _crossAxisCount;
  var aspectratio = width / celHeight;
  respSeguridad selectedSeguridad = await showDialog<respSeguridad>(
      context: context,
      builder: (context) {
        respSeguridad resp = rs;
        int page = 1;
        int p2 = rs == null ? 1 : 3;
        int buscador = 0;
        int visiblet = 1;

        TextEditingController respuestaController = new TextEditingController();

        respuestaController.text = rs == null ? "" : rs.respuesta;

        ScrollController ctrl = PageController();
        onpress() {
          Navigator.of(context).pop();
        }

        return StatefulBuilder(builder: (context, setState) {
          KeyboardVisibilityNotification().addNewListener(
              onChange: (bool visible) {
            //print("ACA CARE VERGA");
            setState(() {
              visiblet = visible ? 0 : 1;
              //print(visiblec);
            });
            // print(MediaQuery.of(context).size.height);
            print(visiblet);
          });

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                var heightc = MediaQuery.of(context).size.height * .8;
                var widthc = MediaQuery.of(context).size.width;
                return Container(
                    width: widthc,
                    height: heightc,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Scaffold(
                        resizeToAvoidBottomInset: false,
                        appBar: AppBar(
                          centerTitle: true,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          titleSpacing: -20,
                          leading: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 18,
                              color: Color(0xff97a4b1),
                            ),
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              if (page == 2 || page == 3) {
                                setState(() {
                                  page = 1;
                                });
                                ctrl.animateTo(0,
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.easeIn);
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                          title: Text(
                            "Configurar Seguridad",
                            style: TextStyle(
                                color: Color(0xff1ba6d2),
                                fontSize: heightc * 0.025),
                          ),
                          actions: <Widget>[
                            resp != null && resp.avatarsel != null
                                ? Padding(
                                    padding: EdgeInsets.only(right: 15, top: 4),
                                    child: Container(
                                      width: 50,
                                      height: 20,
                                      child: Icon(
                                        resp != null && resp.avatarsel != null
                                            ? resp.avatarsel.icono
                                            : null,
                                        size: 28,
                                        color: resp != null &&
                                                resp.avatarsel != null
                                            ? resp.avatarsel.color
                                            : Colors.transparent,
                                      ),
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                        body: Column(
                          children: <Widget>[
                            Container(
                              height: (page == 2 || page == 3) && resp != null
                                  ? resp.pregunta != null
                                      ? resp.pregunta.length > 46
                                          ? heightc * .13
                                          : heightc * .12
                                      : heightc * .08
                                  : heightc * 0.08,
                              color: Colors.white,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: widthc * 0.05,
                                                right: widthc * 0.05,
                                                bottom: resp != null
                                                    ? resp.pregunta != null
                                                        ? resp.pregunta.length >
                                                                46
                                                            ? heightc * 0.018
                                                            : heightc * 0.020
                                                        : heightc * 0.02
                                                    : heightc * 0.02),
                                            child: page == 1
                                                ? Text("Seleccionar Avatar",
                                                    style: TextStyle(
                                                        fontSize:
                                                            heightc * 0.025))
                                                : page == 3 ||
                                                        (page == 2 &&
                                                            resp.pregunta !=
                                                                null)
                                                    ? Text(resp.pregunta,
                                                        style: TextStyle(
                                                            fontSize: resp
                                                                        .pregunta
                                                                        .length >
                                                                    42
                                                                ? heightc *
                                                                    0.022
                                                                : heightc *
                                                                    0.025))
                                                    : resp != null
                                                        ? resp.pregunta !=
                                                                    null &&
                                                                page == 4
                                                            ? Text(
                                                                "Pregunta de seguridad",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        heightc *
                                                                            0.025))
                                                            : Text(
                                                                "Seleccionar pregunta",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        heightc *
                                                                            0.025),
                                                              )
                                                        : Text(
                                                            "Seleccionar pregunta",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    heightc *
                                                                        0.025),
                                                          ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    (page == 2 || page == 3) && resp != null
                                        ? resp.pregunta != null
                                            ? SizedBox(
                                                height: heightc * .05,
                                                width: widthc * .85,
                                                child: TextField(
                                                  controller:
                                                      respuestaController,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: heightc * .025),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  autocorrect: true,
                                                  autofocus: false,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(10),

                                                    labelText:
                                                        'Responder pregunta',

                                                    // fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.grey[400]),
                                                    enabledBorder:
                                                        new OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  50.0),
                                                            ),
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
                                              )
                                            : SizedBox()
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              //height: heightc * .845,
                              child: PageView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: ctrl,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                              color: Color(0xffecedee),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 9, left: 7, right: 7),
                                                child: Container(
                                                  child:
                                                      StreamBuilder<
                                                              List<Avatar>>(
                                                          stream: avatarsbloc
                                                              .AvatarList,
                                                          builder: (Context,
                                                              snapshot) {
                                                            return snapshot
                                                                    .hasData
                                                                ? GridView
                                                                    .builder(
                                                                    gridDelegate:
                                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          _crossAxisCount,
                                                                      childAspectRatio:
                                                                          aspectratio,
                                                                    ),
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        snapshot
                                                                            .data
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return Container(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                                //color:Colors.lightGreen,
                                                                                padding: EdgeInsets.all(0),
                                                                                width: MediaQuery.of(context).size.width * .43,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      if (resp == null) {
                                                                                        resp = new respSeguridad();
                                                                                        resp.addAvatar = snapshot.data[index];
                                                                                      } else {
                                                                                        resp.addAvatar = snapshot.data[index];
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  child: Card(
                                                                                    elevation: (resp != null && resp.avatarsel.name == snapshot.data[index].name) ? 5 : 0,
                                                                                    child: Padding(
                                                                                        padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                                                                        child: Container(
                                                                                          //color: Colors.indigo,
                                                                                          padding: EdgeInsets.all(4),
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: <Widget>[
                                                                                              Container(
                                                                                                child: Icon(
                                                                                                  snapshot.data[index].icono,
                                                                                                  size: resp != null && resp.avatarsel.name == snapshot.data[index].name ? 45 : 38,
                                                                                                  color: snapshot.data[index].color,
                                                                                                ),
                                                                                                padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: widthc * 0.015,
                                                                                              ),
                                                                                              Text(
                                                                                                snapshot.data[index].name,
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(color: (resp != null && resp.avatarsel.name == snapshot.data[index].name) ? Color(0xff1ba6d2) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].name.length > 9 ? heightc * 0.021 : heightc * 0.025),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        )),
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide.none),
                                                                                  ),
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  )
                                                                : Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                          }),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            child: Container(
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      width: widthc * .35,
                                                      height: heightc * .075,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: ancho *
                                                                    .03),
                                                        child: RaisedButton(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Icon(Icons.close,
                                                                  size: 20,
                                                                  color: Color(
                                                                      0xff1ba6d2)),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                'Cancelar',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    color: Color(
                                                                        0xff1ba6d2),
                                                                    fontSize:
                                                                        heightc *
                                                                            0.025),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  right: 30,
                                                                  top: 12,
                                                                  bottom: 12),
                                                          color: Colors.white,
                                                          elevation: 0,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);

                                                            // print(username);

                                                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: ancho * 0.02),
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      width: widthc * .35,
                                                      height: heightc * .075,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: ancho *
                                                                    .03),
                                                        child: RaisedButton(
                                                          elevation: 0,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                'Siguiente',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        heightc *
                                                                            0.025),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .chevron_right,
                                                                size: 20,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ],
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  right: 30,
                                                                  top: 12,
                                                                  bottom: 12),
                                                          color:
                                                              Color(0xff1ba6d2),
                                                          onPressed: () {
                                                            if (resp != null) {
                                                              ctrl.animateTo(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .9,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          800),
                                                                  curve: Curves
                                                                      .easeIn);
                                                              setState(() {
                                                                page = 2;
                                                              });
                                                            } else {
                                                              showAlerts(
                                                                  context,
                                                                  "Seleccione un avatar para continuar..",
                                                                  false,
                                                                  onpress,
                                                                  null,
                                                                  "Aceptar",
                                                                  "",
                                                                  null);
                                                            }

                                                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flex(
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height:
                                                    (page == 2 || page == 3) &&
                                                            resp != null
                                                        ? resp.pregunta != null
                                                            ? visiblet == 0
                                                                ? heightc * .35
                                                                : heightc * .64
                                                            : heightc * .71
                                                        : heightc * .71,
                                                color: Color(0xffecedee),
                                                child: Container(
                                                  //color: Colors.amber,
                                                  padding: EdgeInsets.only(
                                                      top: heightc * .016,
                                                      bottom: heightc * .016),
                                                  child: StreamBuilder<
                                                          List<Question>>(
                                                      stream: preguntasbloc
                                                          .preguntaList,
                                                      builder:
                                                          (Context, snapshot) {
                                                        return snapshot.hasData
                                                            ? GridView.builder(
                                                                gridDelegate:
                                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      1,
                                                                  childAspectRatio: (widthc *
                                                                          .85) /
                                                                      (heightc *
                                                                          .11),
                                                                ),
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    snapshot
                                                                        .data
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          //color:Colors.lightGreen,
                                                                          padding:
                                                                              EdgeInsets.all(0),
                                                                          width:
                                                                              widthc * .85,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (resp != null) {
                                                                                  resp.pregunta = snapshot.data[index].question;
                                                                                  page = 3;
                                                                                  resp.idpregunta = snapshot.data[index].id;
                                                                                  respuestaController.text = "";
                                                                                  resp.size = resp.pregunta.length > 46 ? 12 : 14;
                                                                                }
                                                                              });
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              height: heightc * .104,
                                                                              child: Card(
                                                                                elevation: (resp != null && resp.pregunta == snapshot.data[index].question) ? 5 : 0,
                                                                                child: Container(
                                                                                  //color: Colors.indigo,

                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: <Widget>[
                                                                                      Expanded(
                                                                                          child: Padding(
                                                                                        padding: EdgeInsets.all(6),
                                                                                        child: Text(
                                                                                          snapshot.data[index].question,
                                                                                          textAlign: snapshot.data[index].question.length < 32 ? TextAlign.center : TextAlign.justify,
                                                                                          style: TextStyle(color: (resp != null && resp.pregunta == snapshot.data[index].question) ? Color(0xff1ba6d2) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].question.length > 30 ? heightc * 0.022 : heightc * 0.025),
                                                                                        ),
                                                                                      )),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide.none),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              )
                                                            : Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: heightc * .137,
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: widthc * .40,
                                                  height: heightc * .075,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: widthc * .03),
                                                    child: RaisedButton(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(Icons.close,
                                                              size: 20,
                                                              color: Color(
                                                                  0xff1ba6d2)),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            'Cancelar',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Roboto",
                                                                color: Color(
                                                                    0xff1ba6d2),
                                                                fontSize:
                                                                    heightc *
                                                                        0.025),
                                                          )
                                                        ],
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          left: 30,
                                                          right: 30,
                                                          top: 12,
                                                          bottom: 12),
                                                      color: Colors.white,
                                                      elevation: 0,
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();

                                                        // print(username);

                                                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: widthc * .02),
                                              Flexible(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: widthc * .43,
                                                  height: heightc * .075,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: widthc * .03),
                                                    child: RaisedButton(
                                                        elevation: 0,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              'Siguiente',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      heightc *
                                                                          0.025),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  widthc * .01,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 30,
                                                                top: 12,
                                                                bottom: 12),
                                                        color:
                                                            Color(0xff1ba6d2),
                                                        onPressed: () {
                                                          if (resp != null &&
                                                              resp.pregunta !=
                                                                  null &&
                                                              respuestaController
                                                                      .text !=
                                                                  null &&
                                                              respuestaController
                                                                      .text !=
                                                                  "") {
                                                            resp.respuesta =
                                                                respuestaController
                                                                    .text;

                                                            Navigator.of(
                                                                    context)
                                                                .pop(resp);
                                                          } else {
                                                            showAlerts(
                                                                context,
                                                                "Seleccione o responda la pregunta de seguridad.",
                                                                false,
                                                                onpress,
                                                                null,
                                                                "Aceptar",
                                                                "",
                                                                null);
                                                          }

                                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                        }),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          );
        });
      });
  return selectedSeguridad;
}

Future<Vehicle> showDialogVehicle(BuildContext context, Vehicle v) async {
  var altura = MediaQuery.of(context).size.height;
  var ancho = MediaQuery.of(context).size.width;
  var widthScreen = MediaQuery.of(context).size.width;
  var heightScreen = MediaQuery.of(context).size.height;
  var _spacing = widthScreen * 0.03;
  var _crossAxisCount = 2;
  var celHeight = heightScreen * .08 + 30;
  var width =
      ((widthScreen - (_crossAxisCount - 1) * _spacing)) / _crossAxisCount;
  var aspectratio = width / celHeight;
  Vehicle selectedVehicle = await showDialog<Vehicle>(
      context: context,
      builder: (context) {
        Vehicle resp = v;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                var heightc = MediaQuery.of(context).size.height * .8;
                var widthc = MediaQuery.of(context).size.width;
                return Container(
                  width: widthc,
                  height: heightc,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.all(0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        titleSpacing: -20,
                        leading: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            size: 18,
                            color: Color(0xff97a4b1),
                          ),
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        title: Text(
                          "Tipo de Vehículo",
                          style:
                              TextStyle(color: Color(0xff1ba6d2), fontSize: 16),
                        ),
                      ),
                      body: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: heightc * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      left: widthc * 0.02,
                                      right: widthc * 0.02),
                                  child: Text(
                                    "Seleccionar Tipo de vehículo",
                                    style: TextStyle(fontSize: heightc * 0.025),
                                  ),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: heightc * 0.03,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        height: heightc * .74,
                                        color: Color(0xffecedee),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: heightc * 0.02,
                                              left: width * .03,
                                              right: width * .03),
                                          child: Container(
                                            child: StreamBuilder<List<Vehicle>>(
                                                stream:
                                                    vehiclesBloC.vehicelsList,
                                                builder: (Context, snapshot) {
                                                  return snapshot.hasData
                                                      ? GridView.builder(
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            childAspectRatio:
                                                                widthc *
                                                                    .85 /
                                                                    (heightc *
                                                                        0.17),
                                                          ),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: snapshot
                                                              .data.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                      //color:Colors.lightGreen,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .43,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            resp =
                                                                                snapshot.data[index];
                                                                          });
                                                                        },
                                                                        child:
                                                                            Card(
                                                                          elevation: (resp != null && resp.name == snapshot.data[index].name)
                                                                              ? 5
                                                                              : 0,
                                                                          child: Padding(
                                                                              padding: EdgeInsets.only(left: 0, right: 0, top: heightc * .014, bottom: heightc * .014),
                                                                              child: Container(
                                                                                //color: Colors.indigo,
                                                                                padding: EdgeInsets.all(4),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      snapshot.data[index].name,
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(color: (resp != null && resp.name == snapshot.data[index].name) ? Color(0xff1ba6d2) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].name.length > heightc * 0.022 ? heightc * 0.022 : heightc * 0.025),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              side: BorderSide.none),
                                                                        ),
                                                                      ))
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                }),
                                          ),
                                        )),
                                    Expanded(
                                        child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: SizedBox(
                                              height: heightc * .075,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: widthc * 0.03),
                                                child: RaisedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(Icons.close,
                                                          size: 20,
                                                          color: Color(
                                                              0xff1ba6d2)),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        'Cancelar',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            color: Color(
                                                                0xff1ba6d2),
                                                            fontSize: heightc *
                                                                0.025),
                                                      ),
                                                    ],
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 12,
                                                      bottom: 12),
                                                  color: Colors.white,
                                                  elevation: 0,
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    // print(username);

                                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: widthc * 0.03),
                                          Expanded(
                                              child: SizedBox(
                                            height: heightc * 0.075,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: widthc * .03),
                                              child: RaisedButton(
                                                  elevation: 0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Siguiente',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            color: Colors.white,
                                                            fontSize: heightc *
                                                                0.025),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Icon(
                                                        Icons.chevron_right,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  padding: EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 12,
                                                      bottom: 12),
                                                  color: Color(0xff1ba6d2),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(resp);

                                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                  }),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
      });
  return selectedVehicle;
}
