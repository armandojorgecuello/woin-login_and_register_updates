import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class Biographywoiner extends StatefulWidget {
  int type;
  String biografia;

  Biographywoiner({this.biografia, this.type});
  @override
  _BiographywoinerState createState() => _BiographywoinerState();
}

class _BiographywoinerState extends State<Biographywoiner> {
  int visibletec = 0;
  final _formKey = GlobalKey<FormState>();

  TextEditingController biografiaController = new TextEditingController();

  int errfecha = 0;
  int errgenero = 0;

  // Navigator.of(context).pop();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.biografia != null && widget.biografia != "") {
      biografiaController.text = widget.biografia;
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

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "biografia",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
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
        Padding(
          padding: EdgeInsets.only(
            top: ResponsiveFlutter.of(context).verticalScale(10),
            bottom: ResponsiveFlutter.of(context).verticalScale(10)
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveFlutter.of(context).wp(2),
              vertical: ResponsiveFlutter.of(context).hp(0)
            ),
            children: <Widget>[
              Form(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 2.0.h,
                      bottom: 3.0.h
                    ),
                    child: Column(
                      children: <Widget>[
                        _title(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:3.0.w,
                                  vertical:0
                                ),
                                child: _biographyTextField(context),
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
        SizedBox(
          height: 46.0.h,
        ),
        _button(context),
      ],
    );
  }

  Container _button(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 8.0.h,
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
                Navigator.of(context)
                    .pop(biografiaController.text);
              } else {
                print("Errores");
              }
            }
          ),
        ],
      ),
    );
  }

  TextFormField _biographyTextField(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val.length > 0 &&
            val.length < 15) {
          return "Descripción minima con 15 caracteres";
        }
        return null;
      },
      maxLength: 100,
      maxLines: 8,
      controller: biografiaController,
      style: TextStyle(
        color: Color(0xfc979797),
        fontSize: 12.0.sp
      ),
      keyboardType: TextInputType.text,
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.red[600])
        ),
        errorStyle: TextStyle(
          fontSize: 12.0.sp
        ),
        contentPadding: EdgeInsets.all(10),
        hintText:
            "Escribe aquí una pequeña descripción",
        labelStyle: TextStyle(color: Color(0xfc979797)),
        enabledBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  Align _title() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:6.0.w,
          vertical:1.5.h
        ),
        child: Text(
          "Acerca de mí ${widget.type == 3 ? "empresa" : ""}",
          style:
              TextStyle(color: Colors.grey[700]),
        )
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Acerca de",
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
