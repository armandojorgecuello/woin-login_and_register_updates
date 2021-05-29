import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woin/main.dart';
import 'package:woin/src/entities/users/regCliWoiner.dart';

import 'package:woin/src/entities/users/regEmwoiner.dart';
import 'package:woin/src/entities/users/respRegisterUser.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/models/recovery_password_model.dart';
import 'package:woin/src/models/response_htttp_get.dart';
import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/models/user_login.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/exceptions/api.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/user_type_model/simply_user_model.dart';
import 'package:woin/src/models/woin_location_model.dart';
import 'package:woin/src/models/woiner_data_model.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/usuario/codeActivacion.dart';
import 'package:woin/src/presentation/widgets/dialog_reigster_code_user.dart';
import 'package:woin/src/services/Repository/baseApi.dart';
import 'package:http/http.dart' as http;
import 'package:woin/src/widgets/dialog_register.dart';

import 'current_account_provider.dart';
import 'login_provider.dart';

class UserProvider extends BaseApiWoin {

  Future<User> registrarUsuario({User user, context, WoinLocation location, Device device}) async {
    var responseJson;
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "location.latitude": "${location.latitude}",
      "location.longitude": "${location.longitude}",
      "location.altitude": "${location.altitude}",
      "device.name": "${device.name}",
      "device.mac": "${device.mac}",
      "device.ip": "${device.ip}"
    };

    user.device.id = 0;
    user.device.userId = 0;
    user.device.createdAt = 0;
    user.device.updatedAt = 0;

