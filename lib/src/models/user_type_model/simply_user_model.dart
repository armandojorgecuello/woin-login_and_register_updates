
import 'dart:convert';

import '../device_model.dart';
import '../woin_location_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.woinerType,
        this.username,
        this.publicName,
        this.email,
        this.password,
        this.referenceCodeWoiner,
        this.phoneNumber,
        this.keyWord,
        this.serviceBool,
        this.typeVehicleId,
        this.device,
        this.woinLocation,
        this.category,
    });

    int woinerType;
    String username;
    String publicName;
    String email;
    String password;
    String referenceCodeWoiner;
    String phoneNumber;
    String keyWord;
    bool serviceBool;
    int typeVehicleId;
    WoinLocation woinLocation;
    Device device;
    String category;

    factory User.fromJson(Map<String, dynamic> json) => User(
        woinerType: json["woinerType"],
        username: json["username"],
        publicName: json["publicName"],
        email: json["email"],
        password: json["password"],
        referenceCodeWoiner: json["referenceCodeWoiner"],
        phoneNumber: json["phoneNumber"],
        keyWord: json["keyWord"],
        serviceBool: json["serviceBool"],
        typeVehicleId: json["typeVehicleId"],
        device: json["device"],
        woinLocation: json["woinLocation"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "woinerType": woinerType,
        "username": username,
        "publicName": publicName,
        "email": email,
        "password": password,
        "referenceCodeWoiner": referenceCodeWoiner,
        "phoneNumber": phoneNumber,
        "keyWord": keyWord,
        "serviceBool": serviceBool,
        "typeVehicleId": typeVehicleId,
        "device": device,
        "woinLocation": woinLocation,
        "category": category,
    };
}
