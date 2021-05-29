import 'package:woin/src/models/user_login.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';

class UserRegisterSin {
  String username;
  String email;
  String password;
  String number;
  int questionId;
  String answer;
  int avatarId;
  bool serviceBool;
  int typeVehicleId;
  WoinLocation woinLocation;
  Device device;

  UserRegisterSin(
      {this.username,
      this.email,
      this.password,
      this.number,
      this.questionId,
      this.answer,
      this.avatarId,
      this.serviceBool,
      this.typeVehicleId,
      this.woinLocation,
      this.device});

  UserRegisterSin.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    questionId = json['questionId'];
    answer = json['answer'];
    avatarId = json['avatarId'];
    serviceBool = json['serviceBool'];
    typeVehicleId = json['typeVehicleId'];
    woinLocation = json['woinLocation'] != null
        ? new WoinLocation.fromJson(json['woinLocation'])
        : null;
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['number'] = this.number;
    data['questionId'] = this.questionId;
    data['answer'] = this.answer;
    data['avatarId'] = this.avatarId;
    data['serviceBool'] = this.serviceBool;
    data['typeVehicleId'] = this.typeVehicleId;
    if (this.woinLocation != null) {
      data['woinLocation'] = this.woinLocation.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device.toJson();
    }
    return data;
  }
}

class UserRegister {
  String username;
  String email;
  String password;
  String number;
  bool serviceBool;
  int typeVehicleId;
  WoinLocation woinLocation;
  Device device;
  String codeWoiner;
  String secretWord;

  UserRegister(
      {this.username,
      this.email,
      this.password,
      this.number,
        this.secretWord,
      this.serviceBool,
      this.typeVehicleId,
      this.woinLocation,
      this.codeWoiner,
      this.device});

  UserRegister.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    codeWoiner = json['codeWoiner'];
    number = json['number'];
    serviceBool = json['serviceBool'];
    typeVehicleId = json['typeVehicleId'];
    secretWord=json["secretWord"];
    woinLocation = json['woinLocation'] != null
        ? new WoinLocation.fromJson(json['woinLocation'])
        : null;
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['codeWoiner'] = this.codeWoiner;
    data['number'] = this.number;
    data['secretWord'] = this.secretWord;
    data['serviceBool'] = this.serviceBool;
    data['typeVehicleId'] = this.typeVehicleId;
    if (this.woinLocation != null) {
      data['woinLocation'] = this.woinLocation.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device.toJson();
    }
    return data;
  }
}
