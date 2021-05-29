import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';

import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/services/Scope/countryService.dart';

Future<countryCity> showDialogFilterUbicacion(
    BuildContext context, countryCity ccity) async {
  TextEditingController busquedaControllerp = TextEditingController();
  onpress() {
    Navigator.of(context).pop();
  }

  countryCity ubicacionSel = await showDialog<countryCity>(
      context: context,
      builder: (context) {
        bool checkedValuep =
            ccity != null ? ccity.getcountry.id == -1 ? true : false : false;
        bool checkedValuec = ccity != null
            ? ccity.getCity != null
                ? ccity.getCity.id == -1 && ccity.getcountry.id != -1
                    ? true
                    : false
                : false
            : false;
        int buscador = 0;

        int visiblec = 1;
        countryCity respcity;
        if (ccity != null) {
          respcity = new countryCity();
          if (ccity.getcountry.id == -1) {
            Cities city = new Cities(id: -1, name: "Todo el país");
            respcity.setCity = city;
          } else {
            respcity.setCity = ccity.getCity;
          }
          respcity.setCountry = ccity.getcountry;
        }
        int page = 0;
        int hb = 0;
        if (ccity != null) {
          hb = 1;
        } else {
          hb = 0;
        }

        String msj = "";

        // print(ccity.getcountry.name);
        // print(ccity.getCity.name);

        return StatefulBuilder(builder: (context, setState) {
          KeyboardVisibilityNotification().addNewListener(
              onChange: (bool visible) {
            //print("ACA CARE VERGA");
            setState(() {
              visiblec = visible ? 0 : 1;
              //print(visiblec);
            });
            // print(MediaQuery.of(context).size.height);
          });

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
                  if (respcity != null && respcity.getcountry.id != -1) {
                    countryService.filtercityB.add("");
                    print("ENTRO");
                    countryService.obtenerCiudadPais(respcity.getcountry.id);
                    ctrl.animateTo(MediaQuery.of(context).size.width * .9,
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeIn);
                    setState(() {
                      buscador = 0;
                      page = 1;
                      msj = "";
                    });

                    busquedaControllerp.clear();
                  } else if (respcity == null) {
                    showAlerts(context, "Seleccione un país para continuar",
                        false, onpress, null, "Aceptar", "", null);
                  } else {
                    Navigator.of(context).pop(respcity);
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
                                    size: 22,
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
                            size: 30,
                            color: Color(0xff97a4b1),
                          ),
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            if ((page == 1) && buscador == 0) {
                              setState(() {
                                countryService.filterCountryB.add("");
                              });
                              ctrl.animateTo(0,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeIn);
                            } else if (page == 0 && buscador == 0) {
                              countryService.filterCountryB.add("");
                              countryService.filtercityB.add("");
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
                            page == 0
                                ? Expanded(
                                    flex: visiblec == 1 ? 2 : 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Checkbox(
                                                value: checkedValuep,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    checkedValuep = newValue;
                                                    if (newValue) {
                                                      if (respcity == null) {
                                                        respcity =
                                                            new countryCity();
                                                      }

                                                      Country c = new Country(
                                                          id: -1,
                                                          name:
                                                              "Todos los paises");
                                                      respcity.setCountry = c;
                                                      hb = 1;
                                                    } else {
                                                      if (respcity == null) {
                                                        respcity =
                                                            new countryCity();
                                                      }
                                                      respcity = null;

                                                      print(hb);
                                                    }
                                                  });
                                                },
                                                //  <-- leading Checkbox
                                              ),
                                              Text("Todos los países"),
                                            ],
                                          ),
                                        ),
                                        respcity != null &&
                                                respcity.getcountry != null
                                            ? respcity.getcountry.id != -1
                                                ? Expanded(
                                                    child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: ResponsiveFlutter
                                                                    .of(context)
                                                                .scale(7),
                                                            right: ResponsiveFlutter
                                                                    .of(context)
                                                                .scale(10)),
                                                        width: ancho * .45,
                                                        child: Card(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      visiblec ==
                                                                              1
                                                                          ? 8
                                                                          : 5,
                                                                  top: 2),
                                                          elevation: 5,
                                                          child: Center(
                                                            child: Text(
                                                              respcity
                                                                  .getcountry
                                                                  .name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  fontSize:
                                                                      respcity.getcountry.name.length >=
                                                                              15
                                                                          ? 10
                                                                          : 12),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                                : SizedBox()
                                            : SizedBox(),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    flex: visiblec == 1 ? 2 : 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Checkbox(
                                                value: checkedValuec,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    checkedValuec = newValue;
                                                    if (newValue) {
                                                      Cities city = new Cities(
                                                          id: -1,
                                                          name: "Todo el país");
                                                      respcity.setCity = city;
                                                    } else {
                                                      respcity.setCity = null;
                                                    }
                                                  });
                                                },
                                                //  <-- leading Checkbox
                                              ),
                                              Text("Todo el país"),
                                            ],
                                          ),
                                        ),
                                        respcity != null &&
                                                respcity.getCity != null
                                            ? respcity.getCity.id != -1
                                                ? Expanded(
                                                    child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: ResponsiveFlutter
                                                                    .of(context)
                                                                .scale(7),
                                                            right: ResponsiveFlutter
                                                                    .of(context)
                                                                .scale(10)),
                                                        width: ancho * .45,
                                                        child: Card(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      visiblec ==
                                                                              1
                                                                          ? 8
                                                                          : 5,
                                                                  top: 2),
                                                          elevation: 5,
                                                          child: Center(
                                                            child: Text(
                                                              respcity
                                                                  .getCity.name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  fontSize:
                                                                      respcity.getCity.name.length >=
                                                                              15
                                                                          ? 10
                                                                          : 12),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                                : SizedBox()
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                            Expanded(
                              flex: 18,
                              //height: heightc * .845,
                              child: PageView(
                                onPageChanged: (index) {
                                  setState(() {
                                    page = index;
                                  });
                                },
                                physics: NeverScrollableScrollPhysics(),
                                controller: ctrl,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 10,
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
                                                                                      checkedValuep = false;
                                                                                      checkedValuec = false;
                                                                                      if (respcity == null) {
                                                                                        respcity = new countryCity();
                                                                                        respcity.setCity = null;
                                                                                        respcity.setCountry = snapshot.data[index];
                                                                                      } else {
                                                                                        respcity.setCountry = snapshot.data[index];

                                                                                        respcity.setCity = null;
                                                                                        print("OBTENIENDO CIUDADES");
                                                                                        print(snapshot.data[index].id);
                                                                                        countryService.obtenerCiudadPais(snapshot.data[index].id).then((r) {
                                                                                          print(r);
                                                                                          if (r == 1) {
                                                                                            setState(() {
                                                                                              hb = 1;
                                                                                              print("HB=>" + hb.toString());
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
                                          flex: visiblec == 1 ? 2 : 3,
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
                                                            onPressed: respcity !=
                                                                        null &&
                                                                    hb == 0
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
                                          flex: 10,
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
                                                                                      checkedValuec = false;
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
                                          flex: visiblec == 1 ? 2 : 3,
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
    height: 32,
    child: Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 35, left: 0),
            child: TextFormField(
              onChanged: (value) {
                if (page == 0) {
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
                contentPadding: EdgeInsets.all(2),

                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffafafaf),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    busquedaControllerp.clear();
                    countryService.filterCountryB.add("");
                    countryService.filtercityB.add("");
                  },
                  child: Icon(Icons.cancel, color: Color(0xffafafaf)),
                ),

                hintText: page == 0 && buscador == 1
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
