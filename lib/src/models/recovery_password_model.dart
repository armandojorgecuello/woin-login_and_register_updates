// To parse this JSON data, do
//
//     final recoveryPasswordData = recoveryPasswordDataFromJson(jsonString);

import 'dart:convert';

RecoveryPasswordData recoveryPasswordDataFromJson(String str) => RecoveryPasswordData.fromJson(json.decode(str));

String recoveryPasswordDataToJson(RecoveryPasswordData data) => json.encode(data.toJson());

class RecoveryPasswordData {
    RecoveryPasswordData({
        this.username,
        this.typerecovery,
        //this.code,
    });

    String username;
    int typerecovery;
    //int code;

    factory RecoveryPasswordData.fromJson(Map<String, dynamic> json) => RecoveryPasswordData(
        username: json["username"],
        typerecovery: json["typerecovery"],
        //code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "typerecovery": typerecovery,
        //"code": code,
    };
}


SendRecoveryPasswordData sendRecoveryPasswordDataFromJson(String str) => SendRecoveryPasswordData.fromJson(json.decode(str));

String sendRecoveryPasswordDataToJson(SendRecoveryPasswordData data) => json.encode(data.toJson());

class SendRecoveryPasswordData {
    SendRecoveryPasswordData({
        this.username,
        this.typerecovery,
        this.code,
    });

    String username;
    int typerecovery;
    int code;

    factory SendRecoveryPasswordData.fromJson(Map<String, dynamic> json) => SendRecoveryPasswordData(
        username: json["username"],
        typerecovery: json["typerecovery"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "typerecovery": typerecovery,
        "code": code,
    };
}
