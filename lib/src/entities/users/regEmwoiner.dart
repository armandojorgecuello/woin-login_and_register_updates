import 'package:woin/src/entities/users/regCliWoiner.dart';
import 'package:woin/src/models/woiner_type.dart';

// ignore: camel_case_types
class emWoiner {
  person2 person;
  int userId;
  String companyName;
  String dateCompanyCreate;
  Document documentCompany;
  int categoryId;
  List<Phones> phones;
  String email;
  String webPage;
  List<SocialProfiles> socialProfiles;
  int cityId;
  WoinLocationCompany woinLocationCompany;
  WoinerType woinerType;
  Device2 device;
  WoinLocationCompany woinLocation;
  int isDefault;
  String direccionEmpresa;
  String image;
  String biography;

  emWoiner(
      {this.person,
      this.userId,
      this.companyName,
      this.dateCompanyCreate,
      this.documentCompany,
      this.categoryId,
      this.phones,
      this.email,
      this.webPage,
      this.socialProfiles,
      this.cityId,
      this.woinLocationCompany,
      this.woinerType,
      this.device,
      this.woinLocation,
      this.isDefault,
      this.image,
      this.biography,
      this.direccionEmpresa});

  emWoiner.fromJson(Map<String, dynamic> json) {
    person =
        json['person'] != null ? new person2.fromJson(json['person']) : null;
    userId = json['userId'];
    companyName = json['companyName'];
    dateCompanyCreate = json['dateCompanyCreate'];
    documentCompany = json['documentCompany'] != null
        ? new Document.fromJson(json['documentCompany'])
        : null;
    categoryId = json['categoryId'];
    direccionEmpresa = json['companyAddress'];
    if (json['phones'] != null) {
      phones = new List<Phones>();
      json['phones'].forEach((v) {
        phones.add(new Phones.fromJson(v));
      });
    }
    email = json['email'];
    webPage = json['webPage'];
    if (json['socialProfiles'] != null) {
      socialProfiles = new List<SocialProfiles>();
      json['socialProfiles'].forEach((v) {
        socialProfiles.add(new SocialProfiles.fromJson(v));
      });
    }
    cityId = json['cityId'];
    woinLocationCompany = json['woinLocationCompany'] != null
        ? new WoinLocationCompany.fromJson(json['woinLocationCompany'])
        : null;
    woinerType = json['woinerType'] != null
        ? new WoinerType.fromJson(json['woinerType'])
        : null;
    device =
        json['device'] != null ? new Device2.fromJson(json['device']) : null;
    woinLocation = json['woinLocation'] != null
        ? new WoinLocationCompany.fromJson(json['woinLocation'])
        : null;
    isDefault = json['isDefault'];
    image = json['image'];
    biography = json['biography'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.person != null) {
      data['person'] = this.person.toJson();
    } else {
      data['person'] = null;
    }

    data['userId'] = this.userId;
    data['companyName'] = this.companyName;
    data['dateCompanyCreate'] = this.dateCompanyCreate;
    if (this.documentCompany != null) {
      data['documentCompany'] = this.documentCompany.toJson();
    }
    data['categoryId'] = this.categoryId;
    if (this.phones != null) {
      data['phones'] = this.phones.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['webPage'] = this.webPage;
    if (this.socialProfiles != null) {
      data['socialProfiles'] =
          this.socialProfiles.map((v) => v.toJson()).toList();
    } else {
      this.socialProfiles = null;
    }
    data['cityId'] = this.cityId;
    if (this.woinLocationCompany != null) {
      data['woinLocationCompany'] = this.woinLocationCompany.toJson();
    }
    if (this.woinerType != null) {
      data['woinerType'] = this.woinerType.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device.toJson();
    }
    if (this.woinLocation != null) {
      data['woinLocation'] = this.woinLocation.toJson();
    }
    data['isDefault'] = this.isDefault;
    data['image'] = this.image;
    data['biography'] = this.biography;
    data['companyAddress'] = this.direccionEmpresa;
    return data;
  }
}

class SocialProfiles {
  int woinSocialNetworkId;
  String urlProfile;
  int type;

  SocialProfiles({this.woinSocialNetworkId, this.urlProfile, this.type});

  SocialProfiles.fromJson(Map<String, dynamic> json) {
    woinSocialNetworkId = json['woinSocialNetworkId'];
    urlProfile = json['urlProfile'];
    type = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woinSocialNetworkId'] = this.woinSocialNetworkId;
    data['urlProfile'] = this.urlProfile;
    return data;
  }
}

class WoinLocationCompany {
  int id;
  int latitude;
  int longitude;
  int altitude;
  int createdAt;
  int updatedAt;

