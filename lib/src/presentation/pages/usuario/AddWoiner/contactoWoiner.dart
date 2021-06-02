import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Persons/userViews.dart';

class Contactoswoiner extends StatefulWidget {
  contactoWoiner contacto;
  int typeWoiner;
  Contactoswoiner({this.contacto, this.typeWoiner});
  @override
  _ContactoswoinerState createState() => _ContactoswoinerState();
}

class _ContactoswoinerState extends State<Contactoswoiner> {
  int visibletec = 0;
  final _formKey = GlobalKey<FormState>();
  var myFormat = new DateFormat('yyyy-MM-dd');
  TextEditingController telcontactoController = new TextEditingController();
  TextEditingController whatsappController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController callcenterController = new TextEditingController();
  final GlobalKey<FormFieldState> _keytelcontactoController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keywhatsappController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyemailController = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keycallcenterController = GlobalKey<FormFieldState>();

  int errfecha = 0;
  int errgenero = 0;

  // Navigator.of(context).pop();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.contacto != null) {
      if (widget.contacto.telContacto != null) {
        telcontactoController.text = widget.contacto.telContacto;
      }
      if (widget.contacto.whatsapp != null) {
        whatsappController.text = widget.contacto.whatsapp;
      }
      if (widget.contacto.email != null) {
        emailController.text = widget.contacto.email;
      }
      if (widget.contacto.callCenter != null) {
        callcenterController.text = widget.contacto.callCenter;
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

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "contacto",
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: _appBar(context),
        backgroundColor: Colors.grey[300],
        body: _body(context),
      ),
    );
  }

  SingleChildScrollView _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 90.0.h ,
        child: Column(
          children: <Widget>[
            _phoneContactCard(context),
            Expanded(
              child: Container(),
            ),
            _buttons(context),
          ],
        ),
      ),
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
          Padding(
            padding: EdgeInsets.only(
              left: 3.0.w,
              right: 3..w
            ),
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
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    'Cancelar',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: Color(0xff1ba6d2),
                      fontSize: 12.0.sp
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
          ),
          Padding(
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
                      fontSize:12.0.sp
                    ),
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
              padding: EdgeInsets.only(
                  left: 30, right: 30, top: 12, bottom: 12),
              color: Color(0xff1ba6d2),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  contactoWoiner contacto;
                  if (emailController.text == "" &&
                      telcontactoController.text == "" &&
                      whatsappController.text == "" &&
                      callcenterController.text == "") {
                    contacto = null;
                  } else {
                    contacto = new contactoWoiner(
                        callCenter: callcenterController.text,
                        email: emailController.text,
                        telContacto: telcontactoController.text,
                        whatsapp: whatsappController.text);
                  }
                  Navigator.of(context).pop(contacto);
                } else {
                  print("Errores");
                }
                // Navigator.of(context).pop(imgFile);
              }
            ),
          ),
        ],
      ),
    );
  }

  Padding _phoneContactCard(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 1.0.h,
          bottom: 1.0.h
        ),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal:2.0.w,
            vertical:0.0
          ),
          children: <Widget>[
            Form(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.0.h,bottom: 3.0.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _titleItem("Teléfono de contacto"),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:3.0.w,
                            vertical:0.0
                          ),
                          child: _textFormField(
                            context,
                            telcontactoController,
                            0,
                            10,
                            "Teléfono incorrecto (min= 10 digitos)",
                            "Teléfono de contacto",
                            TextInputType.number,
                            _keytelcontactoController
                          ),
                        ),
                        _titleItem("Whatsapp"),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:3.0.w,
                            vertical:0.0
                          ),
                          child: _textFormField(
                            context,
                            whatsappController,
                            0,
                            10,
                            "Número incorrecto (min= 10 digitos)",
                            "Número de whatsapp",
                            TextInputType.number,
                            _keywhatsappController
                          ),
                        ),
                        widget.typeWoiner == 3
                            ? _titleItem("Email de contacto")
                            : SizedBox(),
                        widget.typeWoiner == 3
                          ? _emailTextField(context)
                          : SizedBox(),
                        widget.typeWoiner == 3
                          ? _titleItem("Número de Call Center")
                            : SizedBox(),
                        widget.typeWoiner == 3
                          ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:3.0.w,
                            vertical:0.0
                          ),
                          child: _textFormField(
                            context,
                            callcenterController,
                            0,
                            7,
                            "Call center incorrecto",
                            "Número de call center",
                            TextInputType.number,
                            _keycallcenterController
                          ),
                        ): SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  Padding _emailTextField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:3.0.w,
        vertical:0.0
      ),
      child: TextFormField(
        key: _keyemailController,
        onChanged: (value){
          _keyemailController.currentState.validate();
        },
        maxLength: 30,
        validator: (val) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(val);
          if (val.length > 0 &&
              !emailValid) {
            return "Email incorrecto";
          } else {
            return null;
          }
        },
        controller: emailController,
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
          focusedErrorBorder:OutlineInputBorder(
            borderRadius:BorderRadius.all(Radius.circular(50.0)),
            borderSide:BorderSide(color: Colors.red[600])
            // borderSide: new BorderSide(color: Colors.teal)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius:BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.red[600])
          ),
          errorStyle: TextStyle(
            fontSize: 12.0.sp,
          ),
          contentPadding:EdgeInsets.all(10),
          hintText: "Email de contacto",
          labelStyle: TextStyle(color: Color(0xfc979797)),
          enabledBorder: new OutlineInputBorder(
            borderRadius:BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.grey[300])
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius:BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Colors.grey[500])
          ),
        ),
      ),
    );
  }

  TextFormField _textFormField(BuildContext context, TextEditingController controller, int min, int max, String errorText, String hint, TextInputType textType, GlobalKey<FormFieldState<dynamic>> key) {
    return TextFormField(
      maxLength: 10,
      validator: (val) {
        if (val.length > min && val.length < max) {
          return errorText;
        } else {
          return null;
        }
      },
      controller:controller,
      key: key,
      onChanged: (value){
        key.currentState.validate();
      },
      style: TextStyle(
        color: Color(0xfc979797),
        fontSize:12.0.sp
      ),
      keyboardType: textType, 
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
        errorStyle: TextStyle(fontSize:11.0.sp),
        contentPadding: EdgeInsets.all(10),
        hintText: hint,// ,
        labelStyle:TextStyle(color: Color(0xfc979797)),
        enabledBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide(color: Colors.grey[300])
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide(color: Colors.grey[500])
        ),
      ),
    );
  }

  Align _titleItem(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:6.0.w,
          vertical: 1.5.h
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.grey[700]),
        )
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Contacto y otros",
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
