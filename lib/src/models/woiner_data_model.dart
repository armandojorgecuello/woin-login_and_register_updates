
import 'package:woin/src/entities/users/regCliWoiner.dart';

class woinerAccount {
  String message;
  bool status;
  List<Woiner> woinerData;
  int code;

  woinerAccount({this.message, this.status, this.woinerData, this.code});

  woinerAccount.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      woinerData = new List<Woiner>();
      json['entities'].forEach((v) {
        woinerData.add(new Woiner.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.woinerData != null) {
      data['entities'] = this.woinerData.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Woiner {
  int id;
  String codewoiner;
  String publicName;
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
  double balance;
  List<Company> companies;

  Woiner(
      {this.id,
        this.codewoiner,
        this.publicName,
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
        this.person,
        this.balance,
      this.companies});

  Woiner.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    codewoiner = json['codewoiner'];
    publicName = json['publicName'];
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
    balance=json['balance'];
    token = json['token'];
    image = json['image'];
    if (json['woinAccountWoinerBacks'] != null) {
      woinAccountWoinerBacks = new List<WoinAccountWoinerBacks>();
      json['woinAccountWoinerBacks'].forEach((v) {
        woinAccountWoinerBacks.add(new WoinAccountWoinerBacks.fromJson(v));
      });
    }

    if (json['woinCompanies'] != null) {
      companies = new List<Company>();
      json['woinCompanies'].forEach((v) {
        companies.add(new Company.fromJson(v));
      });
    }
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['codewoiner'] = this.codewoiner;
    data['publicName'] = this.publicName;
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
    data['balance'] = this.balance;
    if (this.woinAccountWoinerBacks != null) {
      data['woinAccountWoinerBacks'] =
          this.woinAccountWoinerBacks.map((v) => v.toJson()).toList();
    }
    if (this.companies != null) {
      data['woinCompanies'] =
          this.companies.map((v) => v.toJson()).toList();
    }
    if (this.person != null) {
      data['person'] = this.person.toJson();
    }
    return data;
  }
}


class Company{

  int id;
  String name;
  int locationID;

  Company({this.id,this.name,this.locationID});
  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationID= json['locationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['name']=this.name;
    data['locationId']=this.locationID;
    return data;
  }

}