  WoinLocationCompany(
      {this.id,
      this.latitude,
      this.longitude,
      this.altitude,
      this.createdAt,
      this.updatedAt});

  WoinLocationCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;

    return data;
  }
}

class Device2 {
  int id;
  String name;
  int state;
  String mac;
  String ip;
  int userId;
  int createdAt;
  int updatedAt;

  Device2(
      {this.id,
      this.name,
      this.state,
      this.mac,
      this.ip,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Device2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    mac = json['mac'];
    ip = json['ip'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['mac'] = this.mac;
    data['ip'] = this.ip;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class respEmWoiner {
  String message;
  bool status;
  List<Emwoinvalid> entities;
  int code;

  respEmWoiner({this.message, this.status, this.entities, this.code});

  respEmWoiner.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Emwoinvalid>();
      json['entities'].forEach((v) {
        entities.add(new Emwoinvalid.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.entities != null) {
      data['entities'] = this.entities.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Emwoinvalid {
  int id;
  String codewoiner;
  int state;
  String biography;
  int personId;
  int userId;
  int profileId;
  int roleId;
  int reference;
  int createdAt;
  int updatedAt;
  String type;
  String token;
  String image;
  List<WoinAccountWoinerBacks> woinAccountWoinerBacks;
  Person person;

  Emwoinvalid(
      {this.id,
      this.codewoiner,
      this.state,
      this.biography,
      this.personId,
      this.userId,
      this.profileId,
      this.roleId,
      this.reference,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.token,
      this.image,
      this.woinAccountWoinerBacks,
      this.person});

  Emwoinvalid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codewoiner = json['codewoiner'];
    state = json['state'];
    biography = json['biography'];
    personId = json['personId'];
    userId = json['userId'];
    profileId = json['profileId'];
    roleId = json['roleId'];
    reference = json['reference'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'];
    token = json['token'];
    image = json['image'];
    if (json['woinAccountWoinerBacks'] != null) {
      woinAccountWoinerBacks = new List<WoinAccountWoinerBacks>();
      json['woinAccountWoinerBacks'].forEach((v) {
        woinAccountWoinerBacks.add(new WoinAccountWoinerBacks.fromJson(v));
      });
    }
    person =
        json['person'] != null ? new Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codewoiner'] = this.codewoiner;
    data['state'] = this.state;
    data['biography'] = this.biography;
    data['personId'] = this.personId;
    data['userId'] = this.userId;
    data['profileId'] = this.profileId;
    data['roleId'] = this.roleId;
    data['reference'] = this.reference;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['type'] = this.type;
    data['token'] = this.token;
    data['image'] = this.image;
    if (this.woinAccountWoinerBacks != null) {
      data['woinAccountWoinerBacks'] =
          this.woinAccountWoinerBacks.map((v) => v.toJson()).toList();
    }
    if (this.person != null) {
      data['person'] = this.person.toJson();
    }
    return data;
  }
}

class person2 {
  String primerApellido;
  String segundoApellido;
  String primerNombre;
  String segundoNombre;
  String birthdate;
  int gender;
  Document document;
  int cityId;
  String direccion;

  person2(
      {this.primerApellido,
      this.segundoApellido,
      this.primerNombre,
      this.segundoNombre,
      this.birthdate,
      this.gender,
      this.document,
      this.cityId,
      this.direccion});

  person2.fromJson(Map<String, dynamic> json) {
    primerApellido = json['firstLastname'];
    segundoApellido = json['secondLastname'];
    primerNombre = json['firstname'];
    segundoNombre = json['secondname'];

    birthdate = json['birthdate'];
    gender = json['gender'];
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
    cityId = json['cityId'];
    direccion = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstLastname'] = this.primerApellido;
    data['secondLastname'] = this.segundoApellido;
    data['firstname'] = this.primerNombre;
    data['secondname'] = this.segundoNombre;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    if (this.document != null) {
      data['document'] = this.document.toJson();
    }
    data['cityId'] = this.cityId;
    data['address'] = this.direccion;
    return data;
  }
}

class Document {
  int type;
  String number;
  int cityId;

  Document({this.type, this.number, this.cityId});

  Document.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['number'] = this.number;
    data['cityId'] = this.cityId;
    return data;
  }
}
