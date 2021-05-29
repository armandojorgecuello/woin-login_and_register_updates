import 'package:flutter/material.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/services/Scope/countryService.dart';

Future<countryCity> showDialogUbicacion(
    BuildContext context, countryCity ccity) async {
  TextEditingController busquedaControllerp = TextEditingController();
  onpress() {
    Navigator.of(context).pop();
  }

  countryCity ubicacionSel = await showDialog<countryCity>(
      context: context,
      builder: (context) {
        int buscador = 0;
        int page = 1;
        countryCity respcity;
        if (ccity != null) {
          respcity = new countryCity();
          respcity.setCity = ccity.getCity;
          respcity.setCountry = ccity.getcountry;
        }

        String msj = "";
        int hb = 0;
        // print(ccity.getcountry.name);
        // print(ccity.getCity.name);

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                double ancho = MediaQuery.of(context).size.width;
                var widthScreen = MediaQuery.of(context).size.width;
                var heightScreen = MediaQuery.of(context).size.height;
                var _spacing = widthScreen * 0.03;
                var _crossAxisCount = 2;
                var width = ((widthScreen - (_crossAxisCount - 1) * _spacing)) /
                    _crossAxisCount;

                var celHeight = heightScreen * .106;
                var aspectratio = width / celHeight;
                ScrollController ctrl = PageController();
                var heightc = MediaQuery.of(context).size.height * .8;
                var widthc = MediaQuery.of(context).size.width;
                siguiente() {
                  if (respcity != null) {
                    ctrl.animateTo(MediaQuery.of(context).size.width * .9,
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeIn);
                    setState(() {
                      buscador = 0;
                      page = 2;
                      msj = "";
                    });
                    busquedaControllerp.clear();
                  } else {
                    showAlerts(context, "Seleccione un país para continuar",
                        false, onpress, null, "Aceptar", "", null);
                  }
                }

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
                      appBar: AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        titleSpacing: -20,
                        actions: <Widget>[
                          buscador == 0
                              ? IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    size: 18,
                                    color: Color(0xff97a4b1),
                                  ),
                                  alignment: Alignment.center,
                                  onPressed: () {
                                    setState(() {
                                      buscador = 1;
                                    });
                                  })
                              : SizedBox()
                        ],
                        leading: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            size: 18,
                            color: Color(0xff97a4b1),
                          ),
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            if ((page == 2 || page == 3) && buscador == 0) {
                              setState(() {
                                page = 1;
                                countryService.filterCountryB.add("");
                              });
                              ctrl.animateTo(0,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeIn);
                            } else if (page == 1 && buscador == 0) {
                              Navigator.pop(context);
                            } else if (buscador == 1) {
                              setState(() {
                                buscador = 0;
                                busquedaControllerp.clear();
                              });
                            }
                          },
                        ),
                        title: buscador == 0
                            ? titulo(page, context)
                            : buscadorp(
                                page, buscador, context, busquedaControllerp),
                      ),
                      body: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            respcity != null
                                ? Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          respcity == null
                                              ? SizedBox()
                                              : Card(
                                                  color: Colors.grey[100],
                                                  elevation: 4,
                                                  child: Container(
                                                    width: widthc * 0.38,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                widthc * 0.03,
                                                            vertical: heightc *
                                                                0.015),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          flex: 1,
                                                          child: Text(
                                                            respcity.getcountry
                                                                .name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Roboto",
                                                                color: Colors
                                                                    .grey[600],
                                                                fontSize: respcity
                                                                            .getcountry
                                                                            .name
                                                                            .length >
                                                                        10
                                                                    ? heightc *
                                                                        .018
                                                                    : heightc *
                                                                        .022),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          respcity == null
                                              ? SizedBox()
                                              : respcity.getCity == null
                                                  ? SizedBox()
                                                  : Card(
                                                      color: Colors.grey[100],
                                                      elevation: 4,
                                                      child: Container(
                                                        width: widthc * 0.38,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    widthc *
                                                                        0.03,
                                                                vertical:
                                                                    heightc *
                                                                        0.015),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Flexible(
                                                              flex: 1,
                                                              child: Text(
                                                                respcity.getCity
                                                                    .name,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    color: Colors
                                                                            .grey[
                                                                        600],
                                                                    fontSize: respcity.getCity.name.length >
                                                                            10
                                                                        ? heightc *
                                                                            .018
                                                                        : heightc *
                                                                            .022),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Expanded(
                              flex: 12,
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
                                          flex: 9,
                                          child: Container(
                                              color: Color(0xffecedee),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 9, left: 7, right: 7),
                                                child: Container(
                                                  child:
                                                      StreamBuilder<
                                                              List<Country>>(
                                                          stream: countryService
                                                              .CountryList,
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
                                                                                //color: Colors.lightGreen,
                                                                                height: heightc * 0.25,
                                                                                padding: EdgeInsets.all(0),
                                                                                width: MediaQuery.of(context).size.width * .43,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      hb = 0;
                                                                                      if (respcity == null) {
                                                                                        respcity = new countryCity();
                                                                                        respcity.setCity = null;
                                                                                        respcity.setCountry = snapshot.data[index];

                                                                                        countryService.obtenerCiudadPais(snapshot.data[index].id).then((r) {
                                                                                          if (r == 1) {
                                                                                            setState(() {
                                                                                              hb = 1;
                                                                                            });
                                                                                          }
                                                                                        });
                                                                                      } else {
                                                                                        respcity.setCountry = snapshot.data[index];

                                                                                        respcity.setCity = null;

                                                                                        countryService.obtenerCiudadPais(snapshot.data[index].id).then((r) {
                                                                                          if (r == 1) {
                                                                                            setState(() {
                                                                                              hb = 1;
                                                                                            });
                                                                                          }
                                                                                        });
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  child: Card(
                                                                                    elevation: (respcity != null && respcity.getcountry.id == snapshot.data[index].id) ? 5 : 0,
                                                                                    child: Padding(
                                                                                        padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                                                                                        child: Container(
                                                                                          //color: Colors.indigo,
                                                                                          padding: EdgeInsets.all(4),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: <Widget>[
                                                                                              Expanded(
                                                                                                  flex: 3,
                                                                                                  child: CircleAvatar(
                                                                                                    backgroundImage: NetworkImage(snapshot.data[index].flag),
                                                                                                  )),
                                                                                              Expanded(
                                                                                                flex: 7,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsets.only(left: snapshot.data[index].name.length > 8 ? 6 : 0),
                                                                                                  child: Text(
                                                                                                    snapshot.data[index].name,
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(color: (respcity != null && respcity.getcountry.id == snapshot.data[index].id) ? Color(0xff1ba6d2) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].name.length > 9 ? heightc * 0.021 : heightc * 0.025),
                                                                                                  ),
                                                                                                ),
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
                                          flex: buscador == 0 ? 2 : 3,
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
                                                            countryService
                                                                .filterCountryB
                                                                .add("");

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
                                                              children: <
                                                                  Widget>[
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
                                                            color: Color(
                                                                0xff1ba6d2),
                                                            onPressed: hb == 0
                                                                ? null
                                                                : siguiente),
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
                                                              List<Cities>>(
                                                          stream: countryService
                                                              .CityList,
                                                          builder: (Context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .hasData &&
                                                                snapshot.data
                                                                        .length ==
                                                                    0) {
                                                              msj =
                                                                  "Sin Registros";
                                                            }
                                                            return snapshot
                                                                        .hasData &&
                                                                    snapshot.data
                                                                            .length >
                                                                        0
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
                                                                                //color: Colors.lightGreen,
                                                                                height: heightc * 0.2,
                                                                                padding: EdgeInsets.all(0),
                                                                                width: MediaQuery.of(context).size.width * .43,
                                                                                child: GestureDetector(
                                                                                  onTap: () async {
                                                                                    setState(() {
                                                                                      respcity.setCity = snapshot.data[index];
                                                                                      respcity.setValido = 0;
                                                                                    });
                                                                                  },
                                                                                  child: Card(
                                                                                    elevation: respcity.getCity != null ? respcity.getCity.id == snapshot.data[index].id ? 5 : 0 : 0,
                                                                                    child: Padding(
                                                                                        padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                                                                        child: Container(
                                                                                          //color: Colors.indigo,
                                                                                          padding: EdgeInsets.all(4),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  snapshot.data[index].name,
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(color: respcity.getCity != null ? respcity.getCity.id == snapshot.data[index].id ? Color(0xff1ba6d2) : Color(0xffb7b7b7) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].name.length > 9 ? heightc * 0.021 : heightc * 0.025),
                                                                                                ),
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
                                                                : snapshot.hasData &&
                                                                        snapshot.data.length ==
                                                                            0
                                                                    ? Center(
                                                                        child: Text(
                                                                            msj),
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
                                                            countryService
                                                                .filterCountryB
                                                                .add("");
                                                            //countryService.filtercityB.add("");
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
                                                            if (respcity
                                                                    .getCity !=
                                                                null) {
                                                              countryService
                                                                  .filterCountryB
                                                                  .add("");

                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      respcity);
                                                            } else {
                                                              showAlerts(
                                                                  context,
                                                                  "Seleccione una ciudad para continuar",
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
                                ],
                              ),
                            ),
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

  if (ccity != null) {
    print("ACA=>" + ccity.getcountry.name);
  }

  return ubicacionSel;
}

Widget buscadorp(int page, int buscador, BuildContext context,
    TextEditingController busquedaControllerp) {
  return Container(
    margin: EdgeInsets.all(0),
    height: 28,
    child: Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 35, left: 0),
            child: TextFormField(
              onChanged: (value) {
                if (page == 1) {
                  countryService.filterCountryB.add(value);
                } else {
                  countryService.filtercityB.add(value);
                }
              },
              controller: busquedaControllerp,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              keyboardType: TextInputType.text,
              autocorrect: true,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                isDense: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffafafaf),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.cancel, color: Color(0xffafafaf)),
                ),

                hintText: page == 1 && buscador == 1
                    ? "Buscar país"
                    : "Buscar ciudad",
                hintStyle: TextStyle(
                    color: Color(0xffbcbcbc),
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                enabledBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Color(0xffc9c9c9))
                    // borderSide: new BorderSide(color: Colors.teal)
                    ),
                focusedBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Colors.grey[500])
                    // borderSide: new BorderSide(color: Colors.teal)
                    ),
                // labelText: 'Correo'
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget titulo(int page, BuildContext context) {
  return Text(
    page == 1
        ? "Seleccione País de Ubicación"
        : "Seleccione ciudad de ubicación",
    style: TextStyle(
        color: Color(0xff1ba6d2),
        fontSize: MediaQuery.of(context).size.height * 0.0195),
  );
}
