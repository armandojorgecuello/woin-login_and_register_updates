import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

Future<int> showDialogOpcion(BuildContext context, int editmode,
    int opcionselected, int moreuser) async {
  int selectedOpcion = await showDialog<int>(
      context: context,
      builder: (context) {
        int opcions = opcionselected;
        int selected = 0;

        return StatefulBuilder(builder: (context, setState) {
          var widthScreen = MediaQuery.of(context).size.width;
          var heightScreen = MediaQuery.of(context).size.height;

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                var heightc = editmode == 1
                    ? moreuser == 1
                        ? MediaQuery.of(context).size.height * .6
                        : MediaQuery.of(context).size.height * .55
                    : MediaQuery.of(context).size.height * .6;
                var widthc = MediaQuery.of(context).size.width;
                return Container(
                    width: widthc,
                    height: heightc,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[700], width: 1),
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
                            IconButton(
                              icon: Icon(
                                FontAwesome.times_circle,
                                size: 25,
                                color: Color(0xff97a4b1),
                              ),
                              alignment: Alignment.centerRight,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          title: Text(
                            "Operación a realizar",
                            style: TextStyle(
                              color: Color(0xff1ba6d2),
                            ),
                          ),
                        ),
                        body: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: editmode == 1 && moreuser == 0 ? 9 : 16,
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 9, left: 2, right: 2),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6),
                                                  child: Container(
                                                    child: Text(
                                                      "Seleccione tipo de operación para transferir puntos entre usuarios",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.grey[800]),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                ResponsiveFlutter.of(context)
                                                    .hp(selected != 0 ? 3 : 1),
                                            child: Container(),
                                          ),

                                          //TITULO OPCION 1
                                          (editmode == 0|| moreuser==1) &&
                                                  (selected == 0 ||
                                                      selected == 1)
                                              ? Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                "x",
                                                                style: TextStyle(
                                                                    decoration: opcions ==
                                                                            1
                                                                        ? TextDecoration
                                                                            .underline
                                                                        : TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        16,
                                                                    color: opcions ==
                                                                            1
                                                                        ? Colors.grey[
                                                                            900]
                                                                        : Colors
                                                                            .grey[700]),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 12,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                child: Text(
                                                                  "Multiplica el valor a transferir por el numero de usuarios",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                              .grey[
                                                                          500]),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    selected =
                                                                        selected ==
                                                                                1
                                                                            ? 0
                                                                            : 1;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    selected ==
                                                                            1
                                                                        ? FontAwesome
                                                                            .check_circle
                                                                        : FontAwesome
                                                                            .circle_o,
                                                                    color: selected ==
                                                                            1
                                                                        ? Color(
                                                                            0xff1ba6d2)
                                                                        : Colors
                                                                            .grey[400]),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: SizedBox(),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),

                                          //DFINICION OPCION 1
                                          selected == 1
                                              ? Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(2),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 8),
                                                        child: Text(
                                                          "Ejempo: (Multiplica) Valor puntos, es la cantidad que desea transferir en puntos",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 5),
                                                        child: Text(
                                                          "Valor dinero, es la cantidad en efectivo que entrega al comercio por compra, con la posiilidad de ganar puntos según términos y condiciones del establecimiento.",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(5),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),

                                          //TITULO OPCION 2

                                          (moreuser == 1 || editmode == 0) &&
                                                  (selected == 0 ||
                                                      selected == 2)
                                              ? Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text("÷",
                                                                  style: TextStyle(
                                                                      decoration: opcions == 2
                                                                          ? TextDecoration
                                                                              .underline
                                                                          : TextDecoration
                                                                              .none,
                                                                      fontSize:
                                                                          16,
                                                                      color: opcions ==
                                                                              2
                                                                          ? Colors.grey[
                                                                              900]
                                                                          : Colors
                                                                              .grey[700])),
                                                            ),
                                                            Expanded(
                                                              flex: 12,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                child: Text(
                                                                    "Divide el valor a transferir entre los usuarios",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .grey[500])),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    selected =
                                                                        selected ==
                                                                                2
                                                                            ? 0
                                                                            : 2;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    selected ==
                                                                            2
                                                                        ? FontAwesome
                                                                            .check_circle
                                                                        : FontAwesome
                                                                            .circle_o,
                                                                    color: selected ==
                                                                            2
                                                                        ? Color(
                                                                            0xff1ba6d2)
                                                                        : Colors
                                                                            .grey[400]),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: SizedBox(),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                          //DEFINICION OPCION 2
                                          selected == 2
                                              ? Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(2),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 8),
                                                        child: Text(
                                                          "Ejempo: (Divide) Valor puntos, es la cantidad que desea transferir en puntos",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 5),
                                                        child: Text(
                                                          "Valor dinero, es lacantidad en efectivo que entrega al comercio por compra, con la posiilidad de ganar puntos según términos y condiciones del establecimiento.",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(5),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),

                                          //TITULO OPCION 3
                                          (editmode == 1) &&
                                                  (selected == 0 ||
                                                      selected == 3)
                                              ? Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30),
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text("+",
                                                                    style: TextStyle(
                                                                        decoration: opcions ==
                                                                                3
                                                                            ? TextDecoration
                                                                                .underline
                                                                            : TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            16,
                                                                        color: opcions ==
                                                                                3
                                                                            ? Colors.grey[900]
                                                                            : Colors.grey[700])),
                                                              ),
                                                              Expanded(
                                                                flex: 12,
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5),
                                                                  child: Text(
                                                                    "Suma el valor adicional al total a transferir",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .grey[500]),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    //print("cambio");
                                                                    setState(
                                                                        () {
                                                                      selected =
                                                                          selected == 3
                                                                              ? 0
                                                                              : 3;
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                      selected == 3
                                                                          ? FontAwesome
                                                                              .check_circle
                                                                          : FontAwesome
                                                                              .circle_o,
                                                                      color: selected ==
                                                                              3
                                                                          ? Color(
                                                                              0xff1ba6d2)
                                                                          : Colors
                                                                              .grey[400]),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    SizedBox(),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          //DEFINICION OPCION 3
                                          selected == 3
                                              ? Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(2),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 8),
                                                        child: Text(
                                                          "Ejempo: (Suma) Valor puntos, es la cantidad que desea transferir en puntos",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 5),
                                                        child: Text(
                                                          "Valor dinero, es lacantidad en efectivo que entrega al comercio por compra, con la posiilidad de ganar puntos según términos y condiciones del establecimiento.",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(5),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),
                                          //TITULO OPCION 4
                                          (editmode == 1) &&
                                                  (selected == 0 ||
                                                      selected == 4)
                                              ? Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text("-",
                                                                  style: TextStyle(
                                                                      decoration: opcions == 4
                                                                          ? TextDecoration
                                                                              .underline
                                                                          : TextDecoration
                                                                              .none,
                                                                      fontSize:
                                                                          16,
                                                                      color: opcions ==
                                                                              4
                                                                          ? Colors.grey[
                                                                              900]
                                                                          : Colors
                                                                              .grey[700])),
                                                            ),
                                                            Expanded(
                                                              flex: 12,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                child: Text(
                                                                    "Resta el valor, al total a transferir para dividir el saldo entre los usuarios",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .grey[500])),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  print(
                                                                      "cambio");
                                                                  setState(() {
                                                                    selected =
                                                                        selected ==
                                                                                4
                                                                            ? 0
                                                                            : 4;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    selected ==
                                                                            4
                                                                        ? FontAwesome
                                                                            .check_circle
                                                                        : FontAwesome
                                                                            .circle_o,
                                                                    color: selected ==
                                                                            4
                                                                        ? Color(
                                                                            0xff1ba6d2)
                                                                        : Colors
                                                                            .grey[400]),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: SizedBox(),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),

                                          //DEFINICION OPCION 4
                                          selected == 4
                                              ? Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(2),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 8),
                                                        child: Text(
                                                          "Ejempo: (Resta) Valor puntos, es la cantidad que desea transferir en puntos",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                right: 5),
                                                        child: Text(
                                                          "Valor dinero, es lacantidad en efectivo que entrega al comercio por compra, con la posiilidad de ganar puntos según términos y condiciones del establecimiento.",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(5),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),

                                          (editmode == 1 && moreuser == 0) &&
                                                  selected == 0
                                              ? SizedBox(
                                                  height: ResponsiveFlutter.of(
                                                          context)
                                                      .hp(5),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(width: widthc * 0.03),
                                      Container(
                                        width: ResponsiveFlutter.of(context)
                                            .wp(50),
                                        child: RaisedButton(
                                            elevation: 0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Continuar',
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0195),
                                                ),
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            padding: EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                top: 12,
                                                bottom: 12),
                                            color: Color(0xff1ba6d2),
                                            onPressed: () {
                                              if (opcions != 0) {
                                                Navigator.of(context)
                                                    .pop(selected);
                                              }

                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                            }),
                                      ),
                                    ],
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
  return selectedOpcion;
}