    var response;
    try {
       Uri uri = Uri.http(ruta ,"/api/WoinUser");
      response = await http.post(
        uri,
        headers: header, 
        body: json.encode(user),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => ConfirmVerificationCodeReceive(
            device: device,
            location: location,
            pageTitle: "Crear Cuenta",
            password: user.password,
            userName: user.username,
            closeButonText: "Cerrar",
            title: "Registro Exitoso",
            content: "Ingrese a su correo o mensajes de texto e introduzca el codigo enviado para recuperar su contraseña",
            firstTitle: "Bienvenido Woiner",
            okButtonTex: "Ingresar Código",
          )
        ));
        //Navigator.of(context).pop();
        //Navigator.of(context).push(CupertinoPageRoute(
        //  builder: (context) => ConfirmVerificationCodeReceive(
        //    child: CodeActivacion(
        //      pageTitle: "Crear Cuenta",
        //      device: device,
        //      location: location,
        //      password: user.password,
        //      userName: user.username,
        //    ),
        //    title: "Registro Exitoso",
        //    content: "Ingrese a su correo o mensajes de texto e introduzca el codigo enviado para finalizar el registro",
        //    firstTitle: "Bienvenido Woiner",
        //    closeButonText: "Cerrar",
        //    okButtonTex: "Ingresar Código",
//
        //  )
        //));
        var jsonr = responseJson = json.decode(response.body);
        print(jsonr);
        //respUserRegister ur = respUserRegister.fromJson(jsonr);
        //return ur;
        
      }else{
        var errorResponse = json.decode(response.body);
        Map<dynamic, dynamic> mapResponse = Map.from(errorResponse);
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => ConfirmVerificationCodeReceive(
            device: device,
            location: location,
            pageTitle: "Crear Cuenta",
            password: user.password,
            userName: user.username,
            closeButonText: "Cerrar",
            title: "Solicitud de Registro Rechazada",
            content: mapResponse["message"],
            firstTitle: "Usuario",
            okButtonTex: "Registrarse",
          )
        ));
        respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
        //return ur;
      }
    } on SocketException {
      print('No net');
      respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
      //return ur;
    } on Exception catch(e){
      print("EXCEPTION");
      respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
      //return ur;

    }
  }

  Future<RespUserLoguin> loguin(UserLoguin userLogin, context) async {
    RespUserLoguin _responseUserLogin;
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "location.latitude": "${userLogin.woinLocation.latitude}",
      "location.longitude": "${userLogin.woinLocation.longitude}",
      "location.altitude": "${userLogin.woinLocation..altitude}",
      "device.name": "${userLogin.device.name}",
      "device.mac": "${userLogin.device.mac}",
      "device.ip": "${userLogin.device.ip}"
    };
    userLogin.device.userId = 0;
    userLogin.device.id = 0;
    userLogin.device.createdAt = 0;
    userLogin.device.updatedAt = 0;
    userLogin.code = 0;
    
    var response;
    try {
      Uri uri = Uri.http(ruta , "/api/WoinUser/Auth");
      response = await http.post(
        uri,
        headers: header, body: json.encode(userLogin)
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        _responseUserLogin = RespUserLoguin(
          status: jsonResponse["status"],
          entities: jsonResponse["entities"],
          message: jsonResponse["message"],
          code: jsonResponse["code"]
        );
        _responseUserLogin.entities.forEach((element) { 
          Map<dynamic, dynamic> userDataMap = Map.from(element);
        });
        return _responseUserLogin;
      }else{
        _responseUserLogin = new RespUserLoguin(
          status: false,
          entities: null,
          message: "Username o password incorrecto!"
        );
        return _responseUserLogin;
      }
    } on SocketException {
      _responseUserLogin = new RespUserLoguin(
        status: false,
        entities: null,
        message: "Error al conectar con el servidor."
      );
      return _responseUserLogin;
    }
  }

  Future<RespUserLoguin> activarCuenta(UserLoguin userLogin, context) async {
    var responseJson;
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "location.latitude": "${userLogin.woinLocation.latitude}",
      "location.longitude": "${userLogin.woinLocation..longitude}",
      "location.altitude": "${userLogin.woinLocation..altitude}",
      "device.name": "${userLogin.device.name}",
      "device.mac": "${userLogin.device.mac}",
      "device.ip": "${userLogin.device.ip}"
    };
    var response;
    try {
      Uri uri = Uri.http(ruta , "/api/WoinUser/Activate");
      response = await http.post(
        uri,
        headers: header, 
        body: json.encode(userLogin)
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        RespUserLoguin resp = await userService.loguin(userLogin, context);
        if(resp.status == true){
          List<UserDetailResponse> _userDetail = List();
          resp.entities.forEach((userDetail) async{ 
            final temporalUserDetail = UserDetailResponse.fromJson(userDetail);
            Provider.of<LoginProvider>(context, listen:false).userDetail = temporalUserDetail;
            print(userDetail);
            _userDetail.add(temporalUserDetail);
          });
          Navigator.of(context).pop();
          Provider.of<LoginProvider>(context, listen:false).userLogin = userLogin;
          showgeneralDialogRegister(
            context: context,
            popContent: "Bienvenido a Woin, haz click para dirigirte al Inicio",
            title: "Bienvenido",
            buttonText: "Ir al home",
            onPressed: (){
              Provider.of<LoginProvider>(context, listen:false).isLogin = true;
              Navigator.of(context).push(CupertinoPageRoute(
                builder:(context) => FirstPage()
              ));
            }
          );
        }else{
          closeModal() {Navigator.of(context).pop();}
          showAlerts(context, "Código de activación incorrecto", false, closeModal, null, "Aceptar", "", null);
        }
      }
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    var jsonr = responseJson = json.decode(response.body);
    return RespUserLoguin.fromJson(jsonr);
  }

  Future<respcliWoiner> registroWoiner(cliWoiner cw) async {
    var responseJson;
    userdetalle sesion = new userdetalle();

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + sesion.getTokenUser,
    };

    cw.device.id = 0;
    cw.device.userId = 0;
    cw.device.state = 0;
    cw.device.createdAt = 0;
    cw.device.updatedAt = 0;

    print(json.encode(cw));

    var response;
    try {
      Uri uri = Uri.http(ruta, "/api/WoinWoiner/cliwoin" );
      response = await http.post(
        uri,
        headers: header, body: json.encode(cw)
      );

      if (response.statusCode == 200) {
        var jsonr = responseJson = json.decode(response.body);
        respcliWoiner ur = respcliWoiner.fromJson(jsonr);
        return ur;
        
      } else {
        print("IMPRIME=>" + response.body);
      }
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    } on Exception catch (e) {
      print("EXCEPTION=> " + e.toString());
    }

    print("IMPRIME2=>" + response.body);
  }

  Future<respEmWoiner> registroEmWoiner(emWoiner ew) async {
    var responseJson;
    userdetalle sesion = new userdetalle();

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + sesion.getTokenUser,
    };

    ew.device.id = 0;
    ew.device.userId = 0;
    ew.device.state = 0;
    ew.device.createdAt = 0;
    ew.device.updatedAt = 0;

    print(json.encode(ew));

    var response;
    try {
      Uri uri = Uri.http(ruta, "/api/WoinWoiner/emwoin" );

      response = await http.post(uri,
          headers: header, body: json.encode(ew));

      if (response.statusCode == 200) {
        var jsonr = responseJson = json.decode(response.body);

        respEmWoiner ur = respEmWoiner.fromJson(jsonr);
        return ur;
      } else {
        print("IMPRIME=>" + response.body);
      }
    } on SocketException {
      print('No net');
      // throw FetchDataException('No Internet connection');
    } on Exception catch (e) {
      print("EXCEPTION=> " + e.toString());
    }

    print("IMPRIME2=>" + response.body);
  }

  Future requestRecoveryPasswordCode(BuildContext context, RecoveryPasswordData recoveryPasswordData, geoLocation location  )async{

    var responseJson;
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response;
    try {
       Uri uri = Uri.http(ruta ,"/api/WoinUser/account/recovery/request");
      response = await http.post(
        uri,
        headers: header, 
        body: json.encode(recoveryPasswordData)
      );
      if (response.statusCode == 200) {
        geoLocation gl = new geoLocation();
        await gl.obtenerGeolocalizacion();
         Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => ConfirmVerificationCodeReceive(
            device: gl.getDevices,
            location: gl.getLocation,
            pageTitle: "Modificar Contraseña",
            password: "",
            userName: "",
            closeButonText: "Cerrar",
            title: "Envio Exitoso",
            content: "Ingrese a su correo o mensajes de texto e introduzca el codigo enviado para recuperar su contraseña",
            firstTitle: "Recuperar Contraseña",
            okButtonTex: "Ingresar Código",
          )
        ));
        //showgeneralDialogPromo(
        //  closeButonText: "Cerrar",
        //  context: context,
        //  title: "Envio Exitoso",
        //  content: "Ingrese a su correo o mensajes de texto e introduzca el codigo enviado para recuperar su contraseña",
        //  firstTitle: "Recuperar Contraseña",
        //  okButtonTex: "Ingresar Código",
        //   funcCancelButton: (){
        //    Navigator.of(context).pop();
        //  },
        //  funcOkButton: (){
        //    Navigator.of(context).pop();
        //    Navigator.of(context).push(CupertinoPageRoute(builder: (context){return CodeActivacion(
        //      device: gl.getDevices,
        //      location: gl.getLocation,
        //      pageTitle: "Modificar Contraseña",
        //      password: "",
        //      userName: "",
        //    );}));
        //  }
        //);
        ////Navigator.of(context).push(CupertinoPageRoute(
        //  builder: (context) => ConfirmVerificationCodeReceive(
        //    device: gl.getDevices,
        //    location: gl.getLocation,
        //    pageTitle: "Modificar Contraseña",
        //    password: "",
        //    userName: "",
        //    closeButonText: "Cerrar",
        //    title: "Envio Exitoso",
        //    content: "Ingrese a su correo o mensajes de texto e introduzca el codigo enviado para recuperar su contraseña",
        //    firstTitle: "Recuperar Contraseña",
        //    okButtonTex: "Ingresar Código",
        //  )
        //));
        var jsonr = responseJson = json.decode(response.body);
        print(jsonr);
      }else{
        var errorResponse = json.decode(response.body);
        Map<dynamic, dynamic> mapResponse = Map.from(errorResponse);
        //Navigator.of(context).pop();
        print(mapResponse);
        geoLocation gl = new geoLocation();
        await gl.obtenerGeolocalizacion();
         Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => ConfirmVerificationCodeReceive(
            device: gl.getDevices,
            location: gl.getLocation,
            pageTitle: "Modificar Contraseña",
            password: "",
            userName: "",
            closeButonText: "Cerrar",
            title: "Falló Envío",
            content: mapResponse["message"],
            firstTitle: "Recuperar Contraseña",
            okButtonTex: "Reenviar",
          )
        ));
        //showgeneralDialogPromo(
        //  closeButonText: "Cerrar",
        //  title: "Falló Envío",
        //  content: mapResponse["message"],
        //  firstTitle: "Recuperar Contraseña",
        //  okButtonTex: "Reenviar",
        //  context: context,
        //  funcCancelButton: (){
        //    Navigator.of(context).pop();
        //  },
        //  funcOkButton: (){
        //    Navigator.of(context).push(CupertinoPageRoute(builder: (context){return CodeActivacion(
        //      device: gl.getDevices,
        //      location: gl.getLocation,
        //      pageTitle: "Modificar Contraseña",
        //      password: "",
        //      userName: "",
        //    );}));
        //  }
        //);
        //Navigator.of(context).push(CupertinoPageRoute(
        //  builder: (context) => ConfirmVerificationCodeReceive(
        //    device: gl.getDevices,
        //    location: gl.getLocation,
        //    pageTitle: "Modificar Contraseña",
        //    password: "",
        //    userName: "",
        //    closeButonText: "Cerrar",
        //    title: "Falló Envío",
        //    content: mapResponse["message"],
        //    firstTitle: "Recuperar Contraseña",
        //    okButtonTex: "Reenviar",
        //  )
        //));
        respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
        //return ur;
        return response;
      }
    } on SocketException {
      print('No net');
      respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
      return response;
      //return ur;
    } on Exception catch(e){
      print("EXCEPTION");
      respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
      //return ur;
      return response;

    }
  }

  Future sendCodeToRecoveryPassword(BuildContext context, SendRecoveryPasswordData recoveryPasswordData, geoLocation location)async{
    
    var responseJson;
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response;
    try {
       Uri uri = Uri.http(ruta ,"/api/WoinUser/account/recovery/submit");
      response = await http.post(
        uri,
        headers: header, 
        body: json.encode(recoveryPasswordData)
      );
      if (response.statusCode == 200) {
        geoLocation gl = new geoLocation();
        await gl.obtenerGeolocalizacion();
        showgeneralDialogPromo(
          closeButonText: "Cerrar",
          context: context,
          title: "Envio Exitoso",
          content: "Ingrese a su correo o mensajes de texto e introduzca el codigo enviado para recuperar su contraseña",
          firstTitle: "Recuperar Contraseña",
          okButtonTex: "Ingresar Código",
           funcCancelButton: (){
            Navigator.of(context).pop();
          },
          funcOkButton: (){
            Navigator.of(context).pop();
            Navigator.of(context).push(CupertinoPageRoute(builder: (context){return CodeActivacion(
              device: gl.getDevices,
              location: gl.getLocation,
              pageTitle: "Modificar Contraseña",
              password: "",
              userName: "",
            );}));
          }
        );
        var jsonr = responseJson = json.decode(response.body);
        print(jsonr);
      }else{
        var errorResponse = json.decode(response.body);
        Map<dynamic, dynamic> mapResponse = Map.from(errorResponse);
        //Navigator.of(context).pop();
        print(mapResponse);
        geoLocation gl = new geoLocation();
        await gl.obtenerGeolocalizacion();
        showgeneralDialogPromo(
          closeButonText: "Cerrar",
          title: "Falló Envío",
          content: mapResponse["message"],
          firstTitle: "Recuperar Contraseña",
          okButtonTex: "Reenviar",
          context: context,
          funcCancelButton: (){
            Navigator.of(context).pop();
          },
          funcOkButton: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context){return CodeActivacion(
              device: gl.getDevices,
              location: gl.getLocation,
              pageTitle: "Modificar Contraseña",
              password: "",
              userName: "",
            );}));
          }
        );
        
        respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
        //return ur;
        return response;
      }
    } on SocketException {
      print('No net');
      respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
      return response;
      //return ur;
    } on Exception catch(e){
      print("EXCEPTION");
      respUserRegister ur = respUserRegister(status: false,message: "ERROR AL REGISTRAR",usuario: null);
      //return ur;
      return response;
    }
  }

  Future dataWoiner(int role, String token) async {
    var responseJson;

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'bearer ' + token,
    };

    var response;
    try {
      Uri uri = Uri.http(ruta, "/api/WoinWoiner/getWoiner/$role" );

      response = await http.get(
          uri,
          headers: header);

      if (response.statusCode == 200) {
        var jsonr = responseJson = json.decode(response.body);
        woinerAccount ur = woinerAccount.fromJson(jsonr);
        List entities = jsonr["entities"];
        entities.forEach((element) { 
          Map<dynamic, dynamic> woinData = Map.from(element);
          Woiner woinerData = Woiner.fromJson(woinData); 
        });
        return response;
      } else {
        woinerAccount wa= new woinerAccount(
          status: false,
          woinerData: null,
          message: "Error interno en el servidor, intente más tarde"
        );
        return response;
      }
    } on SocketException {
      woinerAccount wa= new woinerAccount(
          status: false,
          woinerData: null,
          message: "Error al conectar al  servidor, intente más tarde"
      );
      return response;

    } on Exception catch (e) {
      print("RESPUESTA=>"+response.body);
      woinerAccount wa= new woinerAccount(
          status: false,
          woinerData: null,
          message: "Excepcion interno en el servidor, intente más tarde"
      );
      return response;
    }

    //print("IMPRIME2=>" + response.body);
  }

  Future<List<userTransactions>> usuariosTransactions(filterTransaction filter) async {
      var responseJson;
      userdetalle sesion = new userdetalle();

      final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm}',
    };

    print(
        'Bearer ${sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm}');

    var body = {"search": filter.search, "type": filter.type};
    print(json.encode(body));

    var response;
    try {
      Uri uri = Uri.http(ruta, "/api/WoinWoiner/search/${filter.pageDesde}/${filter.pageHasta}" );

      response = await http.post(
          uri,
          headers: header,
          body: json.encode(body));

      if (response.statusCode == 200) {
        var jsonr = responseJson = json.decode(response.body);

        respUserTransacction ur = respUserTransacction.fromJson(jsonr);
        if (ur.status) {
          //print(ur.usuarios);
          if (filter.type == 0) {
            for (userTransactions u in ur.usuarios) {
              u.red = 1;
            }
          }
          return ur.usuarios;
        } else {
          return null;
        }
      } else {
        print("IMPRIME=>" + response.body);
      }
    } on SocketException {
      print('No net');
      return null;
    } on Exception catch (e) {
      print("EXCEPTION=> " + e.toString());
      return null;
    }
  }

  void dispose() {}
}

final userService = UserProvider();
