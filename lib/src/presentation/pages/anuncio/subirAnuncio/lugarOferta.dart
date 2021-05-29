import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/services/Scope/countryService.dart';

class lugarOferta extends StatefulWidget {
  lugarOfertaAnuncio lugarAnuncio;
  int tipoAnuncio;
  lugarOferta({this.lugarAnuncio, this.tipoAnuncio});

  @override
  _lugarOfertaState createState() => _lugarOfertaState();
}

class _lugarOfertaState extends State<lugarOferta> {
  Country paiss;
  Governorates gs;
  Cities cs;
  int errPais = 0;
  int errGover = 0;
  int errcity = 0;
  List<Governorates> lg = new List();
  List<Cities> lc = new List();
  @override
  void initState() {
    super.initState();
    if (widget.lugarAnuncio != null) {
      //print("DIFERENTE DE NULL");

      paiss = widget.lugarAnuncio.pais;
      if (paiss.id != 1000) {
        lg.addAll(paiss.governorates);
        gs = widget.lugarAnuncio.depto;

        if (gs.id != 1000) {
          lc.addAll(gs.cities);
        }

        cs = widget.lugarAnuncio.city;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var _spacing = widthScreen * 0.03;
    var _crossAxisCount = 2;
    var width =
        ((widthScreen - (_crossAxisCount - 1) * _spacing)) / _crossAxisCount;
    var celHeight = heightScreen * .106;
    var aspectratio = width / celHeight;

    Future<List<Country>> listaPaises() async {
      final countriesl = await countryService.httpGetCountries();
      return countriesl; //print("resp1=>"+lp1.length.toString());
    }

    Future<Country> _showDialogP(BuildContext context, Country p) async {
      Country selectedPais = await showDialog<Country>(
          context: context,
          builder: (context) {
            Country pais = p;
            int buscador = 0;
            int visiblec = 1;
            bool checkedValue = p != null ? p.id == 1000 ? true : false : false;
            TextEditingController busquedaControllerp = TextEditingController();

            return StatefulBuilder(builder: (context, setState) {
              Widget buscadorp() {
                return Container(
                  margin: EdgeInsets.all(0),
                  height: 28,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 40, left: 0),
                          child: TextFormField(
                            onChanged: (value) {
                              countryService.filterCountryB.add(value);
                            },
                            controller: busquedaControllerp,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              isDense: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xffafafaf),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  busquedaControllerp.clear();
                                },
                                child: Icon(Icons.cancel,
                                    color: Color(0xffafafaf)),
                              ),

                              hintText: "Buscar país",
                              hintStyle: TextStyle(
                                  color: Color(0xffbcbcbc),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xffc9c9c9))
                                  // borderSide: new BorderSide(color: Colors.teal)
                                  ),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[500])
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

              KeyboardVisibilityNotification().addNewListener(
                  onChange: (bool visible) {
                //print("ACA CARE VERGA");
                setState(() {
                  visiblec = visible ? 0 : 1;
                  //print(visiblec);
                });
                // print(MediaQuery.of(context).size.height);
              });

              Widget titulo() {
                return Text(
                  "Seleccione País de Ubicación",
                  style: TextStyle(
                      color: Color(0xff1ba6d2),
                      fontSize: MediaQuery.of(context).size.height * 0.0195),
                );
              }

              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.all(0),
                content: Builder(
                  builder: (context) {
                    var heightc = MediaQuery.of(context).size.height * .8;
                    var widthc = MediaQuery.of(context).size.width;
                    double ancho = MediaQuery.of(context).size.width;
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
                              actions: <Widget>[
                                buscador == 0
                                    ? InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        onTap: () {
                                          setState(() {
                                            buscador = 1;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 9),
                                          width: 60,
                                          child: Icon(
                                            Icons.search,
                                            size: 25,
                                            color: Color(0xff97a4b1),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                              leading: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                onTap: () {
                                  if (buscador == 1) {
                                    countryService.filterCountryB.add("");

                                    busquedaControllerp.clear();
                                    setState(() {
                                      buscador = 0;
                                    });
                                  } else {
                                    countryService.filterCountryB.add("");

                                    busquedaControllerp.clear();
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: 25,
                                    color: Color(0xff97a4b1),
                                  ),
                                ),
                              ),
                              title: buscador == 0 ? titulo() : buscadorp(),
                            ),
                            body: Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  this.widget.tipoAnuncio == 2 &&
                                              pais != null ||
                                          this.widget.tipoAnuncio == 1
                                      ? Expanded(
                                          flex: visiblec == 1 ? 2 : 3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              this.widget.tipoAnuncio == 1
                                                  ? Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Checkbox(
                                                            value: checkedValue,
                                                            onChanged:
                                                                (newValue) {
                                                              setState(() {
                                                                checkedValue =
                                                                    newValue;
                                                                if (newValue) {
                                                                  pais = null;
                                                                }
                                                              });
                                                            },
                                                            //  <-- leading Checkbox
                                                          ),
                                                          Text("Todos"),
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              pais != null
                                                  ? pais.id != 1000
                                                      ? Expanded(
                                                          child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                  left: ResponsiveFlutter.of(
                                                                          context)
                                                                      .scale(7),
                                                                  right: ResponsiveFlutter.of(
                                                                          context)
                                                                      .scale(
                                                                          10)),
                                                              width: this
                                                                          .widget
                                                                          .tipoAnuncio ==
                                                                      1
                                                                  ? ancho * .45
                                                                  : ancho * .35,
                                                              child: Card(
                                                                margin: EdgeInsets.only(
                                                                    bottom:
                                                                        visiblec ==
                                                                                1
                                                                            ? 8
                                                                            : 5,
                                                                    top: 2),
                                                                elevation: 5,
                                                                child: Center(
                                                                  child: Text(
                                                                    pais.name,
                                                                    style: TextStyle(
                                                                        color: Colors.grey[
                                                                            500],
                                                                        fontSize: pais.name.length >=
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
                                      : SizedBox(),
                                  Expanded(
                                    flex: 18,
                                    child: Container(
                                        color: Color(0xffecedee),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 9, left: 7, right: 7),
                                          child: Container(
                                            child: StreamBuilder<List<Country>>(
                                                stream:
                                                    countryService.CountryList,
                                                builder: (Context, snapshot) {
                                                  return snapshot.hasData
                                                      ? GridView.builder(
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                                _crossAxisCount,
                                                            childAspectRatio:
                                                                aspectratio,
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
                                                                      //color: Colors.lightGreen,
                                                                      height:
                                                                          heightc *
                                                                              0.25,
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
                                                                            pais =
                                                                                snapshot.data[index];
                                                                            checkedValue =
                                                                                false;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Card(
                                                                          elevation: (pais != null && pais.id == snapshot.data[index].id)
                                                                              ? 5
                                                                              : 0,
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
                                                                                          style: TextStyle(color: (pais != null && pais.id == snapshot.data[index].id) ? Color(0xff1ba6d2) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].name.length > 9 ? heightc * 0.021 : heightc * 0.025),
                                                                                        ),
                                                                                      ),
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
                                  ),
                                  Expanded(
                                    flex: visiblec == 1 ? 3 : 4,
                                    child: SizedBox(
                                      child: Container(

                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(top: BorderSide(color: Colors.grey[100],width: 1))
                                        ),
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
                                                  padding: EdgeInsets.only(
                                                      left: ancho * .03),
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
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                      countryService
                                                          .filterCountryB
                                                          .add("");

                                                      Navigator.pop(context);

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
                                                  padding: EdgeInsets.only(
                                                      right: ancho * .03),
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
                                                            textAlign: TextAlign
                                                                .center,
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
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                      padding: EdgeInsets.only(
                                                          left: 30,
                                                          right: 30,
                                                          top: 12,
                                                          bottom: 12),
                                                      color: Color(0xff1ba6d2),
                                                      onPressed: () {
                                                        countryService
                                                            .filterCountryB
                                                            .add("");
                                                        if (checkedValue) {
                                                          pais = new Country(
                                                              id: 1000,
                                                              name:
                                                                  "Todos los países");
                                                        }
                                                        Navigator.of(context)
                                                            .pop(pais);
                                                      }),
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
                          ),
                        ));
                  },
                ),
              );
            });
          });
      return selectedPais;
    }

    Future<Governorates> _showDialogG(
        BuildContext context, Governorates go) async {
      Governorates selectedg = await showDialog<Governorates>(
          context: context,
          builder: (context) {
            Governorates g = go;
            int visiblec = 1;
            bool checkedValue =
                go != null ? go.id != 1000 ? false : true : false;

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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.all(0),
                content: Builder(
                  builder: (context) {
                    var heightc = MediaQuery.of(context).size.height * .8;
                    var widthc = MediaQuery.of(context).size.width;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: widthc,
                      height: heightc,
                      margin: EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Scaffold(
                          appBar: AppBar(
                              centerTitle: true,
                              backgroundColor: Colors.white,
                              elevation: 0,
                              titleSpacing: 0,
                              leading: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  width: 50,
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: 25,
                                    color: Color(0xff97a4b1),
                                  ),
                                ),
                              ),
                              title: Text(
                                "Seleccione Departamento",
                                style: TextStyle(
                                    color: Color(0xff1ba6d2),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.0195),
                              )),
                          body: Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                this.widget.tipoAnuncio == 2 && g != null ||
                                        this.widget.tipoAnuncio == 1
                                    ? Expanded(
                                        flex: visiblec == 1 ? 2 : 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            this.widget.tipoAnuncio == 1
                                                ? Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Checkbox(
                                                          value: checkedValue,
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              checkedValue =
                                                                  newValue;
                                                              if (newValue) {
                                                                g = null;
                                                              }
                                                            });
                                                          },
                                                          //  <-- leading Checkbox
                                                        ),
                                                        Text("Todos"),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            g != null
                                                ? g.id != 1000
                                                    ? Expanded(
                                                        child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: ResponsiveFlutter.of(
                                                                        context)
                                                                    .scale(7),
                                                                right: ResponsiveFlutter.of(
                                                                        context)
                                                                    .scale(10)),
                                                            width: this
                                                                        .widget
                                                                        .tipoAnuncio ==
                                                                    1
                                                                ? widthc * .45
                                                                : widthc * .35,
                                                            child: Card(
                                                              margin: EdgeInsets.only(
                                                                  bottom:
                                                                      visiblec ==
                                                                              1
                                                                          ? 8
                                                                          : 5,
                                                                  top: 2),
                                                              elevation: 5,
                                                              child: Center(
                                                                child: Text(
                                                                  toBeginningOfSentenceCase(g
                                                                      .name
                                                                      .toLowerCase()),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      fontSize: g.name.length >=
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
                                    : SizedBox(),
                                Expanded(
                                  flex: 18,
                                  child: Container(
                                      color: Color(0xffecedee),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 9, left: 7, right: 7),
                                        child: Container(
                                          child: lg.length > 0
                                              ? GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        _crossAxisCount,
                                                    childAspectRatio:
                                                        aspectratio,
                                                  ),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: lg.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .43,
                                                              height:
                                                                  aspectratio *
                                                                      65,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    g = lg[
                                                                        index];
                                                                    checkedValue =
                                                                        false;
                                                                    // print("GOVER=>"+g.id.toString());
                                                                  });
                                                                },
                                                                child: Card(
                                                                  elevation: g !=
                                                                              null &&
                                                                          g.id ==
                                                                              lg[index].id
                                                                      ? 5
                                                                      : 0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      toBeginningOfSentenceCase(lg[
                                                                              index]
                                                                          .name
                                                                          .toLowerCase()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color: g != null && g.id == lg[index].id
                                                                              ? Color(
                                                                                  0xff1ba6d2)
                                                                              : Color(
                                                                                  0xffb7b7b7),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontFamily:
                                                                              "TrebuchetMS",
                                                                          fontSize: lg[index].name.length > 15
                                                                              ? 11
                                                                              : 14),
                                                                    ),
                                                                  ),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      side: BorderSide
                                                                          .none),
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
                                                ),
                                        ),
                                      )),
                                ),
                                Expanded(
                                    flex: visiblec == 1 ? 3 : 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(top: BorderSide(color: Colors.grey[100],width: 1))
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
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
                                                        width: widthc * 0.03,
                                                      ),
                                                      Text(
                                                        'Cancelar',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            color: Color(
                                                                0xff1ba6d2),
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.0195),
                                                      )
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
                                                  }),
                                            ),
                                          ),
                                          SizedBox(width: widthc * 0.03),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: widthc * 0.03),
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
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.0195),
                                                      ),
                                                      SizedBox(
                                                        width: widthc * 0.03,
                                                      ),
                                                      Icon(
                                                        Icons.chevron_right,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.0195,
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
                                                    if (checkedValue) {
                                                      g = new Governorates(
                                                          id: 1000,
                                                          name: "Todo el país");
                                                    }
                                                    Navigator.of(context)
                                                        .pop(g);
                                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
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
      return selectedg;
    }

    Future<Cities> _showDialogC(BuildContext context, Cities ct) async {
      Cities selectedc = await showDialog<Cities>(
          context: context,
          builder: (context) {
            Cities c = ct;
            int visiblec = 1;
            bool checkedValue = c != null ? c.id != 1000 ? false : true : false;
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.all(0),
                content: Builder(
                  builder: (context) {
                    var heightc = MediaQuery.of(context).size.height * .8;
                    var widthc = MediaQuery.of(context).size.width;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: widthc,
                      height: heightc,
                      margin: EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Scaffold(
                          backgroundColor: Colors.white,
                          appBar: AppBar(
                              centerTitle: true,
                              backgroundColor: Colors.white,
                              elevation: 0,
                              titleSpacing: 0,
                              leading: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  width: 50,
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: 25,
                                    color: Color(0xff97a4b1),
                                  ),
                                ),
                              ),
                              title: Text(
                                "Seleccione Ciudad de Ubicación",
                                style: TextStyle(
                                    color: Color(0xff1ba6d2),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.0195),
                              )),
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              this.widget.tipoAnuncio == 2 && c != null ||
                                      this.widget.tipoAnuncio == 1
                                  ? Expanded(
                                      flex: visiblec == 1 ? 2 : 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          this.widget.tipoAnuncio == 1
                                              ? Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Checkbox(
                                                        value: checkedValue,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            checkedValue =
                                                                newValue;
                                                            if (newValue) {
                                                              c = null;
                                                            }
                                                          });
                                                        },
                                                        //  <-- leading Checkbox
                                                      ),
                                                      Text("Todos"),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),
                                          c != null
                                              ? c.id != 1000
                                                  ? Expanded(
                                                      child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              left: ResponsiveFlutter
                                                                      .of(
                                                                          context)
                                                                  .scale(7),
                                                              right: ResponsiveFlutter
                                                                      .of(context)
                                                                  .scale(10)),
                                                          width: this
                                                                      .widget
                                                                      .tipoAnuncio ==
                                                                  1
                                                              ? widthc * .45
                                                              : widthc * .35,
                                                          child: Card(
                                                            margin: EdgeInsets.only(
                                                                bottom:
                                                                    visiblec ==
                                                                            1
                                                                        ? 8
                                                                        : 5,
                                                                top: 2),
                                                            elevation: 5,
                                                            child: Center(
                                                              child: Text(
                                                                toBeginningOfSentenceCase(c
                                                                    .name
                                                                    .toLowerCase()),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        500],
                                                                    fontSize:
                                                                        c.name.length >=
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
                                  : SizedBox(),
                              Expanded(
                                flex: 18,
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .52,
                                    color: Color(0xffecedee),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 9, left: 7, right: 7),
                                      child: Container(
                                        child: lc.length > 0
                                            ? GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      _crossAxisCount,
                                                  childAspectRatio: aspectratio,
                                                ),
                                                scrollDirection: Axis.vertical,
                                                itemCount: lc.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .43,
                                                          height:
                                                              aspectratio * 65,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                c = lc[index];
                                                              });
                                                            },
                                                            child: Card(
                                                              elevation: c !=
                                                                          null &&
                                                                      c.id ==
                                                                          lc[index]
                                                                              .id
                                                                  ? 5
                                                                  : 0,
                                                              child: Center(
                                                                child: Text(
                                                                  lc[index]
                                                                      .name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: c != null && c.id == lc[index].id
                                                                          ? Color(
                                                                              0xff1ba6d2)
                                                                          : Color(
                                                                              0xffb7b7b7),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "TrebuchetMS",
                                                                      fontSize: lc[index].name.length >=
                                                                              15
                                                                          ? 11
                                                                          : 13),
                                                                ),
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  side:
                                                                      BorderSide
                                                                          .none),
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
                                              ),
                                      ),
                                    )),
                              ),
                              Expanded(
                                flex: visiblec == 1 ? 3 : 4,
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                            .07 +
                                        40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(top: BorderSide(color: Colors.grey[100],width: 1))
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
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
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.0195),
                                                      )
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
                                                    Navigator.of(context).pop();

                                                    // print(username);

                                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                  }),
                                            ),
                                          ),
                                          SizedBox(width: widthc * 0.03),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: widthc * 0.03),
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
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.0195),
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
                                                    if (checkedValue) {
                                                      c = new Cities(
                                                          id: 1000,
                                                          name:
                                                              "Todo el Departamento o estado");
                                                    }
                                                    Navigator.of(context)
                                                        .pop(c);

                                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            });
          });
      return selectedc;
    }

    return Hero(
      tag: "LugarOferta",
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Donde mostrar oferta ",
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
              child:Column(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: ListView(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03,
                            right: MediaQuery.of(context).size.width * 0.03),
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Container(
                              height: 48,
                              padding: EdgeInsets.only(
                                  top: ResponsiveFlutter.of(context).hp(1)),

                              //color: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                (paiss == null) ? "País" : paiss.name,
                                                style: TextStyle(
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.0175,
                                                    color: Color(0xfc979797),
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w400),
                                              ),
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
                                                color: errPais == 0
                                                    ? Color(0xffd3d7db)
                                                    : Colors.red[500])),
                                        padding: EdgeInsets.all(2),
                                        color: Colors.white,
                                        elevation: 0,
                                        onPressed: () {
                                          _showDialogP(context, paiss).then((pais) {
                                            if (pais != null) {
                                              setState(() {
                                                errPais = 0;
                                                paiss = pais;
                                                if (paiss != null) {
                                                  lg.clear();
                                                  lc.clear();
                                                  if (paiss.id != 1000) {
                                                    lg.addAll(paiss.governorates);
                                                  }

                                                  gs = null;
                                                  cs = null;
                                                }
                                              });
                                            }
                                            //print("ST=>"+paiss.name);
                                          });
                                        }),
                                  ),
                                ],
                              )),
                          Container(
                            height: 48,
                            padding: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(1)),

                            //color: Colors.blue,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                      disabledColor: Colors.grey[300],
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              gs == null
                                                  ? "Departamento"
                                                  : toBeginningOfSentenceCase(
                                                  gs.name.toLowerCase()),
                                              style: TextStyle(
                                                  fontSize: gs != null
                                                      ? gs.name.length > 20
                                                      ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.015
                                                      : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0175
                                                      : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0175,
                                                  color: Color(0xfc979797),
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff757575),
                                              size:
                                              MediaQuery.of(context).size.height *
                                                  .12 *
                                                  .21,
                                            )
                                          ],
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: BorderSide(
                                              color: errGover == 0
                                                  ? Color(0xffd3d7db)
                                                  : Colors.red[500])),
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      elevation: 0,
                                      onPressed:
                                      (paiss != null && paiss.id == 1000) ||
                                          paiss == null
                                          ? null
                                          : () {
                                        if (paiss != null) {
                                          _showDialogG(context, gs)
                                              .then((gover) {
                                            if (gover != null) {
                                              setState(() {
                                                errGover = 0;
                                                gs = gover;
                                                cs = null;
                                                lc.clear();
                                                if (gs != null &&
                                                    gs.id != 1000) {
                                                  lc.addAll(gs.cities);
                                                }
                                              });
                                            }
                                          });
                                        }
                                      }),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 48,
                            padding: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(1)),

                            //color: Colors.blue,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    disabledColor: Colors.grey[300],
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(cs == null ? "Ciudad" : cs.name,
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
                                            size: MediaQuery.of(context).size.height *
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
                                            color: errcity == 0
                                                ? Color(0xffd3d7db)
                                                : Colors.red[500])),
                                    padding: EdgeInsets.all(4),
                                    color: Colors.white,
                                    elevation: 0,
                                    onPressed: (paiss != null && paiss.id == 1000) ||
                                        gs == null ||
                                        gs.id == 1000
                                        ? null
                                        : () {
                                      if (paiss != null) {
                                        _showDialogC(context, cs).then((city) {
                                          if (city != null) {
                                            setState(() {
                                              errcity = 0;
                                              cs = city;
                                            });
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey[300],width: 1)
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
                              if (paiss == null) {
                                error = 1;
                                setState(() {
                                  errPais = 1;
                                });
                              } else {
                                setState(() {
                                  errPais = 0;
                                });
                              }
                              if (paiss != null) {
                                if (paiss.id != 1000 && gs == null) {
                                  error = 1;
                                  setState(() {
                                    errGover = 1;
                                  });
                                } else {
                                  setState(() {
                                    errGover = 0;
                                  });
                                }
                              }

                              if (gs != null) {
                                if (gs.id != 1000 && cs == null) {
                                  error = 1;
                                  setState(() {
                                    errcity = 1;
                                  });
                                } else {
                                  setState(() {
                                    errcity = 0;
                                  });
                                }
                              }

                              if (error == 0) {
                                widget.lugarAnuncio = new lugarOfertaAnuncio(
                                    city: cs, depto: gs, pais: paiss);
                                Navigator.of(context).pop(widget.lugarAnuncio);
                              } else {
                                print("HAY ERRORES");
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
