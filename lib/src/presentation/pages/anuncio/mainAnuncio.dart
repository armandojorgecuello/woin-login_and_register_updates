import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncioSubcat.dart';
import 'package:woin/src/presentation/pages/principal/card_swiper.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/presentation/pages/usuario/Login.dart';

class mainAnuncio extends StatefulWidget {

  mainAnuncio({Key key}):super(key:UniqueKey());
  @override
  _mainAnuncioState createState() => _mainAnuncioState();
}

class _mainAnuncioState extends State<mainAnuncio> {
  int group = 1;
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
          return Future.value(false);
        },
      child: Scaffold(
          backgroundColor: Color(0xffe6e6e6),
          appBar: AppBar(
            brightness: Brightness.light,
            titleSpacing: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
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
                  /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TabMain()));*/
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: Icon(
                  Icons.chevron_left,
                  size: 35,
                  color: Color(
                    0xffbbbbbb,
                  ),
                ),
              ),
            ),
            elevation: 0,
            title: Text(
              "Subir Anuncio",
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,

                color: Color(0xff1ba6d2),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.017),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Pago",
                              style: TextStyle(
                                  color: Color(0xff7e7e7e),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.018),
                            ),
                            Radio(
                              value: 1,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: group,
                              onChanged: (v) {
                                setState(() {
                                  group = v;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Gratis",
                              style: TextStyle(
                                  color: Color(0xff7e7e7e),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.018),
                              softWrap: false,
                            ),
                            Radio(
                              value: 2,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: group,
                              onChanged: (v) {
                                setState(() {
                                  group = v;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Que desea ofrecer?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff848484),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: MediaQuery.of(context).size.height * 0.018),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 12,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 1;
                          });
                          String gr = (group == 1) ? "Pago" : "Gratis";
                          tipoAnuncio tp = new tipoAnuncio("Productos", gr,
                              Color(0xffa78cb7), Icons.local_mall);
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => anuncioSubcat(tipo:tp)))
                              .then((onValue) {
                            setState(() {
                              selected = -1;
                            });
                          });
                        },
                        child: Container(
                          //color: Colors.blue,
                          // color: Colors.blue,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .015,
                              top: MediaQuery.of(context).size.height * .005,
                              bottom: MediaQuery.of(context).size.height * .007),
                          margin: EdgeInsets.zero,
                          child: Card(
                            color: (selected == 1)
                                ? Color(0xffa78cb7)
                                : Colors.white,
                            semanticContainer: true,
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: RawMaterialButton(
                                    onPressed: null,
                                    elevation: 0,
                                    fillColor: Color(0xffe9e9e9),
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            .5 *
                                            .14),
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.local_mall,
                                      color: Color(0xffa78cb7),
                                      size: MediaQuery.of(context).size.height *
                                          .245 *
                                          .24,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Productos",
                                  style: TextStyle(
                                      color: Color(0xffa7a7a7),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "TrebuchetMS",
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .245 *
                                              0.08),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 2;
                          });
                          String gr = (group == 1) ? "Pago" : "Gratis";
                          tipoAnuncio tp = new tipoAnuncio("Servicios", gr,
                              Color(0xff4a98ff), Icons.lightbulb_outline);
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => anuncioSubcat(tipo:tp)))
                              .then((onValue) {
                            setState(() {
                              selected = -1;
                            });
                          });
                        },
                        child: Container(
                          //color:Colors.blue,

                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .015,
                              right: MediaQuery.of(context).size.width * .02,
                              top: MediaQuery.of(context).size.height * .005,
                              bottom: MediaQuery.of(context).size.height * .007),
                          child: Card(
                            color: (selected == 2)
                                ? Color(0xff4a98ff)
                                : Colors.white,
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: RawMaterialButton(
                                    onPressed: null,
                                    elevation: 0,
                                    fillColor: Color(0xffe9e9e9),
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            .5 *
                                            .14),
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.lightbulb_outline,
                                      color: Color(0xff4a98ff),
                                      size: MediaQuery.of(context).size.height *
                                          .245 *
                                          .24,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Servicios",
                                  style: TextStyle(
                                      color: Color(0xffa7a7a7),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "TrebuchetMS",
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .245 *
                                              .08),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 12,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 3;
                          });
                          String gr = (group == 1) ? "Pago" : "Gratis";
                          tipoAnuncio tp = new tipoAnuncio("Vehículos", gr,
                              Color(0xff86d2d0), Icons.directions_car);
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => anuncioSubcat(tipo:tp)))
                              .then((onValue) {
                            setState(() {
                              selected = -1;
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .015,
                              top: MediaQuery.of(context).size.height * .005,
                              bottom: MediaQuery.of(context).size.height * .007),
                          child: Card(
                            color:
                                selected == 3 ? Color(0xff86d2d0) : Colors.white,
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: RawMaterialButton(
                                    onPressed: null,
                                    elevation: 0,
                                    fillColor: Color(0xffe9e9e9),
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            .5 *
                                            .14),
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.directions_car,
                                      color: Color(0xff86d2d0),
                                      size: MediaQuery.of(context).size.height *
                                          .245 *
                                          .24,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Vehiculos",
                                  style: TextStyle(
                                      color: Color(0xffa7a7a7),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "TrebuchetMS",
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .245 *
                                              .08),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 4;
                          });

                          String gr = (group == 1) ? "Pago" : "Gratis";
                          tipoAnuncio tp = new tipoAnuncio("Inmuebles", gr,
                              Color(0xff00c0fc), Icons.location_city);
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => anuncioSubcat(tipo:tp)))
                              .then((onValue) {
                            setState(() {
                              selected = -1;
                            });
                          });
                        },
                        child: Container(
                          // color: Colors.grey,

                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .015,
                              right: MediaQuery.of(context).size.width * .02,
                              top: MediaQuery.of(context).size.height * .005,
                              bottom: MediaQuery.of(context).size.height * .007),

                          child: Card(
                            color:
                                selected == 4 ? Color(0xff00c0fc) : Colors.white,
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: RawMaterialButton(
                                    onPressed: null,
                                    elevation: 0,
                                    fillColor: Color(0xffe9e9e9),
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            .5 *
                                            .14),
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.location_city,
                                      color: Color(0xff00c0fc),
                                      size: MediaQuery.of(context).size.height *
                                          .245 *
                                          .24,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Inmuebles",
                                  style: TextStyle(
                                      color: Color(0xffa7a7a7),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "TrebuchetMS",
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .245 *
                                              .08),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 12,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 5;
                          });
                          String gr = (group == 1) ? "Pago" : "Gratis";
                          tipoAnuncio tp = new tipoAnuncio(
                            "Eventos",
                            gr,
                            Color(0xffe1a6dd),
                            Icons.cake,
                          );
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => anuncioSubcat(tipo:tp)))
                              .then((onValue) {
                            setState(() {
                              selected = -1;
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .02,
                              right: MediaQuery.of(context).size.width * .015,
                              top: MediaQuery.of(context).size.height * .005,
                              bottom: MediaQuery.of(context).size.height * .007),
                          child: Card(
                            color:
                                selected == 5 ? Color(0xffe1a6dd) : Colors.white,
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: RawMaterialButton(
                                    onPressed: null,
                                    elevation: 0,
                                    fillColor: Color(0xffe9e9e9),
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            .5 *
                                            .14),
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.cake,
                                      color: Color(0xffe1a6dd),
                                      size: MediaQuery.of(context).size.height *
                                          .245 *
                                          .24,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Eventos",
                                  style: TextStyle(
                                      color: Color(0xffa7a7a7),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "TrebuchetMS",
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .25 *
                                              .08),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          String gr = (group == 1) ? "Pago" : "Gratis";
                          tipoAnuncio tp = new tipoAnuncio(
                            "Todos",
                            gr,
                            Color(0xffe1a6dd),
                            Icons.cake,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => anuncioSubcat(tipo:tp)));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .015,
                              right: MediaQuery.of(context).size.width * .02,
                              top: MediaQuery.of(context).size.height * .005,
                              bottom: MediaQuery.of(context).size.height * .007),
                          child: Card(
                            color: selected == 5
                                ? Color(0xffe1a6dd)
                                : Colors.grey[200],
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: RawMaterialButton(
                                    onPressed: null,
                                    elevation: 0,
                                    fillColor: Colors.grey[300],
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            .5 *
                                            .14),
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.crop_square,
                                      color: Colors.grey[500],
                                      size: MediaQuery.of(context).size.height *
                                          .245 *
                                          .24,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Todos",
                                  style: TextStyle(
                                      color: Color(0xffa7a7a7),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "TrebuchetMS",
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .25 *
                                              .08),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              )
            ],
          ),
        ),
    );

  }
}
