import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'package:responsive_flutter/responsive_flutter.dart';

import 'package:sizer/sizer.dart';

import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/entities/users/regCliWoiner.dart';
import 'package:woin/src/helpers/LocationDevice.dart';

import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/models/woiner_data_model.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/biographyWoiner.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/datosPersonales.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/empresaWoiner.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/fotoWoiner.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/identificacionWoiner.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/residenciaWoiner.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/webAndRedes.dart';
import 'package:woin/src/providers/current_account_provider.dart';
import 'package:woin/src/providers/login_provider.dart';
import 'package:woin/src/providers/user_service.dart';

class MainDatosWoiner extends StatefulWidget {
  int typeWoiner;
  int editmode;
  nameForm nameuser;
  typeAndDocument identificacion;
  ubicacionWoiner ubicacion;
  contactoWoiner contacto;
  String biography;
  infoEmpresa infoempresa;
  webRedes social;
  String imagenUser;

  MainDatosWoiner({this.typeWoiner, this.editmode});

  @override
  _MainDatosWoinerState createState() => _MainDatosWoinerState();
}

class _MainDatosWoinerState extends State<MainDatosWoiner> {
  
  @override
  void initState() {
    super.initState();
  }

  UserDetailResponse userDetail;
  int validname = 1;
  int valididentificacion = 1;
  int validresidencia = 1;
  int validinfoempresa = 1;
  int validcontactoone = 1;

