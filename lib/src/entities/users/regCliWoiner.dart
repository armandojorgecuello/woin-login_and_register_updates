import 'package:woin/src/entities/users/regEmwoiner.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';
import 'package:woin/src/models/woiner_type.dart';

class cliWoiner {
  int userId;
  person2 person;
  List<Phones> phones;
  String image;
  WoinerType woinerType;
    Device device;
    WoinLocation woinLocation;
    int isDefault;
    String biography;
  
    cliWoiner(
        {this.userId,
        this.person,
        this.phones,
        this.image,
        this.woinerType,
        this.device,
        this.woinLocation,
        this.isDefault,
        this.biography});
  
    cliWoiner.fromJson(Map<String, dynamic> json) {
      userId = json['userId'];
      person =
          json['person'] != null ? new person2.fromJson(json['person']) : null;
      if (json['phones'] != null) {
        phones = new List<Phones>();
        json['phones'].forEach((v) {
          phones.add(new Phones.fromJson(v));
        });
      }
      image = json['image'];
      woinerType = json['woinerType'] != null
          ? new WoinerType.fromJson(json['woinerType'])
          : null;
      device =
          json['device'] != null ? new Device.fromJson(json['device']) : null;
      woinLocation = json['woinLocation'] != null
          ? new WoinLocation.fromJson(json['woinLocation'])
          : null;
      isDefault = json['isDefault'];
      biography = json['biography'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['userId'] = this.userId;
      if (this.person != null) {
        data['person'] = this.person.toJson();
      } else {
        data['person'] = null;
      }
      if (this.phones != null) {
        data['phones'] = this.phones.map((v) => v.toJson()).toList();
      }
      data['image'] = this.image;
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
      data['biography'] = this.biography;
  
      return data;
    }
  }
  

class Person {
  int id;
  String firstname;
  String secondname;
  String firstLastname;
  String secondLastname;
  String fullName;
  String birthdate;
  int gender;
  int userId;
  int createdAt;
  int updatedAt;
  List<WoinDocuments> woinDocuments;

  Person(
      {this.id,
      this.firstname,
      this.secondname,
      this.firstLastname,
      this.secondLastname,
      this.fullName,
      this.birthdate,
      this.gender,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.woinDocuments});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    firstLastname = json['firstLastname'];
    secondLastname = json['secondLastname'];
    fullName = json['fullName'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['woinDocuments'] != null) {
      woinDocuments = new List<WoinDocuments>();
      json['woinDocuments'].forEach((v) {
        woinDocuments.add(new WoinDocuments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['secondname'] = this.secondname;
    data['firstLastname'] = this.firstLastname;
    data['secondLastname'] = this.secondLastname;
    data['fullName'] = this.fullName;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.woinDocuments != null) {
      data['woinDocuments'] =
          this.woinDocuments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WoinDocuments {
  int id;
  String number;
  int state;
  int type;
  int cityId;
  int personId;
  int createdAt;
  int updatedAt;

  WoinDocuments(
      {this.id,
      this.number,
      this.state,
      this.type,
      this.cityId,
      this.personId,
      this.createdAt,
      this.updatedAt});

  WoinDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    state = json['state'];
    type = json['type'];
    cityId = json['cityId'];
    personId = json['personId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['state'] = this.state;
    data['type'] = this.type;
    data['cityId'] = this.cityId;
    data['personId'] = this.personId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Phones {
  int typePhone;
  String number;

  Phones({this.typePhone, this.number});

  Phones.fromJson(Map<String, dynamic> json) {
    typePhone = json['typePhone'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typePhone'] = this.typePhone;
    data['number'] = this.number;
    return data;
  }
}

class respcliWoiner {
  String message;
  bool status;
  List<Clivalid> entities;
  int code;

  respcliWoiner({this.message, this.status, this.entities, this.code});

  respcliWoiner.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Clivalid>();
      json['entities'].forEach((v) {
        entities.add(new Clivalid.fromJson(v));
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

class Clivalid {
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

  Clivalid(
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

  Clivalid.fromJson(Map<String, dynamic> json) {
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

class WoinAccountWoinerBacks {
  int id;
  int type;
  int cityId;
  int backId;
  String numberAccount;
  String accountHolder;
  String document;
  String csv;
  int woinerId;
  int createdAt;
  int updatedAt;

  WoinAccountWoinerBacks(
      {this.id,
      this.type,
      this.cityId,
      this.backId,
      this.numberAccount,
      this.accountHolder,
      this.document,
      this.csv,
      this.woinerId,
      this.createdAt,
      this.updatedAt});

  WoinAccountWoinerBacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    cityId = json['cityId'];
    backId = json['backId'];
    numberAccount = json['numberAccount'];
    accountHolder = json['accountHolder'];
    document = json['document'];
    csv = json['csv'];
    woinerId = json['woinerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['cityId'] = this.cityId;
    data['backId'] = this.backId;
    data['numberAccount'] = this.numberAccount;
    data['accountHolder'] = this.accountHolder;
    data['document'] = this.document;
    data['csv'] = this.csv;
    data['woinerId'] = this.woinerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
