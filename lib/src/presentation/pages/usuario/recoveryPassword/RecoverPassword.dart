import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/main.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/models/recovery_password_model.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/providers/user_service.dart';


class RecoverPassword extends StatefulWidget {
  RecoverPassword({Key key}) : super(key: key);

  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController keyWordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormFieldState> _keyWordController = GlobalKey<FormFieldState>(); 
  final GlobalKey<FormFieldState> _keyUserNameController = GlobalKey<FormFieldState>(); 
  bool recoveryPassword = true;
  double heigth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: _body(),
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: Container(
        height: heigth ??  93.0.h,
        width: 100.0.w,
        color: Colors.white,
        child:Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _image(),
              SizedBox(height: 5.0.h,),  
              Padding(
                padding: EdgeInsets.symmetric(horizontal:3.0.w),
                child: Text("Escriba su usuario", style: TextStyle(color:Colors.black, fontSize:12.0.sp)),
              ),  
              SizedBox(height: 1.0.h,), 
              _textFieldUserName(
                context: context,
                errorTextMin: "Ingrese su usuario",
                errorTextMax:  null,
                maxLength: 12,
                minLength: 8,
                key: _keyUserNameController,
                labelText: "Cedula de Ciudadnía, Nit, Rut",
                controller:  usernameController,
                preFixIcon: Icon(Icons.person, size:14.0.sp, color:Colors.grey),
                hintText: "Cedula de Ciudadnía, Nit, Rut",
                inputType: TextInputType.number
              ),
              SizedBox(height: 3.0.h,), 
              Padding(
                padding: EdgeInsets.symmetric(horizontal:3.0.w),
                child: Text("Escriba su palabra clave", style: TextStyle(color:Colors.black, fontSize:12.0.sp)),
              ),  
              SizedBox(height: 1.0.h,), 
              _textFieldUserName(
                context: context,
                errorTextMin: "Palabra clave",
                errorTextMax:  null,
                maxLength: 12,
                minLength: 5,
                key: _keyWordController ,
                labelText: "Palabra clave",
                controller: keyWordController,
                preFixIcon: Icon(Icons.lock, size:14.0.sp, color:Colors.grey),
                hintText: "Palabra clave",
                inputType: TextInputType.text
              ),
              SizedBox(height: 3.0.h,), 
              //_textFieldEmail(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:3.0.w),
                child: Text("Seleccione un metodo de recuperacion", style: TextStyle(color:Colors.black, fontSize:12.0.sp)),
              ), 
              SizedBox(height: 1.0.h,),
              _buttonsRegister(),
              SizedBox(height: 3.0.h,), 
              Center(
                child: Container(
                  width: 80.0.w,
                  height: 5.0.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("¿Ya tienes un código? ", style: TextStyle(fontSize: 11.0.sp)),
                      GestureDetector(
                        child: Text("Ingresar Código", style: TextStyle(color: Color(0xff1ba6d2), fontSize: 11.0.sp),)
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.0.h,),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buttonsRegister(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:3.0.w),
      child: Container(
        height: 10.0.h,
        width: 100.0.w,
        color:Colors.white,
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                elevation: 0,
                child: Container(
                  width: 37.0.w,
                  height: 7.0.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.phone_android,
                        size:12.0.sp,
                        color: Color(0xff1ba6d2),
                      ),
                      Text(
                        'Numero de Teléfono',
                        style: TextStyle(
                        fontFamily: "Roboto",
                        color: Color(0xff1ba6d2),
                        fontSize:10.0.sp),
                      ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: BorderSide(color:Color(0xff1ba6d2))
                ),
                color: Colors.white,
                onPressed: ()async {
                  if ( _formKey.currentState.validate() ) {
                    geoLocation gl = new geoLocation();
                    await gl.obtenerGeolocalizacion();
                    RecoveryPasswordData recoveryPasswordData= RecoveryPasswordData(
                      typerecovery: 0,
                      username: usernameController.text,
                      //code: keyWordController.text
                    );
                    final response = await UserProvider().requestRecoveryPasswordCode(
                      _scaffoldKey.currentContext, 
                      recoveryPasswordData,
                      gl
                    );
                  }else{
                    setState((){
                      heigth = 98.0.h;
                    });
                  }
                }
              ),
              RaisedButton(
                elevation: 0,
                child: Container(
                  width: 37.0.w,
                  height: 7.0.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        size: 10.0.sp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width:1.0.w
                      ),
                      Text(
                        'Correo Electrónico',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.white,
                          fontSize: 10.0.sp
                        ),
                      ),
                      
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                color: Color(0xff1ba6d2),
                onPressed:  () async{
                  if ( _formKey.currentState.validate() ) {
                    showDialogV2( context: context, builder: (BuildContext context) => CustomDialogLoading());
                    geoLocation gl = new geoLocation();
                    await gl.obtenerGeolocalizacion();
                    RecoveryPasswordData recoveryPasswordData= RecoveryPasswordData(
                      typerecovery: 1,
                      username: usernameController.text,
                      //code: keyWordController.text
                    );
                    var responseRecoveryPassword = await UserProvider().requestRecoveryPasswordCode( _scaffoldKey.currentContext ,  recoveryPasswordData, gl );
                    
                  }else{
                    setState((){
                      heigth = 98.0.h;
                    });
                  }
                }
              ),
            ],
          ),
      ),
    );
  }

  Padding _textFieldUserName({
    BuildContext context, 
    String errorTextMin, 
    String errorTextMax, 
    int maxLength, 
    int minLength, 
    GlobalKey<FormFieldState<dynamic>> key, 
    TextEditingController controller,
    String labelText,
    Widget preFixIcon,
    String hintText,
    TextInputType inputType
  }) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:3.0.w),
      child: TextFormField(
        validator: (val) {
          if (val.length < minLength) {
            return errorTextMin;
          }
          if (val.length >maxLength) {
            return errorTextMax;
          }
          return null;
        },
        key: key,
        onChanged: (String value){
          key.currentState.validate();
        },
        maxLength: 15,
        maxLines: 1,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
            RegExp(r"\s")
          )
        ],
        controller: controller,
        style: TextStyle(
          color: Color(0xfc979797),
          fontSize: 11.0.sp
        ),
        keyboardType: inputType,
        autocorrect: true,
        autofocus: false,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xfc979797),
            fontSize: 11.0.sp
          ),
          suffixIcon: Icon(Icons.phone_android, size:14.0.sp, color:Colors.white),
          prefixIcon: preFixIcon,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
              borderSide: BorderSide( color: Colors.red[600])
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all( Radius.circular(5.0)),
              borderSide: BorderSide( color: Colors.red[600])
          ),
          errorStyle: TextStyle(fontSize: 8.0.sp),
          contentPadding: EdgeInsets.all(10),
          //labelText: labelText,
          floatingLabelBehavior:FloatingLabelBehavior.always ,
          labelStyle: TextStyle(color: Color(0xfc979797)),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
            borderSide: BorderSide( color: Colors.grey[300])
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[500])
          ),
        ),
      ),
    );
  }

  //Padding _textFieldEmail(BuildContext context,) {
  //  return Padding(
  //    padding: EdgeInsets.symmetric(horizontal:3.0.w),
  //    child: TextFormField(
  //      validator: (val) {
  //        bool emailValid = RegExp(
  //            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //            .hasMatch(val);
  //        if (!emailValid) {
  //          return "Correo incorrecto";
  //        } else {
  //          return null;
  //        }
  //      },
  //      key: _keyEmailController,
  //      onChanged: (String value){
  //        _keyEmailController.currentState.validate();
  //      },
  //      inputFormatters: [
  //        FilteringTextInputFormatter.deny(
  //          RegExp(r"\s")
  //        )
  //      ],
  //      maxLength: 80,
  //      maxLines: 1,
  //      controller: emailController,
  //      style: TextStyle( 
  //        color: Color(0xfc979797),
  //        fontSize:11.0.sp),
  //      keyboardType: TextInputType.emailAddress,
  //      autocorrect: true,
  //      autofocus: false,
  //      decoration: InputDecoration(
  //        suffixIcon: Icon(Icons.email, color:Colors.white, size:14.0.sp),
  //        counterText: "",
  //        isDense: true,
  //        focusedErrorBorder: OutlineInputBorder(
  //          borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //          borderSide: BorderSide(
  //            color: Colors.red[600]
  //          )
  //        ),
  //        hintStyle: TextStyle( 
  //          color: Color(0xfc979797),
  //          fontSize:11.0.sp
  //        ),
  //        hintText: "Correo electrónico",
  //        errorBorder: OutlineInputBorder(
  //          borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //          borderSide: BorderSide(color: Colors.red[600])
  //        ),
  //        errorStyle: TextStyle( fontSize:8.0.sp),
  //        contentPadding: EdgeInsets.all(10),
  //        //labelText: "Correo electrónico",
  //        prefixIcon: Icon(Icons.laptop, size:14.0.sp),
  //        labelStyle: TextStyle(color: Color(0xfc979797)),
  //        enabledBorder: new OutlineInputBorder(
  //            borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //            borderSide: BorderSide(color: Colors.grey[300])
  //        ),
  //        focusedBorder: new OutlineInputBorder(
  //            borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //            borderSide: BorderSide(color: Colors.grey[500])
  //        ),
  //      ),
  //    ),
  //  );
  //}


  Center _image() {
    return Center(
      child: Image.asset('assets/images/login.png',
      height: 35.0.h,
      fit: BoxFit.cover),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Recuperar Credenciales",style: TextStyle(color: Color(0xff1ba6d2),fontSize: 14.0.sp),),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
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
