/*import 'dart:io';
import 'package:woin/src/presentation/providers/upload_ad_provider.dart';
import 'package:woin/src/presentation/widgets/card_ad.dart';
import 'package:woin/src/presentation/widgets/outline_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

class PaidAd extends StatefulWidget {
  @override
  _PaidAdState createState() => _PaidAdState();
}

class _PaidAdState extends State<PaidAd> {
  Color primaryColor = Color.fromRGBO(0, 117, 177, 1);

  File _image;
  String _logo = ("assets/images/check_circle.png");
  List<FocusNode> _focusList;

  @override
  void initState() { 
    super.initState();
    _focusList = List<FocusNode>();
    for (var i = 0; i < 7; i++) {
      _focusList.add(FocusNode());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusList.forEach((focus) {
      focus.dispose();
    });
    _focusList.clear();
  }

  @override
  Widget build(BuildContext context) {
    final adInfo = Provider.of<UploadAdProvider>(context);

    Widget image = GestureDetector(
      child: ClipRRect(
        child: _image == null ? Image.asset("assets/images/logo.png", fit: BoxFit.fill) : Image.file(_image, fit: BoxFit.fill,),
        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.05)),
      )
    );

    Widget myAdCard() {
    return Container(
      height: MediaQuery.of(context).size.width > 767 ? MediaQuery.of(context).size.height * 0.25: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 5.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0)
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: CardAd(
                adInfo.ad,
                Image.asset(_logo),
                image,
                orientation: AdOrientation.horizontal,
              )
            )
          ],
        ),
      ),
    );
  }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(Icons.chevron_left, color: primaryColor,),
            onTap: () {
              Navigator.pop(context);
            }
          ),
          primary: true,
          title: Text("Subir Anuncio Pago", style: TextStyle(color: primaryColor)),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.width > 767 ? MediaQuery.of(context).size.height * 0.25 + 82.0 : MediaQuery.of(context).size.height * 0.2 + 82.0,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          myAdCard(),
                          Container(
                            height: 70.0,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, bottom: 10.0),
                            child: Center(
                              child: Text(
                                adInfo.ad.description,
                                style: TextStyle(color: Colors.grey, fontSize: 10.0),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 5.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text("Costo Banner ${adInfo.ad.getDuration().inDays} días", style: TextStyle(color: Colors.grey)),
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Container(
                            child: customTextField(text: "", context: context, enabled: false, fill: Colors.grey.withOpacity(0.6), bordered: false, enableInteraction: false),
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ],
                      )// ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 5.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text("Pague por ver", style: TextStyle(color: Colors.grey)),
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Container(
                            child: customTextField(text: "", context: context, enabled: false, fill: Colors.grey.withOpacity(0.6), bordered: false, enableInteraction: false),
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ],
                      )// ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Center(child: Text("Tarjeta", style: TextStyle(color: Colors.white),)),
                    )
                  ],
                )
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text("X Cerrar", style: TextStyle(color: Color.fromRGBO(0, 117, 177, 1))),
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      side: BorderSide(color: Color.fromRGBO(0, 117, 177, 1))
                    ),
                    color: Colors.white,
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: RaisedButton(
                    child: Text("Continuar", style: TextStyle(color: Colors.white)),
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      side: BorderSide(color: Color.fromRGBO(0, 117, 177, 1))
                    ),
                    color: Color.fromRGBO(0, 117, 177, 1),
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      // Llamar Vista de Pagar a Woin por el valor de el precio final del Ad
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField({@required String text, @required BuildContext context, TextEditingController controller, TextInputType keyboardType = TextInputType.text, bool bordered = true, void Function(String) onChanged, Color fill = Colors.transparent, bool enabled = true, bool enableInteraction = true, void Function() onTap, String Function(String) validator, int index = - 1}) {
    print("Length -> ${_focusList.length}");
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: TextFormField(
        style: TextStyle(color: Colors.black87, fontSize: 12.0),
        readOnly: !enabled,
        enabled: enabled,
        controller: controller,
        enableInteractiveSelection: enableInteraction,
        textInputAction: TextInputAction.done,
        focusNode: index < 0 ? null : _focusList[index],
        onEditingComplete: () {
          _fieldFocusChange(index, context);
        },
        validator: validator,
        decoration: OutlineInputDecoration(
          fillColor: fill,
          hintText: Text(text, style: TextStyle(fontSize: 11.2)),
          hintColor: Colors.grey,
          bordered: bordered,
          borderColor: Colors.grey
        ).decoration,
        onChanged: onChanged,
        onTap: onTap,
        keyboardType: keyboardType,
      ),
    );
  }

  _fieldFocusChange(index, BuildContext context) {
    _focusList[index].unfocus();
    FocusScope.of(context).requestFocus(_focusList[index + 1]);
  }
}

class CurveClipper extends CustomClipper<Path> {
 @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.02, size.height * 0.9, size.width * 0.08, size.height * 0.9);
    path.lineTo(size.width * 0.92, size.height * 0.9);// this closes the loop from current position to the starting point of widget 
    path.quadraticBezierTo(size.width * 0.98, size.height * 0.9, size.width, size.height * 0.8);
    path.lineTo(size.width, size.height * 0);// this closes the loop from current position to the starting point of widget 
    return path; 
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}*/
