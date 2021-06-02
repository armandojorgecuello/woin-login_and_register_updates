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

import 'contactoWoiner.dart';

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
      height: 100.0.h,
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveFlutter.of(context).hp(1.9),
            horizontal: ResponsiveFlutter.of(context).wp(2.2)
          ),
          shrinkWrap: true,
          children: <Widget>[
            userDetail.typeDefault == 2
            ? _personalInfoCard(context, userDetail, woinerData)
            : _myBusinessCard(context),
            _contactAndOthersCard(context),
          ],
        ),
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
          this.widget.typeWoiner == 3
              ? Divider(
                  color: Colors.grey[300],
                )
              : SizedBox(),
          this.widget.typeWoiner == 3 ? _social(context) : SizedBox(),
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
            subtitle: Text("Modificar datos de redes sociales"),
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
              )
            )
          );
        },
        child: Material(
          color: Colors.white,
          child: ListTile(
            dense: true,
            leading: Icon(FontAwesome.info_circle),
            title: Text("Biografía visible al público"),
            subtitle: Text("Modificar biografía"),
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
        onTap:() {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration:
                      Duration(milliseconds: 1200),
                  pageBuilder: (_, __, ___) =>
                      Contactoswoiner(
                        contacto: widget.contacto,
                        typeWoiner: widget.typeWoiner,
                      ))).then((datos) {
            setState(() {
              widget.contacto = datos;
              validcontactoone = 1;
            });
          });
        },
        child: Material(
          color: validcontactoone == 1 ? Colors.white : Colors.blue[200],
          child: ListTile(
            dense: true,
            leading: Icon(FontAwesome.phone),
            title: Text("Contáctame"),
            subtitle: Text("Modificar datos de contacto"),
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
              horizontal: 5.0.w,
              vertical: 1.5.h
            ),
            child: _cardTitle("Información personal"),
          ),
          _divider(),
          _infoItem(
            context, 
            userDetail, 
            Icon(FontAwesome.image),
            (){
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
            "Imagen  mostrar al público",
            "Photo",
            userDetail?.image != null ? userDetail?.image : "Sin imagen para mostrar"
          ),
          _divider(),
          _infoItem(
            context, 
            userDetail, 
            Icon(FontAwesome.user_o), 
            () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 1200),
                  pageBuilder: (_, __, ___) => DatosPersonaleswoiner()
                )
              );
            }, 
            "Datos del Usuario", 
            "UserData", 
            woinerData.publicName != null ? woinerData.publicName : "Sin Datos para mostrar"
          ),
          _divider(),
          _infoItem(
            context, 
            userDetail, 
            Icon(FontAwesome.drivers_license_o), 
            () {
              Navigator.push(context,PageRouteBuilder(transitionDuration: Duration(milliseconds: 1200),pageBuilder: (_, __, ___) => Identificacionwoiner()));
            }, 
            "Identificación del usuario", 
            "identificacion", 
            userDetail.username
          ),
          _divider(),
          _infoItem(
            context,
            userDetail, 
            Icon(FontAwesome.map_marker), 
            () {
              Navigator.push(
                context,
                PageRouteBuilder(transitionDuration: Duration(milliseconds: 1200),pageBuilder: (_, __, ___) => ResidenciaWoiner(  ubicacion: widget.ubicacion,)));
            }, 
            "Lugar de Residencia", 
            "residencia", 
            "Cambiar lugar de residencia"
          ),
          _divider(),
        ],
      ),
    );
  }

  Text _cardTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.blue[700], fontWeight: FontWeight.w600,fontSize:11.0.sp
      ),
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.grey[300],
      height: 0,
    );
  }

  Hero _infoItem(BuildContext context, UserDetailResponse userDetail, Widget icon, Function onPressed, String title, String heroTag, String subtitle) {
    return Hero(
      tag: heroTag,
      child: GestureDetector(
        onTap: onPressed,
        child: Material(
          color: Colors.white,
          child: ListTile(
            dense: true,
            leading: icon,
            title: Text(title, ),
            subtitle:  Text(subtitle),
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
