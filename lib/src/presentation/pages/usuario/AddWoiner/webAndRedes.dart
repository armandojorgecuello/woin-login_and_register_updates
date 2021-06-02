import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sizer/sizer.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/entities/users/regEmwoiner.dart';


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
  final GlobalKey<FormFieldState> keypaginaWeb = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keyfacebookController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keytwitterController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keyinstagramController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keylinkedController = GlobalKey<FormFieldState>();
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
        appBar: _appBar(context),
        backgroundColor: Colors.grey[300],
        body: _body(context),
      ),
    );
  }

  ListView _body(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _cardNetworks(context),
        SizedBox(height: 24.0.h,),
        _buttons(context),
      ],
      );
  }

  Container _buttons(BuildContext context) {
    return Container(
      height: 8.0.h,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            }
          ),
        ],
      ),
    );
  }

  Padding _cardNetworks(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.0.h,bottom:1.0.h),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 2.0.w,
          vertical: 0.0
        ),
        children: <Widget>[
          Form(
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 2.0.h,
                  bottom: 2.0.h
                ),
                child: Column(
                  children: <Widget>[
                    _title("Página web"),
                    _textField(
                      "Página web incorrecta (Copie y pegue el link)",
                      paginaWeb,
                      "Página web de la empresa",
                      keypaginaWeb
                    ),
                    _title("Facebook"),
                    _textField(
                      "Facebook incorrecto (Copie y pegue el link)",
                      facebookController,
                      "Facebook de la empresa",
                      keyfacebookController
                    ),
                    _title("Instagram"),
                    _textField(
                      "Instagram incorrecto (Copie y pegue el link)",
                      instagramController,
                      "Instagram de la empresa",
                      keyinstagramController
                    ),
                    _title("Twitter"),
                    _textField(
                      "Twitter incorrecto (Copie y pegue el link)",
                      twitterController,
                      "Twitter de la empresa",
                      keytwitterController
                    ),
                    _title("LinkedIn"),
                    _textField(
                      "LinkedIn incorrecto (Copie y pegue el link)",
                      linkedController,
                      "LinkedIn de la empresa",
                      keylinkedController
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _textField(String errorMessage, TextEditingController controller, String hint, GlobalKey<FormFieldState<dynamic>> key ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:3.0.w,
        vertical:0
      ),
      child: TextFormField(
        maxLength: 45,
        validator: (val) {
          bool validURL =
              Uri.parse(val).isAbsolute;
          if (val.length > 0 && !validURL) {
            return errorMessage;
          } else {
            return null;
          }
        },
        key: key,
        onChanged: (value){
          key.currentState.validate();
        },
        controller: controller,
        style: TextStyle(
          color: Color(0xfc979797),
          fontSize:12.0.sp
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        autofocus: false,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.red[600])
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.red[600])
          ),
          errorStyle: TextStyle(fontSize: 12.0.sp),
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
          labelStyle: TextStyle(color: Color(0xfc979797)),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.grey[300])
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.grey[500])
          ),
        ),
      ),
    );
  }

  Align _title(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(  horizontal:6.0.w,  vertical:1.5.h),
        child: Text(
          title,
          style:TextStyle(color: Colors.grey[700], fontSize: 11.0.sp),
        )
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Redes Sociales",
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
