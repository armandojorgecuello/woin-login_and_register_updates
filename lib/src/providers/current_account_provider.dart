import 'package:flutter/material.dart';
import 'package:woin/src/entities/users/regCliWoiner.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/models/residence_model.dart';
import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/models/woiner_data_model.dart';
import 'package:woin/src/models/woiner_type.dart';

class CurrentAccount with ChangeNotifier {

  UserDetailResponse _usuarioLogueado;
  UserDetailResponse _sesion1;
  UserDetailResponse _sesion2;
  List<WoinerType> woinerType;
  String _tokenCli;
  String _tokenEm;
  String _tokenUser;
  String _passwordsinHash;
  String _imageCli;
  String _imageEm;
  int visitante = 0;
  String lastConection;

  //SABER QUE CUENTA TIENE ACTIVA EN EL MOMENTO
  int _cActiva;
  List<detalleCuenta> ldc; //BIOGRAPHY, TELEFONOS DE CONTACTO
  List<WoinAccountWoinerBacks> woinAccountWoinerBacksCli;
  List<WoinAccountWoinerBacks> woinAccountWoinerBacksEm;


  addBiographyADetalleCuenta(int type, String biography) {
    detalleCuenta detalleCuentaSel;
    for (detalleCuenta det in ldc) {
      if (det.typeWoiner == type) {
        detalleCuentaSel = det;
        break;
      }
    }
    detalleCuentaSel.biography = biography;
  }


  int obtenerBiography(int rol) {
    for (detalleCuenta det in ldc) {
      if (det.typeWoiner == rol && det.biography != "") {
        return 1;
      }
    }
    return 0;
  }

  detalleCuenta obtenerdetalle(int rol) {
    print("DETALLE CUENTA ROL=>"+rol.toString());
    detalleCuenta detalleSel;
    for (detalleCuenta det in ldc) {
      if (det.typeWoiner == rol) {
        detalleSel = det;
        break;
      }
    }
    return detalleSel;
  }

  addDetalle(detalleCuenta dc) {
    if (ldc == null) {
      ldc = new List();
    }

    ldc.add(dc);
  }

  set setSesion(UserDetailResponse user) {
    _usuarioLogueado = user;
  }

  set setSesion1(UserDetailResponse user) {
    _sesion1 = user;
  }

  set setSesion2(UserDetailResponse user) {
    _sesion1 = user;
  }

  set setPersonWoiner(Person p) {
    //_usuarioLogueado.person = p;
  }

  set setImageCli(String img) {
    _imageCli = img;
  }

  set setImageEm(String img) {
    _imageEm = img;
  }

  set setCuentaActiva(int ca) {
    _cActiva = ca;
  }

  set setWoinerType(List<WoinerType> type) {
    woinerType = type;
  }

  addwoinerType(WoinerType type) {
    if (woinerType != null) {
      woinerType.add(type);
    }
  }

  set setTokenCli(String token) {
    _tokenCli = token;
  }

  set setPassword(String pass) {
    _passwordsinHash = pass;
  }

  set setTokenEm(String token) {
    _tokenEm = token;
  }

  set setTokenUser(String token) {
    _tokenUser = token;
  }

  WoinerType obtenerType(int typedefault) {
    WoinerType tipo;
    woinerType.forEach((typeu) => {
          if (typeu.type == typedefault) {tipo = typeu}
        });
    return tipo;
  }

  //OBTENER DATOS DE USUARIO DEFAULT
  UserDetailResponse get getSession => _usuarioLogueado;
  UserDetailResponse get getSesion1 => _sesion1;
  UserDetailResponse get getSesion2 => _sesion2;
  String get getTokenCli => _tokenCli;
  String get getTokenEm => _tokenEm;
  String get getPassword => _passwordsinHash;
  String get getImageCli => _imageCli;
  String get getImageEm => _imageEm;
  int get getCuentaActiva => _cActiva;
  String get getTokenUser => _tokenUser;

  bool tieneTipo() {
    return woinerType.length == 0 ? false : true;
  }

  bool isTwoType() {
    return woinerType.length == 2 ? true : false;
  }

  bool isTipoUser(int type) {
    bool tipo = false;
    woinerType.forEach((typeu) => {
          if (typeu.type == type) {tipo = true}
        });
    return tipo;
  }

  WoinerType tipoWoiner(int type) {
    WoinerType typeDefault;

    woinerType.forEach((typeu) => {
          if (typeu.type == type) {typeDefault = typeu}
        });
    return typeDefault;
  }

  Residences obtenerResidenciaRol(int rol) {
    Residences residenciaSel;
    for (Residences red in _usuarioLogueado.residences) {
      if (red.type == rol) {
        residenciaSel = red;
        break;
      }
    }
    return residenciaSel;
  }

  double calificacionDefault() {
    if (_usuarioLogueado.typeDefault != 0) {
      WoinerType typdef = tipoWoiner(_usuarioLogueado.typeDefault);
      if (typdef != null) {
        return typdef.calification.toDouble();
      }
    }
    return 0;
  }

  double calificacionWoiner(int role) {
    WoinerType woinertypesel;
    for (WoinerType woiner in _usuarioLogueado.woinerType) {
      if (woiner.type == role) {
        woinertypesel = woiner;
        break;
      }
    }
    //print(woinertypesel.calification);
    return woinertypesel.calification.toDouble();
  }

  int tipoWoinerDefault() {
    if (_usuarioLogueado.typeDefault != 0) {
      return tipoWoiner(_usuarioLogueado.typeDefault).type;
    }

    return 0;
  }

  int tienePerson() {
    if (_usuarioLogueado.person == null) {
      return 0;
    } else {
      return 1;
    }
  }
  
  Woiner _woiner;
  Woiner get woiner => _woiner;
  set woiner(Woiner woin){
    _woiner = woin;
    notifyListeners();
  }


}