import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/swiperV2.dart';
import 'package:woin/src/presentation/pages/principal/card_swiper.dart';
import 'package:woin/src/presentation/pages/transactions/addNota.dart';
import 'package:woin/src/presentation/pages/transactions/transactionPpal.dart';
import 'package:woin/src/presentation/widgets/fadeAnimation.dart';

class TransaccionesMain extends StatefulWidget {
  Key key;
  TransaccionesMain({this.key});
  @override
  TransaccionesMainState createState() => TransaccionesMainState();
}

class BottomWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 20, size.height / 5);
    var firstdEndPoint = Offset(size.width / 2.35, size.height / 3.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 2.15);
    var secondEndPoint = Offset(size.width, size.height / 1.25);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 70);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomGreyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 20, size.height / 5);
    var firstdEndPoint = Offset(size.width / 2.5, size.height / 3.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 2.15);
    var secondEndPoint = Offset(size.width, size.height / 1.25);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    ;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TransaccionesMainState extends State<TransaccionesMain>
    with SingleTickerProviderStateMixin {
  List<userTransactions> usuariosSelected;
  AnimationController expandController;

  int cuenta = 0;
  MontoTransactions monto;
  int veruser = 0;
  int editMode;

  SwiperControllerV2 _controller;

  limpiarMontoUser(){
    print("LIMPIAR MONTO");

    monto = MontoTransactions(
        efectivo: 0,
        puntos: 0,
        efbase: 0,
        puntobase: 0,
        opcion: 1,
        porcentaje: 0,
        venta: 0,
        saldoDisponible: 0);
    usuariosSelected.clear();
  }

  void deleteUserList(userTransactions user) {
    if (usuariosSelected.length > 0) {
      for (int i = 0; i < usuariosSelected.length; i++) {
        if (usuariosSelected[i].codewoiner == user.codewoiner) {
          usuariosSelected.removeAt(i);
          break;
        }
      }
      calcularMontoTotal();
      setState(() {});
    }
  }

  editarUsuariosMonto(List<userTransactions> resp) {
   // print("resp=>"+resp.length.toString());
    double totalp=0;
    double totalc=0;
    double montoTotalp=0;
    double montoTotalc=0;
    bool isactive=false;
    bool isactiveC=false;
    double comprafija=0;
    double puntofj=0;
    for (userTransactions us in usuariosSelected) {
      if(us.valorFijo==1 && obtenerUser(us, resp)==null){

        puntofj+=us.puntos;
      }

      if(us.efecfijo==1&& obtenerUser(us, resp)==null){
        comprafija+=us.compras;
      }
    }
    for (userTransactions u in resp) {

      for (userTransactions us in usuariosSelected) {

        if (us.codewoiner == u.codewoiner) {

            totalp+=u.puntos;
            totalc+=u.compras;
          us.puntos = u.puntos;
          us.compras=u.compras;
          us.valorFijo=u.valorFijo;
          us.efecfijo=u.efecfijo;


        }

      }
    }





    for (userTransactions us in resp) {
     if(us.valorFijo==0){
       isactive=true;
     }
     if(us.efecfijo==0){
       isactiveC=true;
     }
    }
    print("TOTAL ASIGNADO=>"+totalp.toString());
    print("PUNTOS TOTAL=>"+monto.montopuntosAll.toString());
    print("MTP=>"+montoTotalp.toString());
    int totalDividir=0;
    int totalDividirC=0;

    totalp=(monto.montopuntosAll-totalp-puntofj);
    totalc=(monto.montoefecAll-totalc-comprafija);
    if(isactive){
      for (userTransactions u in usuariosSelected) {
          if(obtenerUser(u, resp)==null && u.valorFijo==0){
            totalDividir++;
          }
      }

    }else{
      totalDividir=usuariosSelected.where((u)=>u.valorFijo!=1).toList().length;
    }

    if(isactiveC){
      for (userTransactions u in usuariosSelected) {
        if(obtenerUser(u, resp)==null && u.efecfijo==0){
          totalDividirC++;
        }
      }
    }else{
      totalDividirC=usuariosSelected.where((u)=>u.efecfijo!=1).toList().length;
    }

    print("PUNTO REAPRTIR=>"+totalp.toString());
    print("EFEC REAPRTIR=>"+totalc.toString());
    print("USUARIOS REAPRTIRP=>"+totalDividir.toString());
    print("USUARIOS REAPRTIRC=>"+totalDividirC.toString());

    for (userTransactions us in usuariosSelected) {
      if (obtenerUser(us,resp)==null && us.valorFijo!=1 ){
        us.puntos = (totalp/totalDividir);

      }

    }

    for (userTransactions us in usuariosSelected) {
      if(obtenerUser(us,resp)==null && us.efecfijo!=1){
        us.compras=(totalc/totalDividirC);
      }

    }





 // print("EDITAR MONTO");
  }


  obtenerUser(userTransactions us,List<userTransactions>lu){
    for(userTransactions u in lu){
      if(u.codewoiner==us.codewoiner){
        return u;
      }
    }
    return null;

  }

  String format(double x) {
    List<String> parts = x.toString().split('.');
    RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

    parts[0] = parts[0].replaceAll(re, '.');
    if (parts.length == 1) {
      parts.add('00');
    } else {
      parts[1] = parts[1].padRight(2, '0').substring(0, 2);
    }
    return parts.join(',');
  }

  calcularMontoTotal(){
    print("ENTRO A CALCULAR");
    monto.puntos=0;
    monto.efectivo=0;
    for(userTransactions u in usuariosSelected){
     monto.puntos+=u.puntos;
     monto.efectivo+=u.compras;
    }
    print("LENGTH USER=>"+usuariosSelected.length.toString());
  }

  Widget _wlist(userTransactions user) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(1), horizontal: 0),
      width: ResponsiveFlutter.of(context).wp(46),
     // height: ResponsiveFlutter.of(context).hp(18),
      child: GestureDetector(
        onTap: () {
          if(monto.puntos!=0 || monto.efectivo!=0){
            editMode = 1;
            List<userTransactions> lnewedit = List();
            desdeleccionartUserSelected();
            user.selected = 1;
            lnewedit.add(user);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ValorTransactionView(

                  editMode: editMode,
                  opcion: opcion,
                  userSelected: lnewedit,
                  userall: usuariosSelected,
                );
              }),
            ).then((resp) {
              if (resp != null) {
                editarUsuariosMonto(resp);
                calcularMontoTotal();

                setState(() {

                });

              } else {
                print("NO SELECCIONO  MONTO");
              }
              //RETORNAR MONTO
            });
          }else{
            print("NO PUEDO MODIFICAR");
          }

        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[300], width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.only(right: 6, top: ResponsiveFlutter.of(context).verticalScale(3), bottom: ResponsiveFlutter.of(context).verticalScale(3), left: 1),
          elevation: 1,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      radius: ResponsiveFlutter.of(context).hp(2.8),
                      backgroundColor: user.type == 2
                          ? Color.fromARGB(255, 27, 166, 210)
                          : Color.fromARGB(255, 222, 170, 1),
                      child: CircleAvatar(
                        radius: ResponsiveFlutter.of(context).hp(2.7),
                        backgroundImage: user.imagen != ""
                            ? NetworkImage(user.imagen)
                            : null,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        deleteUserList(user);
                      },
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        alignment: Alignment.center,
                        width: ResponsiveFlutter.of(context).wp(8),
                        height: ResponsiveFlutter.of(context).wp(8),
                        child: Icon(
                          FontAwesome.times_circle,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
               Text(
                    user.fullname.trim(),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        fontFamily: "Roboto"),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      format(user.puntos),
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 11,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "\$" + format(user.compras),
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    Timer(Duration(milliseconds: 200), () => expandController.forward());
  }

  desdeleccionartUserSelected() {
    for (userTransactions u in usuariosSelected) {
      u.selected = 0;
    }
  }

  int opcion = -1;
  Container cardsWoin2(context, int id) {
    int index = sesion.getCuentaActiva;

    return Container(
      padding: EdgeInsets.only(
          bottom: ResponsiveFlutter.of(context).verticalScale(10),
          top: ResponsiveFlutter.of(context).verticalScale(0),
          left: 0,
          right: 0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 3,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          (() {
                            if (id == 0 && index == 3) {
                              print(id);
                              return "Emwoin";
                            }

                            if (id == 0 && index == 2) {
                              return "Cliwoin";
                            }
                            if (id == 1 && index == 2) {
                              return "Emwoin";
                            }
                            if (id == 1 && index == 3) {
                              return "Cliwoin";
                            }
                          }()),
                          style: TextStyle(
                            fontSize: 12,
                            color: (() {
                              if (id == 0 && index == 3) {
                                return Color.fromARGB(255, 222, 170, 1);
                              }

                              if (id == 0 && index == 2) {
                                return Color.fromARGB(255, 27, 166, 210);
                              }
                              if (id == 1 && index == 2) {
                                return Color.fromARGB(255, 222, 170, 1);
                              }
                              if (id == 1 && index == 3) {
                                return Color.fromARGB(255, 27, 166, 210);
                              }
                            }()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 0),
                            child: Text(
                              "Mi saldo",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, top: 0, bottom: 10),
                            child: Text(
                              "46800000.00",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 90, 136),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  opcion != -1
                                      ? Text(
                                          opcion == 1
                                              ? "Pagar puntos:"
                                              : opcion == 2
                                                  ? "Regalar puntos"
                                                  : opcion == 3
                                                      ? "Enviar puntos"
                                                      : "Solicitar puntos",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color:
                                                Color.fromARGB(255, 1, 90, 136),
                                          ),
                                        )
                                      : Text(
                                          "Valor no asignado",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color:
                                                Color.fromARGB(255, 1, 90, 136),
                                          ),
                                        ),
                                  opcion != -1
                                      ? Text(
                                          format(monto.puntos  ),
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 1, 90, 136),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              opcion == 1 || opcion == 2
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          opcion == 1
                                              ? "Pagar compras"
                                              : "Valor venta x",
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 11),
                                        ),
                                        Text(
                                          "\$ ${usuariosSelected != null ? usuariosSelected.length > 0 ? format(monto.efectivo) : format(monto.efbase) : format(monto.efbase)}",
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )
                                      ],
                                    )
                                  : SizedBox(),
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
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[400], width: 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipPath(
              child: Container(
                margin: EdgeInsets.only(right: 0.5, top: 0.5),
                width: MediaQuery.of(context).size.width * 0.47,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(235, 237, 242, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
                alignment: Alignment.centerRight,
              ),
              clipper: BottomGreyClipper2(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipPath(
              child: Container(
                margin: EdgeInsets.only(right: 0.5, top: 0.5),
                width: MediaQuery.of(context).size.width * 0.41,
                decoration: BoxDecoration(
                    gradient: (() {
                      if (id == 0 && index == 3) {
                        return LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 238, 0, 1),
                              Color.fromRGBO(194, 159, 0, 1),
                              Color.fromRGBO(128, 73, 0, 1)
                            ],
                            stops: [
                              0.08,
                              0.22,
                              0.8
                            ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft);
                      }

                      if (id == 0 && index == 2) {
                        return LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 255, 229, 1),
                              Color.fromRGBO(13, 183, 203, 1),
                              Color.fromRGBO(0, 117, 177, 1)
                            ],
                            stops: [
                              0.01,
                              0.15,
                              0.5
                            ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft);
                      }
                      if (id == 1 && index == 2) {
                        return LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 238, 0, 1),
                              Color.fromRGBO(194, 159, 0, 1),
                              Color.fromRGBO(128, 73, 0, 1)
                            ],
                            stops: [
                              0.08,
                              0.22,
                              0.8
                            ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft);
                      }
                      if (id == 1 && index == 3) {
                        return LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 255, 229, 1),
                              Color.fromRGBO(13, 183, 203, 1),
                              Color.fromRGBO(0, 117, 177, 1)
                            ],
                            stops: [
                              0.01,
                              0.15,
                              0.5
                            ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft);
                      }
                    }()),

                    // color: index == 0?Colors.blue[700]:Colors.amber[500],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
              ),
              clipper: BottomWaveClipper2(),
            ),
          ),
          Positioned(
            right: 10,
            top: 8,
            child: Container(
              decoration: BoxDecoration(
                color: (() {
                  if (id == 0 && index == 2 && sesion.getImageCli != null) {
                    return Colors.transparent;
                  } else if (id == 0 &&
                      index == 2 &&
                      sesion.getImageCli == null) {
                    return Colors.grey[200];
                  }
                  if (id == 0 && index == 3 && sesion.getImageEm != null) {
                    return Colors.transparent;
                  } else if (id == 0 &&
                      index == 3 &&
                      sesion.getImageEm == null) {
                    return Colors.grey[200];
                  }
                  if (id == 1 && index == 2 && sesion.getImageEm != null) {
                    return Colors.transparent;
                  } else if (id == 0 &&
                      index == 2 &&
                      sesion.getImageEm == null) {
                    return Colors.grey[200];
                  }
                  if (id == 1 && index == 3 && sesion.getImageCli != null) {
                    return Colors.transparent;
                  } else if (id == 1 &&
                      index == 3 &&
                      sesion.getImageCli == null) {
                    return Colors.grey[200];
                  }
                }()),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    (() {
                      if (id == 0 && index == 2 && sesion.getImageCli != null) {
                        return sesion.getImageCli;
                      } else if (id == 0 &&
                          index == 3 &&
                          sesion.getImageEm != null) {
                        return sesion.getImageEm;
                      } else if (id == 0) {
                        return "";
                      }

                      if (id == 1 && index == 2 && sesion.getImageEm != null) {
                        return sesion.getImageEm;
                      } else if (id == 1 &&
                          index == 3 &&
                          sesion.getImageCli != null) {
                        return sesion.getImageCli;
                      } else {
                        return "";
                      }
                    }()),
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width * .13,
              height: MediaQuery.of(context).size.width * .13,
              child: (() {
                if (id == 0 && index == 2 && sesion.getImageCli != null) {
                  return SizedBox();
                } else if (id == 0 &&
                    index == 2 &&
                    sesion.getImageCli == null) {
                  return Center(
                    child: Text(
                      "sesion.getSession.person.fullName[0]",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  );
                }
                if (id == 0 && index == 3 && sesion.getImageEm != null) {
                  return SizedBox();
                } else if (id == 0 && index == 3 && sesion.getImageEm == null) {
                  return Center(
                    child: Text(
                      "sesion.getSession.person.fullName[0]",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  );
                }
                if (id == 1 && index == 2 && sesion.getImageEm != null) {
                  return SizedBox();
                } else if (id == 0 && index == 2 && sesion.getImageEm == null) {
                  return Center(
                    child: Text(
                      "sesion.getSession.person.fullName[0]",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  );
                }
                if (id == 1 && index == 3 && sesion.getImageCli != null) {
                  return SizedBox();
                } else if (id == 1 &&
                    index == 3 &&
                    sesion.getImageCli == null) {
                  return Center(
                    child: Text(
                      "sesion.getSession.person.fullName[0]",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  );
                }
              }()),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    usuariosSelected = List();
    cuenta = sesion.getCuentaActiva == 3 ? 1 : 0;
    monto = MontoTransactions(
        efectivo: 0,
        puntos: 0,
        efbase: 0,
        puntobase: 0,
        opcion: 1,
        porcentaje: 0,
        venta: 0,
        saldoDisponible: 0);

    prepareAnimations();
    opcion = 1;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheet = CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.grey[700],
              ),
              Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          )),
      title: Text("Tipo de Transferencia"),
      actions: <Widget>[
        opcion != 1
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    opcion = 1;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "Pagar      ",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            : SizedBox(),
        opcion != 2
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    opcion = 2;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.card_giftcard,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "Regalar   ",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            : SizedBox(),
        opcion != 3
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    opcion = 3;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.send,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "Enviar    ",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            : SizedBox(),
        opcion != 4
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    opcion = 4;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.system_update,
                      color: Colors.grey[600],
                    ),
                    Text(
                      " Solicitar",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 27, 166, 210),
        child: Icon(Icons.check),
      ),
      body: Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(-1, 0),
                  end: Offset.zero,
                ).animate(expandController),
                child: FadeTransition(
                  opacity: expandController,
                  child: Container(
                    color: Colors.white,
                    height: ResponsiveFlutter.of(context).hp(30),
                    child: Column(
                      //color: Colors.amber,

                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Billetera  ${cuenta == 0 ? "Cliwoin" : "Emwoin"}",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(1),
                                bottom: ResponsiveFlutter.of(context).hp(0)),
                            child: SwiperV2(
                              controller: _controller,
                              index: 0,
                              autoplay: false,
                              itemCount: 2,
                              onIndexChanged: (index) {
                                setState(() {
                                  cuenta = cuenta == 0 ? 1 : 0;
                                  print("CUENTA=>" + cuenta.toString());
                                });
                              },
                              scrollDirection: Axis.horizontal,
                              layout: SwiperLayoutV2.STACK,
                              itemWidth:
                                  ResponsiveFlutter.of(context).scale(352),
                              loop: true,
                              itemBuilder: (BuildContext contexto, int index) {
                                return Container(
                                    padding:
                                        EdgeInsets.only(right: 17, left: 14),
                                    child: cardsWoin2(context, index));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: ResponsiveFlutter.of(context).hp(70) - 143,
                color: Color(0xffececec),
                child: ListView(
                  padding: EdgeInsets.only(
                      top: ResponsiveFlutter.of(context).verticalScale(.8)),
                  children: <Widget>[
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset.zero,
                      ).animate(expandController),
                      child: FadeTransition(
                        opacity: expandController,
                        child: GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) => bottomSheet);
                          },
                          child: Container(
                            height:
                                ResponsiveFlutter.of(context).verticalScale(90),
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .scale(7)),
                                      child: CircleAvatar(
                                          radius: ResponsiveFlutter.of(context)
                                              .scale(29.0),
                                          backgroundColor: Colors.grey[200],
                                          child: Center(
                                            child: Icon(
                                              opcion == 1
                                                  ? Icons.account_balance_wallet
                                                  : opcion == 2
                                                      ? Icons.card_giftcard
                                                      : opcion == 3
                                                          ? Icons.swap_horiz
                                                          : opcion == 4
                                                              ? Icons
                                                                  .system_update
                                                              : Icons.title,
                                              size: 30,
                                            ),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 16,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: ResponsiveFlutter.of(context)
                                              .verticalScale(10),
                                        ),
                                        Text(
                                          "Tipo de transferencia",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Text(
                                            opcion == 1
                                                ? "Pagar"
                                                : opcion == 2
                                                    ? "Regalar"
                                                    : opcion == 3
                                                        ? "Enviar"
                                                        : opcion == 4
                                                            ? "Solicitar"
                                                            : "Sin tipo",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ResponsiveFlutter.of(context)
                                              .verticalScale(10),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 20,
                                          height: 20,
                                          child: Center(
                                              child: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.grey[600],
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: ResponsiveFlutter.of(context).hp(.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset.zero,
                      ).animate(expandController),
                      child: FadeTransition(
                        opacity: expandController,
                        child: GestureDetector(
                          onTap: () {
                            editMode = 0;
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return ValorTransactionView(

                                  editMode: editMode,

                                  opcion: opcion,
                                  userSelected: usuariosSelected,
                                  userall: usuariosSelected,
                                );
                              }),
                            ).then((resp) {
                              if (resp != null) {
                                print("ENTRO AQUI");
                                setState(() {
                                  monto = resp.monto;
                                  usuariosSelected = resp.users;
                                  calcularMontoTotal();
                                });
                              } else {
                                print("NO SELECCIONO  MONTO");
                              }
                              //RETORNAR MONTO
                            });
                          },
                          child: Container(
                            height:
                                ResponsiveFlutter.of(context).verticalScale(90),
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .scale(7)),
                                      child: CircleAvatar(
                                        radius: ResponsiveFlutter.of(context)
                                            .scale(29.0),
                                        backgroundColor: Colors.grey[200],
                                        child: Center(
                                          child: Icon(
                                            Icons.attach_money,
                                            size: 30,
                                            color: Colors.green[300],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 16,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: ResponsiveFlutter.of(context)
                                              .verticalScale(10),
                                        ),
                                        Text(
                                          "Valor a transferir",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Text(
                                            "Sin valor",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ResponsiveFlutter.of(context)
                                              .verticalScale(10),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 20,
                                          height: 20,
                                          child: Center(
                                              child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.grey[600])),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: ResponsiveFlutter.of(context).hp(.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset.zero,
                      ).animate(expandController),
                      child: FadeTransition(
                        opacity: expandController,
                        child: GestureDetector(
                          onTap: () {
                              calcularMontoTotal();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return transactionGnal(

                                monto: monto,
                                opcion: opcion,
                                userSelected: usuariosSelected,
                                editMode: usuariosSelected != null
                                    ? usuariosSelected.length > 0 ? 1 : 0
                                    : 0,
                              );
                            })).then((users) {
                              if (users != null) {
                                usuariosSelected = users;
                              }
                            });
                          },
                          child: Container(
                            height: usuariosSelected == null
                                ? ResponsiveFlutter.of(context)
                                    .verticalScale(90)
                                : usuariosSelected.length > 0 && veruser == 1
                                    ? ResponsiveFlutter.of(context)
                                .verticalScale(210)
                                    : ResponsiveFlutter.of(context)
                                        .verticalScale(90),
                            child: Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .scale(7)),
                                            child: CircleAvatar(
                                                radius: ResponsiveFlutter.of(
                                                        context)
                                                    .scale(29.0),
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: Center(
                                                  child: Icon(
                                                    Icons
                                                        .supervised_user_circle,
                                                    size: 30,
                                                    color: Colors.purple[200],
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 16,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(10),
                                              ),
                                              Text(
                                                "Usuarios a transferir",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              GestureDetector(
                                                onTap: usuariosSelected != null && usuariosSelected.length>0
                                                    ? () {
                                                        setState(() {
                                                          veruser = veruser == 1
                                                              ? 0
                                                              : 1;
                                                        });
                                                      }
                                                    : null,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0,
                                                      top: 4,
                                                      bottom: 5),
                                                  child: Text(
                                                    "${usuariosSelected != null ? usuariosSelected.length : 0} usuarios seleccionados",
                                                    style: TextStyle(
                                                        decoration: usuariosSelected !=
                                                                null
                                                            ? usuariosSelected
                                                                        .length >
                                                                    0
                                                                ? TextDecoration
                                                                    .underline
                                                                : TextDecoration
                                                                    .none
                                                            : TextDecoration
                                                                .none,
                                                        fontSize: 12,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(10),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 20,
                                                height: 20,
                                                child: Center(
                                                    child: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            Colors.grey[600])),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey[300],
                                  ),
                                  usuariosSelected != null
                                      ? usuariosSelected.length > 0 &&
                                              veruser == 1
                                          ? Expanded(
                                              flex: 4,
                                              child: Container(
                                                color: Colors.white,
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    top: ResponsiveFlutter.of(
                                                            context)
                                                        .verticalScale(5),
                                                    bottom:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .verticalScale(5),
                                                    right: 5),
                                                child:
                                                    usuariosSelected.length > 1
                                                        ? ListView(
                                                            shrinkWrap: false,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        0,
                                                                    vertical:
                                                                        3),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children:
                                                                usuariosSelected
                                                                    .map(_wlist)
                                                                    .toList())
                                                        : usuariosSelected
                                                                    .length ==
                                                                1
                                                            ? Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            0,
                                                                        vertical:
                                                                           ResponsiveFlutter.of(context).verticalScale(1)),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            ResponsiveFlutter.of(context).verticalScale(2),
                                                                        horizontal:
                                                                            0),
                                                                width: ResponsiveFlutter.of(
                                                                        context)
                                                                    .wp(100),
                                                                child: Card(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        color: Colors.grey[
                                                                            300],
                                                                        width:
                                                                            0.5),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              0,
                                                                          vertical:
                                                                          ResponsiveFlutter.of(context).verticalScale(4)),
                                                                  elevation: 1,
                                                                  color: Colors
                                                                      .white,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                8),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: ResponsiveFlutter.of(context).verticalScale(4)),
                                                                              child: CircleAvatar(
                                                                                radius: ResponsiveFlutter.of(context).hp(2.8),
                                                                                backgroundColor: usuariosSelected[0].type == 2 ? Color.fromARGB(255, 27, 166, 210) : Color.fromARGB(255, 222, 170, 1),
                                                                                child: CircleAvatar(
                                                                                  radius: ResponsiveFlutter.of(context).hp(2.6),
                                                                                  backgroundImage: usuariosSelected[0].imagen != "" ? NetworkImage(usuariosSelected[0].imagen) : null,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                deleteUserList( usuariosSelected[0]);
                                                                              },
                                                                              borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                width: ResponsiveFlutter.of(context).wp(8),
                                                                                height: ResponsiveFlutter.of(context).wp(8),
                                                                                child: Icon(
                                                                                  FontAwesome.times_circle,
                                                                                  color: Colors.grey[500],
                                                                                  size: 20,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                              Text(
                                                                            usuariosSelected[0].fullname.trim(),
                                                                            style: TextStyle(
                                                                                color: Colors.grey[900],
                                                                                fontWeight: FontWeight.w300,
                                                                                fontSize: 10,
                                                                                fontFamily: "Roboto"),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                      
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              usuariosSelected[0].puntos.toString(),
                                                                              style: TextStyle(color: Colors.blue[700], fontSize: 11, fontWeight: FontWeight.w800),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                            Text(
                                                                              "\$" + usuariosSelected[0].compras.toString(),
                                                                              style: TextStyle(color: Colors.grey[800], fontSize: 10, fontWeight: FontWeight.w800),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          ResponsiveFlutter.of(context).verticalScale(2),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox(),
                                              ),
                                            )
                                          : SizedBox()
                                      : SizedBox()
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: ResponsiveFlutter.of(context).hp(1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset.zero,
                      ).animate(expandController),
                      child: FadeTransition(
                        opacity: expandController,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return addNota(
                                editmodo: 0,
                                luser: usuariosSelected,
                              );
                            }));
                          },
                          child: Container(
                            height:
                                ResponsiveFlutter.of(context).verticalScale(90),
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .scale(7)),
                                      child: CircleAvatar(
                                          radius: ResponsiveFlutter.of(context)
                                              .scale(29.0),
                                          backgroundColor: Colors.grey[200],
                                          child: Center(
                                            child: Icon(
                                              Icons.note_add,
                                              size: 30,
                                              color: Colors.red[200],
                                            ),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 16,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: ResponsiveFlutter.of(context)
                                              .verticalScale(10),
                                        ),
                                        Text(
                                          "Agregar nota/ Calificar usuarios",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Text(
                                            "Sin Datos",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ResponsiveFlutter.of(context)
                                              .verticalScale(10),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 20,
                                          height: 20,
                                          child: Center(
                                              child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.grey[600])),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: ResponsiveFlutter.of(context).hp(.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              /* Expanded(
                flex: usuariosSelected.length > 0 && opcion != -1
                    ? 7
                    : usuariosSelected.length > 0 && opcion == -1 ? 7 : 6,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: usuariosSelected.length > 0 ? 0 : 8),
                      child: Row(
                        children: <Widget>[
                          usuariosSelected.length > 0
                              ? Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(255, 27, 166, 210),
                                    size: 18,
                                  ),
                                )
                              : SizedBox(),
                          Text(
                            usuariosSelected.length == 0
                                ? "Usuarios a transferir"
                                : "Usuarios seleccionados (${usuariosSelected.length})",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: usuariosSelected.length > 0 ? 12 : 14,
                                fontWeight: usuariosSelected.length > 0
                                    ? FontWeight.bold
                                    : FontWeight.w400),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return addNota(
                                        editmodo: 0,
                                        luser: usuariosSelected,
                                      );
                                    }));
                                  },
                                  child: Text(
                                    "Agregar Nota",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 27, 166, 210),
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    usuariosSelected.length > 0
                        ? Expanded(
                            flex: 3,
                            child: usuariosSelected.length > 1
                                ? ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 3),
                                    scrollDirection: Axis.horizontal,
                                    children:
                                        usuariosSelected.map(_wlist).toList())
                                : usuariosSelected.length == 1
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 1),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 0),
                                        width:
                                            ResponsiveFlutter.of(context).wp(100),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.grey[300],
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          elevation: 1,
                                          color: Colors.white,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor:
                                                          usuariosSelected[
                                                                          0]
                                                                      .type ==
                                                                  2
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  27,
                                                                  166,
                                                                  210)
                                                              : Color.fromARGB(
                                                                  255,
                                                                  222,
                                                                  170,
                                                                  1),
                                                      child: CircleAvatar(
                                                        radius: 19,
                                                        backgroundImage:
                                                            usuariosSelected[0]
                                                                        .imagen !=
                                                                    ""
                                                                ? NetworkImage(
                                                                    usuariosSelected[
                                                                            0]
                                                                        .imagen)
                                                                : null,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width:
                                                            ResponsiveFlutter.of(
                                                                    context)
                                                                .wp(8),
                                                        height:
                                                            ResponsiveFlutter.of(
                                                                    context)
                                                                .wp(8),
                                                        child: Icon(
                                                          FontAwesome
                                                              .times_circle,
                                                          color: Colors.grey[500],
                                                          size: 20,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    usuariosSelected[0].fullname,
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10,
                                                        fontFamily: "Roboto"),
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      usuariosSelected[0]
                                                          .puntos
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.blue[700],
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Text(
                                                      "\$" +
                                                          usuariosSelected[0]
                                                              .compras
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.grey[800],
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                          )
                        : SizedBox(),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return transactionGnal(
                                        monto: monto,
                                        userSelected: usuariosSelected,
                                        opcion: opcion,
                                        cuenta: cuenta,
                                      );
                                    })).then((users) {
                                      if (users != null) {
                                        setState(() {
                                          usuariosSelected = users;
                                          print(usuariosSelected.length);
                                          print(users);
                                        });
                                      }
                                    });
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        right:
                                            ResponsiveFlutter.of(context).wp(1)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: ResponsiveFlutter.of(context)
                                              .hp(1.7)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.select_all,
                                            size: 16,
                                            color: Colors.grey[500],
                                          ),
                                          SizedBox(
                                            width: ResponsiveFlutter.of(context)
                                                .wp(1),
                                          ),
                                          Text(
                                            "Seleccionar",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: ResponsiveFlutter.of(context).wp(1)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveFlutter.of(context)
                                            .hp(1.7)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.scanner,
                                          size: 16,
                                          color: Colors.grey[500],
                                        ),
                                        SizedBox(
                                          width:
                                              ResponsiveFlutter.of(context).wp(1),
                                        ),
                                        Text(
                                          "Escanear",
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
