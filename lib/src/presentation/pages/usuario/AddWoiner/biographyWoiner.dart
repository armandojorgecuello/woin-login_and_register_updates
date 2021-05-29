import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Persons/userViews.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/genderPerson.dart';

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
        appBar: AppBar(
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
                                        "Acerca de mí ${widget.type == 2 ? "empresa" : ""}",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
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
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.red[600])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                                "Escribe aquí una pequeña descripción",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Color(0xfc979797)),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                Navigator.of(context)
                                    .pop(biografiaController.text);
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
