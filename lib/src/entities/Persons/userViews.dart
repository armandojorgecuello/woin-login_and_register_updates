import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';
import 'package:woin/src/entities/Persons/gender.dart';
import 'package:woin/src/entities/Persons/typeDocument.dart';
import 'package:woin/src/entities/users/regEmwoiner.dart';

class nameForm {
  String primerApellido;
  String segundoApellido;
  String primerNombre;
  String segundoNombre;
  genero gender;
  String fechaNacimiento;
  nameForm(
      {this.primerApellido,
      this.segundoApellido,
      this.primerNombre,
      this.segundoNombre,
      this.gender,
      this.fechaNacimiento});
}

class typeAndDocument {
  String numero;
  typeDocument tipodocumento;
  countryCity lugarExpedicion;

  typeAndDocument({this.numero, this.tipodocumento, this.lugarExpedicion});
}

class infoEmpresa {
  String nombre;
  String nit;
  String fechaCreacion;
  Category categoria;
  countryCity lugarUbicacion;
  String direccion;
  infoEmpresa(
      {this.nit,
      this.nombre,
      this.lugarUbicacion,
      this.fechaCreacion,
      this.categoria,
      this.direccion});
}

class webRedes {
  String paginaWeb;
  List<SocialProfiles> lsp;
  webRedes({this.paginaWeb, this.lsp});
  SocialProfiles obtenerRed(int type) {
    for (SocialProfiles soc in this.lsp) {
      if (soc.type == type) {
        return soc;
      }
    }
    return null;
  }
}

class ubicacionWoiner {
  String direccion;
  countryCity lugarUbicacion;

  ubicacionWoiner({this.direccion, this.lugarUbicacion});
}

class contactoWoiner {
  String telContacto;
  String whatsapp;
  String email;
  String callCenter;
  contactoWoiner(
      {this.telContacto, this.whatsapp, this.callCenter, this.email});

  int validContactoEm() {
    if (this.callCenter != "" ||
        this.telContacto != "" ||
        this.whatsapp != "") {
      return 1;
    }
    return 0;
  }
}

class credentials {
  String username;
  String password;

  credentials({this.username, this.password});
}

class contactoUser {
  String email;
  String telcontacto;

  contactoUser({this.email, this.telcontacto});
}
