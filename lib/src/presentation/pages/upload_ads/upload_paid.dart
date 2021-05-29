/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:woin/src/presentation/providers/upload_ad_provider.dart';
import 'package:woin/src/presentation/widgets/card_ad.dart';
import 'package:woin/src/presentation/widgets/outline_input.dart';

class UploadPaidAd extends StatefulWidget {
  @override
  _UploadPaidAdState createState() => _UploadPaidAdState();
}

class _UploadPaidAdState extends State<UploadPaidAd> {
  Color primaryColor = Color.fromRGBO(0, 117, 177, 1);
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _disccountController = new TextEditingController();
  TextEditingController _giftController = new TextEditingController();
  TextEditingController _startDateController = new TextEditingController();
  TextEditingController _endDateController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  UploadAdProvider adInfo;

  bool _ok = false;
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
    // Suscrito al provider de Ad.
    adInfo = Provider.of<UploadAdProvider>(context);

    Widget image = GestureDetector(
        child: ClipRRect(
          child: _image == null ? Image.asset("assets/images/logo.png", fit: BoxFit.fill) : Image.file(_image, fit: BoxFit.fill,),
          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.05)),
        ),
        onTap: () {
          getImage();
        },
    );

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
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width > 767 ? MediaQuery.of(context).size.height * 0.25: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 5.0),
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
            ),
            _generateInputs() 
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: _ok ? 
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
              child: RaisedButton(
                child: Text("Ir al Inicio", style: TextStyle(color: Colors.white)),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(color: Color.fromRGBO(0, 117, 177, 1))
                ),
                color: Color.fromRGBO(0, 117, 177, 1),
                colorBrightness: Brightness.dark,
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
              ),
            )
            : Row(
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
                      Navigator.pushNamed(context, "paidAd");
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

  SliderThemeData _getDataSlider(BuildContext context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: primaryColor.withOpacity(0.8),
      inactiveTrackColor: Colors.grey,
      trackHeight: 2.0,
      valueIndicatorColor: Colors.grey,
      disabledThumbColor: Color.fromRGBO(107, 107, 107, 1),
      thumbColor: primaryColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 8.0),
      overlayColor: primaryColor,
    );
  }

  Widget _generateInputs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Form(
        key: _formKey,
        child: Column(    
          children: <Widget>[
            customTextField(context: context, text: "Título", onChanged: (value) { setState(() { adInfo.ad.title = value; }); },
              validator: (value) {
                if (value.isEmpty) {
                  return ("");
                }
                return null;
              },
              index: 0
            ),
            SizedBox(height: 10.0,),
            customTextField(context: context, text: "Descripción (Solo visible en detalle)", onChanged: (value) { setState(() { adInfo.ad.description = value; }); },
              index: 1
            ),
            SizedBox(height: 10.0,),
            customTextField(context: context, text: "Precio Inicial",
              onChanged: (value) {
                setState(() {
                  adInfo.ad.price = double.parse(value);
                  _disccountController.value = TextEditingValue(text: (adInfo.ad.price * adInfo.ad.discountPercentage /100).toStringAsFixed(2));
                });
              },
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: true
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return ("");
                }
                return null;
              },
              index: 2
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Porcentaje (%) Descuento",
                    onChanged: (value) {
                      setState(() {
                        adInfo.ad.discountPercentage = double.parse(value).truncate();
                        _disccountController.value = TextEditingValue(text: (adInfo.ad.price * adInfo.ad.discountPercentage / 100).toStringAsFixed(2));
                        _priceController.value = TextEditingValue(text: (adInfo.ad.price * (1 - adInfo.ad.discountPercentage /100)).toStringAsFixed(2));
                        _giftController.value = TextEditingValue(text: (adInfo.ad.price * (1 - adInfo.ad.discountPercentage /100) * adInfo.ad.giftPercentage).toStringAsFixed(2));
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false
                    ),
                    index: 3,
                  ),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Valor Descuento",
                    bordered: false,
                    enabled: false,
                    fill: Colors.grey.withOpacity(0.6),
                    controller: _disccountController
                  ),
                ),
              ]
            ),
            SizedBox(height: 10.0),
            customTextField(
              context: context,
              text: "Precio Final",
              bordered: false,
              enabled: false,
              fill: Colors.grey.withOpacity(0.6),
              controller: _priceController
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Porcentaje (%) Regalo",
                    onChanged: (value) {
                      setState(() {
                        adInfo.ad.giftPercentage = value == null ? 0 : double.parse(value).truncate();
                        _giftController.value = TextEditingValue(text: (adInfo.ad.price * (1 - adInfo.ad.discountPercentage /100) * adInfo.ad.giftPercentage/100).toStringAsFixed(2));
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false
                    ),
                    index: 4
                  ),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Valor Regalo",
                    bordered: false,
                    enabled: false,
                    fill: Colors.grey.withOpacity(0.6),
                    controller: _giftController
                  ),
                ),
              ]
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Porcentaje (%) Regalo",
                    onChanged: (value) {
                      setState(() {
                        adInfo.ad.giftPercentage = value == null ? 0 : double.parse(value).truncate();
                        _giftController.value = TextEditingValue(text: (adInfo.ad.price * (1 - adInfo.ad.discountPercentage /100) * adInfo.ad.giftPercentage/100).toStringAsFixed(2));
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false
                    ),
                    index: 4
                  ),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Valor Regalo",
                    bordered: false,
                    enabled: false,
                    fill: Colors.grey.withOpacity(0.6),
                    controller: _giftController
                  ),
                ),
              ]
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Fecha Inicio",
                    fill: Colors.transparent,
                    controller: _startDateController,
                    enableInteraction: false,
                    onTap: () {
                      _selectDate(context, adInfo.ad.initialTime ?? 0).then((value) {
                        if(value != null && (adInfo.ad.finalTime == null || value.isBefore(DateTime.fromMillisecondsSinceEpoch(adInfo.ad.finalTime)))) {
                          adInfo.ad.initialTime = value.millisecondsSinceEpoch;
                          _startDateController.text = "${value.day}/${value.month}/${value.year}";
                        }
                      });
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return ("");
                      }
                      return null;
                    },
                    index: 5
                  ),
                ), 
                SizedBox(width: 10.0,),
                Expanded(
                  child: customTextField(
                    context: context,
                    text: "Fecha Fin",
                    fill: Colors.transparent,
                    controller: _endDateController,
                    enableInteraction: false,
                    onTap: () {
                      _selectDate(context, adInfo.ad.finalTime ?? 0).then((value) {
                        if(value != null && (adInfo.ad.initialTime == null || value.isAfter(DateTime.fromMillisecondsSinceEpoch(adInfo.ad.initialTime)))) {
                          adInfo.ad.finalTime = value.millisecondsSinceEpoch;
                          _endDateController.text = "${value.day}/${value.month}/${value.year}";
                        }
                      }); 
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    validator: (value) { 
                      if (value.isEmpty) {
                        return ("");
                      }
                      return null;
                    },
                    index: 6
                  ),
                ),
              ]
            ),
          ],
        ),
      ), 
    );
  }

  Widget customTextField({@required String text, @required BuildContext context, TextEditingController controller, TextInputType keyboardType = TextInputType.text, bool bordered = true, void Function(String) onChanged, Color fill = Colors.transparent, bool enabled = true, bool enableInteraction = true, void Function() onTap, String Function(String) validator, int index = - 1}) {
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
          borderColor: Colors.grey,
        ).decoration,
        onChanged: onChanged,
        onTap: onTap,
        keyboardType: keyboardType,
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context, int initial) async {
    initial = initial == null ? 0 : initial;
    DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().add(Duration(days: 2)),
      initialDate: initial <= 0 ? DateTime.now().add(Duration(days: 2)) : DateTime.fromMillisecondsSinceEpoch(initial),
      lastDate: DateTime.now().add(Duration(days: 367))
    );
    return picked;
  }

  _fieldFocusChange(index, BuildContext context) {
    print("Indice: $index - Length: ${_focusList.length}");
    _focusList[index].unfocus();
    FocusScope.of(context).requestFocus(_focusList[index + 1]);
  }

  Widget customSlider({@required Widget slider, String startText = "", String endText = ""}) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(startText, style: TextStyle(color: Colors.grey)),
            Text(endText, style: TextStyle(color: Colors.grey)),
          ],
        ),
        slider
      ],
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }
}*/
