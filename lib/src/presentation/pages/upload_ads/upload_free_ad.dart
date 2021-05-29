/*import 'dart:io';
import 'package:woin/src/entities/Ads/Ad.dart';
import 'package:woin/src/presentation/providers/upload_ad_provider.dart';
import 'package:woin/src/presentation/widgets/card_ad.dart';
import 'package:woin/src/presentation/widgets/outline_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

class UploadFreeAd extends StatefulWidget {
  @override
  _UploadFreeAdState createState() => _UploadFreeAdState();
}

class _UploadFreeAdState extends State<UploadFreeAd> {
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
        child: _image == null
            ? Image.asset("assets/images/logo.png", fit: BoxFit.fill)
            : Image.file(
                _image,
                fit: BoxFit.fill,
              ),
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.height * 0.05)),
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
              child: Icon(
                Icons.chevron_left,
                color: primaryColor,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          primary: true,
          title: Text("Subir Anuncio Gratis",
              style: TextStyle(color: primaryColor)),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2,
                  vertical: 5.0),
              child: Card(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.05),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: CardAd(
                      Ad(
                          nameCompany: adInfo.ad.nameCompany,
                          currentStock: 0,
                          initialStock: 0,
                          title: adInfo.ad.title,
                          description: adInfo.ad.description,
                          price: adInfo.ad.price,
                          giftPercentage: adInfo.ad.giftPercentage,
                          discountPercentage: adInfo.ad.discountPercentage,
                          state: adInfo.ad.state,
                          subcategoryId: null,
                          woinerId: null),
                      Image.asset(_logo),
                      image,
                      orientation: AdOrientation.vertical,
                    ))
                  ],
                ),
              ),
            ),
            _ok ? _generateOk() : _generateInputs()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: _ok
                ? Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.2),
                    child: RaisedButton(
                      child: Text("Ir al Inicio",
                          style: TextStyle(color: Colors.white)),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          side: BorderSide(
                              color: Color.fromRGBO(0, 117, 177, 1))),
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
                          child: Text("X Cerrar",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 117, 177, 1))),
                          elevation: 0.0,
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              side: BorderSide(
                                  color: Color.fromRGBO(0, 117, 177, 1))),
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
                          child: Text("Continuar",
                              style: TextStyle(color: Colors.white)),
                          elevation: 0.0,
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              side: BorderSide(
                                  color: Color.fromRGBO(0, 117, 177, 1))),
                          color: Color.fromRGBO(0, 117, 177, 1),
                          colorBrightness: Brightness.dark,
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                _ok = true;
                              }
                            });
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

  Widget _generateOk() {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Container(
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.height * 0.03)),
                child: Image.asset('assets/images/check_circle.png'))),
        SizedBox(
          height: 20.0,
        ),
        Text("Anuncio Gratis Exitoso",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        Text("Verificación máxima en 24 horas",
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    ));
  }

  Widget _generateInputs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            customTextField(
                context: context,
                text: "Título",
                onChanged: (value) {
                  setState(() {
                    adInfo.ad.title = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return ("");
                  }
                  return null;
                },
                index: 0),
            SizedBox(
              height: 10.0,
            ),
            customTextField(
                context: context,
                text: "Descripción (Solo visible en detalle)",
                onChanged: (value) {
                  setState(() {
                    adInfo.ad.description = value;
                  });
                },
                index: 1),
            SizedBox(
              height: 10.0,
            ),
            customTextField(
                context: context,
                text: "Precio Inicial",
                onChanged: (value) {
                  setState(() {
                    adInfo.ad.price = double.parse(value);
                    _disccountController.value = TextEditingValue(
                        text: (adInfo.ad.price *
                                (adInfo.ad.discountPercentage) /
                                100)
                            .toStringAsFixed(2));
                  });
                },
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                validator: (value) {
                  if (value.isEmpty) {
                    return ("");
                  }
                  return null;
                },
                index: 2),
            SizedBox(
              height: 10.0,
            ),
            Row(children: <Widget>[
              Expanded(
                child: customTextField(
                  context: context,
                  text: "Porcentaje (%) Descuento",
                  onChanged: (value) {
                    setState(() {
                      adInfo.ad.discountPercentage =
                          double.parse(value).truncate();
                      _disccountController.value = TextEditingValue(
                          text: (adInfo.ad.price *
                                  adInfo.ad.discountPercentage /
                                  100)
                              .toStringAsFixed(2));
                      _priceController.value = TextEditingValue(
                          text: (adInfo.ad.price *
                                  (1 - adInfo.ad.discountPercentage / 100))
                              .toStringAsFixed(2));
                      _giftController.value = TextEditingValue(
                          text: (adInfo.ad.price *
                                  (1 - adInfo.ad.discountPercentage / 100) *
                                  adInfo.ad.giftPercentage)
                              .toStringAsFixed(2));
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  index: 3,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: customTextField(
                    context: context,
                    text: "Valor Descuento",
                    bordered: false,
                    enabled: false,
                    fill: Colors.grey.withOpacity(0.6),
                    controller: _disccountController),
              ),
            ]),
            SizedBox(height: 10.0),
            customTextField(
                context: context,
                text: "Precio Final",
                bordered: false,
                enabled: false,
                fill: Colors.grey.withOpacity(0.6),
                controller: _priceController),
            SizedBox(
              height: 10.0,
            ),
            Row(children: <Widget>[
              Expanded(
                child: customTextField(
                    context: context,
                    text: "Porcentaje (%) Regalo",
                    onChanged: (value) {
                      setState(() {
                        adInfo.ad.giftPercentage =
                            double.parse(value).truncate();
                        _giftController.value = TextEditingValue(
                            text: (adInfo.ad.price *
                                    (1 - adInfo.ad.discountPercentage / 100) *
                                    adInfo.ad.giftPercentage /
                                    100)
                                .toStringAsFixed(2));
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    index: 4),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: customTextField(
                    context: context,
                    text: "Valor Regalo",
                    bordered: false,
                    enabled: false,
                    fill: Colors.grey.withOpacity(0.6),
                    controller: _giftController),
              ),
            ]),
            SizedBox(height: 10.0),
            Row(children: <Widget>[
              Expanded(
                child: customTextField(
                    context: context,
                    text: "Fecha Inicio",
                    fill: Colors.transparent,
                    controller: _startDateController,
                    enableInteraction: false,
                    onTap: () {
                      _selectDate(context).then((value) {
                        if (value != null &&
                            (adInfo.ad.finalTime == 0 ||
                                value.isBefore(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        1000)))) {
                          adInfo.ad.initialTime = value.millisecondsSinceEpoch;
                          _startDateController.text =
                              "${value.day}/${value.month}/${value.year}";
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
                    index: 5),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: customTextField(
                    context: context,
                    text: "Fecha Fin",
                    fill: Colors.transparent,
                    controller: _endDateController,
                    enableInteraction: false,
                    onTap: () {
                      _selectDate(context).then((value) {
                        if (value != null &&
                            (adInfo.ad.initialTime == 0 ||
                                value.isAfter(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        adInfo.ad.initialTime)))) {
                          adInfo.ad.initialTime = value.millisecondsSinceEpoch;
                          _endDateController.text =
                              "${value.day}/${value.month}/${value.year}";
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
                    index: 6),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget customTextField(
      {@required String text,
      @required BuildContext context,
      TextEditingController controller,
      TextInputType keyboardType = TextInputType.text,
      bool bordered = true,
      void Function(String) onChanged,
      Color fill = Colors.transparent,
      bool enabled = true,
      bool enableInteraction = true,
      void Function() onTap,
      String Function(String) validator,
      int index = -1}) {
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
                borderColor: Colors.grey)
            .decoration,
        onChanged: onChanged,
        onTap: onTap,
        keyboardType: keyboardType,
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now().add(Duration(days: 2)),
        initialDate: DateTime.now().add(Duration(days: 2)),
        lastDate: DateTime(2050));
    return picked;
  }

  _fieldFocusChange(index, BuildContext context) {
    // print("index: $index - length: ${_focusList.length}");
    _focusList[index].unfocus();
    FocusScope.of(context).requestFocus(_focusList[index + 1]);
  }

  Widget customSlider(
      {@required Widget slider, String startText = "", String endText = ""}) {
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
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }
}

class FormUpload extends StatefulWidget {
  @override
  _FormUploadState createState() => _FormUploadState();
}

class _FormUploadState extends State<FormUpload> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
