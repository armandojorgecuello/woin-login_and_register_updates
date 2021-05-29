import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/presentation/FileIconsWoin/woin_icon.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';

class miperfil extends StatefulWidget {
  @override
  _miperfilState createState() => _miperfilState();
}

class _miperfilState extends State<miperfil> {
  userdetalle sesion= userdetalle();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("CODE WOINER=>"+sesion.obtenerdetalle(sesion.getCuentaActiva).codewoiner);
    print("CUENTA ACTIVA=>"+sesion.getCuentaActiva.toString());
    print("NOMBRE=>"+sesion.obtenerdetalle(sesion.getCuentaActiva).nombre);

   // sesion.obtenersesion(sesion.getCuentaActiva);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=>TabMain()
        ));

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          title: Text(
            "Perfil",
            style: TextStyle(color: Color(0xff1ba6d2),fontSize: 16),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            //color: Colors.red,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            width: 10,
            height: 10,
            child: Builder(builder: (BuildContext context) {
              return IconButton(
                padding: EdgeInsets.all(2),
                splashColor: Colors.white,
                alignment: Alignment.centerLeft,
                icon: Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: Color(
                    0xffbbbbbb,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context)=>TabMain()
                  ));
                },
              );
            }),
          ),
        ),
        body: Container(
          color: Colors.grey[300],
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 5, left: 10, right: 10),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 80,
                                  child: CircleAvatar(
                                      radius: 150,
                                      backgroundImage: sesion.getCuentaActiva == 2
                                          && sesion.getImageCli != ""?NetworkImage(sesion.getImageCli): sesion.getCuentaActiva == 3
                                          && sesion.getImageEm != "" ?NetworkImage(sesion.getImageEm):null,
                                      child: sesion.getCuentaActiva == 2
                                          ? sesion.getImageCli == ""
                                              ? Text(
                                                  sesion.obtenerdetalle(sesion.getCuentaActiva).nombre,
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              : SizedBox()
                                          : sesion.getCuentaActiva == 3
                                              ? sesion.getImageEm == ""
                                                  ? Text("sesion.getSession.person.fullName[0]",
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  : SizedBox()
                                              : SizedBox()),
                                ),
                                RatingBarIndicator(
                                  itemSize:
                                      MediaQuery.of(context).size.height * 0.035,
                                  rating: sesion
                                      .calificacionWoiner(sesion.getCuentaActiva),
                                  itemCount: 5,
                                  unratedColor: Colors.black12,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Color(
                                        0xff0075b1), //Theme.of(context).primaryColor
                                  ),
                                ),
                                SizedBox(
                                  height: ResponsiveFlutter.of(context).hp(1),
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.06,
                                      bottom: MediaQuery.of(context).size.height *
                                          0.007,
                                      top: MediaQuery.of(context).size.height *
                                          0.015),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Información de Woiner(Personal)",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(2),
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff0075b1),
                                            letterSpacing: 0.2),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.023),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Nombre"),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      child: Icon(
                                        FontAwesome.user,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      sesion.obtenerdetalle(sesion.getCuentaActiva).nombre,
                                      style: TextStyle(
                                          fontSize: ResponsiveFlutter.of(context)
                                              .fontSize(2)),
                                    ),
                                    dense: true,
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.023),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Tipo Woiner"),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.cyan[300],
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ResponsiveFlutter.of(context)
                                                .wp(2.5)),
                                        child: Icon(
                                          WoinIcon.woin1,
                                          size: ResponsiveFlutter.of(context)
                                              .fontSize(2.3),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      sesion.getCuentaActiva == 2
                                          ? "Cliwoiner"
                                          : "Emwoiner",
                                      style: TextStyle(
                                          fontSize: ResponsiveFlutter.of(context)
                                              .fontSize(2)),
                                    ),
                                    dense: true,
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.023),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Acerca de "),
                                    leading: CircleAvatar(
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                        sesion
                                            .obtenerdetalle(sesion.getCuentaActiva)
                                            !=null?  sesion
                                          .obtenerdetalle(sesion.getCuentaActiva)
                                          .biography:"",
                                      style: TextStyle(
                                          fontSize: ResponsiveFlutter.of(context)
                                              .fontSize(2)),
                                    ),
                                    dense: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.007,
                                  top:
                                      MediaQuery.of(context).size.height * 0.015),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Información de Contacto",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0075b1),
                                        letterSpacing: 0.2),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.023,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue[300],
                                  child: Icon(
                                    FontAwesome.mobile_phone,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text("Teléfono"),
                                subtitle: Text(
                                  sesion
                                              .obtenerdetalle(
                                                  sesion.getCuentaActiva)
                                              .contacto ==
                                          null
                                      ? "No registra"
                                      : sesion
                                          .obtenerdetalle(sesion.getCuentaActiva)
                                          .contacto,
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.9),
                                      fontFamily: "Trebuchet MS"),
                                ),
                                dense: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.023,
                                  right:
                                      MediaQuery.of(context).size.width * 0.023,
                                  top: 0,
                                  bottom: 0),
                              child: Divider(
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.023,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.007),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green[300],
                                  child: Icon(
                                    FontAwesome.whatsapp,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text("Whatsapp"),
                                subtitle: Text(
                                    sesion
                                                .obtenerdetalle(
                                                    sesion.getCuentaActiva)
                                                .contacto ==
                                            null
                                        ? "No registra"
                                        : sesion
                                            .obtenerdetalle(
                                                sesion.getCuentaActiva)
                                            .contacto,
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(1.9),
                                        fontFamily: "Trebuchet MS")),
                                dense: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.023,
                                right: MediaQuery.of(context).size.width * 0.023,
                              ),
                              child: Divider(
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.023,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.pink[300],
                                  child: Icon(
                                    FontAwesome.envelope_o,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text("Email"),
                                subtitle: Text(
                                  sesion
                                      .obtenerdetalle(sesion.getCuentaActiva)
                                      .email,
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.9),
                                      fontFamily: "Trebuchet MS"),
                                ),
                                dense: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.023,
                                right: MediaQuery.of(context).size.width * 0.023,
                              ),
                              child: Divider(
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.023,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.018),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.yellow[300],
                                  child: Icon(
                                    FontAwesome.map_marker,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text("Ubicación"),
                                subtitle: Text(
                                  sesion
                                      .obtenerdetalle(sesion.getCuentaActiva)
                                      .ubicacion,
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.9)),
                                ),
                                dense: true,
                              ),
                            ),
                          ], //ESTA BIEN HASTA AQU
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: SizedBox(
                        height: ResponsiveFlutter.of(context).hp(10),
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.023,
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.015),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Información bancaria",
                                    style: TextStyle(
                                        color: Color(0xff0075b1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey[300],
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: SizedBox(
                        height: ResponsiveFlutter.of(context).hp(7.5),
                        child: FlatButton(
                          onPressed: () => {},
                          color: Colors.blue[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.cancel,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Desactivar Cuenta",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
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
    );
  }
}
