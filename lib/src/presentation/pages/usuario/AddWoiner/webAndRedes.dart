import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Persons/gender.dart';
import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/entities/users/regEmwoiner.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/genderPerson.dart';

class WebSocialswoiner extends StatefulWidget {
  webRedes social;
  WebSocialswoiner({this.social});
  @override
  _WebSocialswoinerState createState() => _WebSocialswoinerState();
}

class _WebSocialswoinerState extends State<WebSocialswoiner> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController paginaWeb = new TextEditingController();
  TextEditingController facebookController = new TextEditingController();
  TextEditingController twitterController = new TextEditingController();
  TextEditingController instagramController = new TextEditingController();
  TextEditingController linkedController = new TextEditingController();
  int errfecha = 0;
  int errgenero = 0;
  int visibletec = 0;

  // Navigator.of(context).pop();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.social != null && widget.social.paginaWeb != "") {
      paginaWeb.text = widget.social.paginaWeb;
      print("ENTRA");
    }
    if (widget.social != null && widget.social.lsp.length > 0) {
      if (widget.social.lsp != null && widget.social.obtenerRed(1) != null) {
        facebookController.text = widget.social.obtenerRed(1).urlProfile;
      }
      if (widget.social.lsp != null && widget.social.obtenerRed(2) != null) {
        instagramController.text = widget.social.obtenerRed(2).urlProfile;
      }
      if (widget.social.lsp != null && widget.social.obtenerRed(3) != null) {
        twitterController.text = widget.social.obtenerRed(3).urlProfile;

        if (widget.social.lsp != null && widget.social.obtenerRed(4) != null) {
          linkedController.text = widget.social.obtenerRed(4).urlProfile;
        }
      }
      KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
          setState(() {
            visible ? visibletec = 1 : visibletec = 0;
            print(visibletec);
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "social",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Página Web y Redes Sociales",
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
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(
                    top: ResponsiveFlutter.of(context).verticalScale(10),
                    bottom: ResponsiveFlutter.of(context).verticalScale(10)),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveFlutter.of(context).wp(2),
                      vertical: ResponsiveFlutter.of(context).hp(0)),
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).hp(2),
                              bottom: ResponsiveFlutter.of(context).hp(3)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(6),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(1.5)),
                                      child: Text(
                                        "Página Web",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(3),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(0)),
                                      child: SizedBox(
                                        // height: ResponsiveFlutter.of(context)              .hp(8),
                                        child: TextFormField(
                                          maxLength: 45,
                                          validator: (val) {
                                            bool validURL =
                                                Uri.parse(val).isAbsolute;
                                            if (val.length > 0 && !validURL) {
                                              return "Página web incorrecta (Copie y pegue el link)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: paginaWeb,
                                          style: TextStyle(
                                              color: Color(0xfc979797),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorStyle: TextStyle(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(1.5)),
                                            contentPadding: EdgeInsets.all(10),

                                            hintText:
                                                "Página web de la empresa",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Color(0xfc979797)),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),

                                            // labelText: 'Correo'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(6),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(1.5)),
                                      child: Text(
                                        "Facebook",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(3),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(0)),
                                      child: SizedBox(
                                        // height: ResponsiveFlutter.of(context)                            .hp(5),
                                        child: TextFormField(
                                          maxLength: 45,
                                          validator: (val) {
                                            bool validURL =
                                                Uri.parse(val).isAbsolute;
                                            if (val.length > 0 && !validURL) {
                                              return "Facebook incorrecto (Copie y pegue el link)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: facebookController,
                                          style: TextStyle(
                                              color: Color(0xfc979797),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorStyle: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.5),
                                            ),
                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Facebook de la empresa",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Color(0xfc979797)),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),

                                            // labelText: 'Correo'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(6),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(1.5)),
                                      child: Text(
                                        "Instagram",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(3),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(0)),
                                      child: SizedBox(
                                        // height: ResponsiveFlutter.of(context)                                         .hp(5),
                                        child: TextFormField(
                                          maxLength: 45,
                                          validator: (val) {
                                            bool validURL =
                                                Uri.parse(val).isAbsolute;
                                            if (val.length > 0 && !validURL) {
                                              return "Instagram incorrecto (Copie y pegue el link)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: instagramController,
                                          style: TextStyle(
                                              color: Color(0xfc979797),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorStyle: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.5),
                                            ),
                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Instagram de la empresa",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Color(0xfc979797)),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),

                                            // labelText: 'Correo'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(6),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(1.5)),
                                      child: Text(
                                        "Twitter ",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(3),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(0)),
                                      child: SizedBox(
                                        // height: ResponsiveFlutter.of(context).hp(5),
                                        child: TextFormField(
                                          maxLength: 45,
                                          validator: (val) {
                                            bool validURL =
                                                Uri.parse(val).isAbsolute;
                                            if (val.length > 0 && !validURL) {
                                              return "Twitter incorrecto (Copie y pegue el link)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: twitterController,
                                          style: TextStyle(
                                              color: Color(0xfc979797),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorStyle: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.5),
                                            ),
                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Twitter de la empresa",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Color(0xfc979797)),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),

                                            // labelText: 'Correo'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(6),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(1.5)),
                                      child: Text(
                                        "LinkedIn",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(3),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .hp(0)),
                                      child: SizedBox(
                                        // height: ResponsiveFlutter.of(context).hp(5),
                                        child: TextFormField(
                                          maxLength: 45,
                                          validator: (val) {
                                            bool validURL =
                                                Uri.parse(val).isAbsolute;
                                            if (val.length > 0 && !validURL) {
                                              return "Linkedin incorrecto (Copie y pegue el link)";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: linkedController,
                                          style: TextStyle(
                                              color: Color(0xfc979797),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorStyle: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.5),
                                            ),
                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Linkedin de la empresa",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Color(0xfc979797)),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),

                                            // labelText: 'Correo'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
            visibletec == 0
                ? Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                : SizedBox(),
            Expanded(
              flex: visibletec == 0 ? 2 : 3,
              child: Container(
                color: Colors.white,
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
                              if (_formKey.currentState.validate()) {
                                List<SocialProfiles> lrs = new List();
                                if (facebookController.text != null &&
                                    facebookController.text != "") {
                                  SocialProfiles sp = new SocialProfiles(
                                      urlProfile: facebookController.text,
                                      woinSocialNetworkId: 1,
                                      type: 1);
                                  lrs.add(sp);
                                }
                                if (instagramController.text != null &&
                                    instagramController.text != "") {
                                  SocialProfiles sp = new SocialProfiles(
                                      urlProfile: instagramController.text,
                                      woinSocialNetworkId: 1,
                                      type: 2);
                                  lrs.add(sp);
                                }
                                if (twitterController.text != null &&
                                    twitterController.text != "") {
                                  SocialProfiles sp = new SocialProfiles(
                                      urlProfile: twitterController.text,
                                      woinSocialNetworkId: 1,
                                      type: 3);
                                  lrs.add(sp);
                                }
                                if (linkedController.text != null &&
                                    linkedController.text != "") {
                                  SocialProfiles sp = new SocialProfiles(
                                      urlProfile: linkedController.text,
                                      woinSocialNetworkId: 1,
                                      type: 4);
                                  lrs.add(sp);
                                }
                                webRedes soc;

                                if (linkedController.text == "" &&
                                    twitterController.text == "" &&
                                    instagramController.text == "" &&
                                    facebookController.text == "" &&
                                    paginaWeb.text == "") {
                                  soc = null;
                                } else {
                                  soc = new webRedes(
                                      paginaWeb: paginaWeb.text, lsp: lrs);
                                }

                                print("TODO BIEN");

                                Navigator.of(context).pop(soc);
                              } else {
                                print("Errores");
                              }
                              // Navigator.of(context).pop(imgFile);
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