  @override
  Widget build(BuildContext context) {
    userDetail = Provider.of<LoginProvider>(context).userDetail;

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    UserDetailResponse userDetail =  Provider.of<LoginProvider>(context).userDetail;
    Woiner woinerData = Provider.of<CurrentAccount>(context, listen:false).woiner;
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: ListView(
                padding: EdgeInsets.symmetric(
                    vertical: ResponsiveFlutter.of(context).hp(1.9),
                    horizontal: ResponsiveFlutter.of(context).wp(2.2)),
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                children: <Widget>[
                  userDetail.typeDefault == 2
                  ? _personalInfoCard(context, userDetail, woinerData)
                  : _myBusinessCard(context),
                  _contactAndOthersCard(context),
                ],
              ),
            ),
            Container(
              width: 100.0.w,
              height: 10.0.h,
              child: _buttons(context),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Padding _buttons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    'Cancelar',
                    style: TextStyle(
                        fontFamily: "Roboto",
                        color: Color(0xff1ba6d2),
                        fontSize: MediaQuery.of(context).size.height * 0.019),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              }
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
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
                        fontSize: MediaQuery.of(context).size.height * 0.019),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
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
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
              color: Color(0xff1ba6d2),
              onPressed: () async {
                geoLocation gl = new geoLocation();
                await gl.obtenerGeolocalizacion();
                //cliWoiner cli = new cliWoiner(
                //  device: gl.getDevices,
                //  person: p,
                //  phones: phones,
                //  woinLocation: gl.getLocation,
                //  userId: 0,
                //  woinerType: type,
                //  isDefault: 1,
                //  image: widget.imagenUser,
                //  biography: widget.biography == null
                //    ? ""
                //    : widget.biography
                //);
                //final woinerReg = await userService.registroWoiner(cli);
              }//
          ),
        ],
      ),
    );
  }

  Card _contactAndOthersCard(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveFlutter.of(context).wp(5),
                vertical: ResponsiveFlutter.of(context).hp(1.5)),
            child: Text(
              "Contacto y otros",
              style: TextStyle(
                  color: Colors.blue[700], fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          contact(context),
          Divider(
            color: Colors.grey[300],
          ),
          _biography(context),
          this.widget.typeWoiner == 2
              ? Divider(
                  color: Colors.grey[300],
                )
              : SizedBox(),
          this.widget.typeWoiner == 2 ? _social(context) : SizedBox(),
          Divider(
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }

  Hero _social(BuildContext context) {
    return Hero(
      tag: "social",
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 1200),
                  pageBuilder: (_, __, ___) => WebSocialswoiner(
                        social: widget.social,
                      ))).then((datos) {
            setState(() {
              widget.social = datos;
            });
          });
        },
        child: Material(
          color: Colors.white,
          child: ListTile(
            dense: true,
            leading: Icon(FontAwesome.share_alt),
            title: Text("Página web y Redes Sociales"),
            subtitle: widget.social == null
                ? Text("No existen Datos")
                : widget.social != null && widget.social.paginaWeb == ""
                    ? Text("Algunas redes guardadas")
                    : Text(
                        widget.social.paginaWeb,
                        overflow: TextOverflow.ellipsis,
                      ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Hero _biography(BuildContext context) {
    return Hero(
      tag: "biografia",
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 1200),
                  pageBuilder: (_, __, ___) => Biographywoiner(
                        biografia: widget.biography,
                        type: widget.typeWoiner,
                      ))).then((datos) {
            if (datos != null) {
              setState(() {
                widget.biography = datos;
              });
            }
          });
        },
        child: Material(
          color: Colors.white,
          child: ListTile(
            dense: true,
            leading: Icon(FontAwesome.info_circle),
            title: Text("Biografía visible al público"),
            subtitle: (widget.biography == null || widget.biography == "")
                ? Text("No existe biografía que mostrar")
                : Text("Biografia Configurada"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Hero contact(BuildContext context) {
    return Hero(
      tag: "contacto",
      child: GestureDetector(
        child: Material(
          color: validcontactoone == 1 ? Colors.white : Colors.blue[200],
          child: ListTile(
            dense: true,
            leading: Icon(FontAwesome.phone),
            title: Text("Contáctame"),
            subtitle: widget.contacto == null
                ? Text("No hay datos de contacto")
                : widget.contacto != null && widget.contacto.telContacto == ""
                    ? Text("Algunos datos configurados")
                    : Text(widget.contacto.telContacto),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card _myBusinessCard(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveFlutter.of(context).wp(5),
                vertical: ResponsiveFlutter.of(context).hp(1)),
            child: Text(
              "Mi empresa",
              style: TextStyle(
                  color: Colors.blue[700], fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          Hero(
            tag: "empresa",
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1200),
                        pageBuilder: (_, __, ___) => Empresaswoiner(
                              dataEmpresa: widget.infoempresa,
                            ))).then((datos) {
                  if (datos != null) {
                    setState(() {
                      widget.infoempresa = datos;
                      validinfoempresa = 1;
                    });
                  }
                });
              },
              child: Material(
                color: validinfoempresa == 1 ? Colors.white : Colors.blue[200],
                child: ListTile(
                  dense: true,
                  leading: Icon(FontAwesome.briefcase),
                  title: Text("Información de mi empresa"),
                  subtitle: Text(
                    widget.infoempresa == null
                        ? "No hay información de la empresa"
                        : widget.infoempresa.nombre,
                    style: TextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }

  Card _personalInfoCard(BuildContext context, UserDetailResponse userDetail, Woiner woinerData) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveFlutter.of(context).wp(5),
                vertical: ResponsiveFlutter.of(context).hp(1.5)),
            child: Text(
              "Información personal",
              style: TextStyle(
                  color: Colors.blue[700], fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 0,
          ),
          Hero(
            tag: "Photo",
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 1200),
                    pageBuilder: (_, __, ___) => WoinerPicture(
                      img: "https://fondosmil.com/fondo/6609.jpg",
                    )
                  )
                );
              },
              child: Material(
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  leading: Icon(FontAwesome.image),
                  title: Text("Imagen  mostrar al público"),
                  subtitle: userDetail.typeDefault == 0 &&
                      widget.editmode == 0 &&
                      widget.imagenUser == null
                      ? Text("Sin imagen para mostrar")
                      : userDetail.typeDefault == 0 &&
                              widget.editmode == 0 &&
                              widget.imagenUser != null
                          ? Text(
                              "Imagen configurada",
                            )
                          : userDetail.typeDefault == 2 &&
                                  userDetail.image != ""
                              ? Text("Imagen configurada")
                              : userDetail.typeDefault == 3 &&
                                      userDetail.image != ""
                                  ? Text(
                                      "Imagen configurada",
                                    )
                                  : Text("Sin imagen para mostrar"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 0,
          ),
          Hero(
            tag: "UserData",
            child: GestureDetector(
              onTap: () {Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 1200),
                    pageBuilder: (_, __, ___) => DatosPersonaleswoiner()
                  )
                );
              },
              child: Material(
                color: validname == 1 ? Colors.white : Colors.blue[200],
                child: ListTile(
                  dense: true,
                  leading: Icon(FontAwesome.user_o),
                  title: Text("Datos del Usuario"),
                  subtitle: Text(
                    widget.nameuser == null
                        ? "Sin Datos"
                        : widget.nameuser.primerNombre +
                            " " +
                            widget.nameuser.segundoNombre +
                            " " +
                            widget.nameuser.primerApellido,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 0,
          ),
          Hero(
            tag: "identificacion",
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1200),
                        pageBuilder: (_, __, ___) => Identificacionwoiner(
                              identificacion: widget.identificacion,
                            ))).then((datos) {
                  if (datos != null) {
                    setState(() {
                      widget.identificacion = datos;
                      valididentificacion = 1;
                    });
                  }
                });
              },
              child: Material(
                color:
                    valididentificacion == 1 ? Colors.white : Colors.blue[200],
                child: ListTile(
                  dense: true,
                  leading: Icon(FontAwesome.drivers_license_o),
                  title: Text("Identificación del usuario"),
                  subtitle: widget.identificacion == null
                      ? Text("Usuario no identificado")
                      : Text(widget.identificacion.tipodocumento.type +
                          ": " +
                          widget.identificacion.numero),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 0,
          ),
          Hero(
            tag: "residencia",
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1200),
                        pageBuilder: (_, __, ___) => ResidenciaWoiner(
                              ubicacion: widget.ubicacion,
                            ))).then((datos) {
                  if (datos != null) {
                    setState(() {
                      widget.ubicacion = datos;
                      validresidencia = 1;
                    });
                  }
                });
              },
              child: Material(
                color: validresidencia == 1 ? Colors.white : Colors.blue[200],
                child: ListTile(
                  dense: true,
                  leading: Icon(FontAwesome.map_marker),
                  title: Text("Lugar de Residencia"),
                  subtitle: widget.ubicacion == null
                      ? Text("No hay ubicación")
                      : Text(widget.ubicacion.lugarUbicacion.getcountry.name +
                          " - " +
                          widget.ubicacion.lugarUbicacion.getCity.name),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 0,
          ),
        ],
      ),
    );
  }

  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        this.widget.typeWoiner == 2 ? "Cuenta Cliwoiner" : "Cuenta Emwoiner",
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
