import 'package:woin/src/entities/users/registerUser.dart';

class RespCountry {
  String message;
  bool status;
  List<Country> countries;
  int code;

  RespCountry({this.message, this.status, this.countries,this.code});

  RespCountry.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
    if (json['entities'] != null) {
      countries = new List<Country>();
      json['entities'].forEach((v) {
        countries.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['code'] = this.code;

    if (this.countries != null) {
      data['entities'] = this.countries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  int id;
  String name;
  int state;
  String indicative;
  String flag;
  List<Governorates> governorates;

  Country({
    this.id,
    this.name,
    this.state,
    this.indicative,
    this.flag,
    this.governorates,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    indicative = json['indicative'];
    flag = json['flag'];
    if (json['governorates'] != null) {
      governorates = new List<Governorates>();
      json['governorates'].forEach((v) {
        governorates.add(new Governorates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['indicative'] = this.indicative;
    data['flag'] = this.flag;
    if (this.governorates != null) {
      data['governorates'] = this.governorates.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Governorates {
  int id;
  String name;
  int state;
  int countryId;
  int createdAt;
  int updatedAt;
  List<Cities> cities;

  Governorates(
      {this.id,
      this.name,
      this.state,
      this.countryId,
      this.createdAt,
      this.updatedAt,
      this.cities});

  Governorates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    countryId = json['countryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['countryId'] = this.countryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int id;
  String name;
  int state;
  int governorateId;
  int createdAt;
  int updatedAt;

  Cities(
      {this.id,
      this.name,
      this.state,
      this.governorateId,
      this.createdAt,
      this.updatedAt});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    governorateId = json['governorateId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['governorateId'] = this.governorateId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
