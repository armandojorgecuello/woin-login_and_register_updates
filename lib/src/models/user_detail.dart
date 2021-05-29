// To parse this JSON data, do
//
//     final userDetailResponse = userDetailResponseFromJson(jsonString);

import 'dart:convert';

UserDetailResponse userDetailResponseFromJson(String str) => UserDetailResponse.fromJson(json.decode(str));

String userDetailResponseToJson(UserDetailResponse data) => json.encode(data.toJson());

class UserDetailResponse {
    UserDetailResponse({
        this.id,
        this.username,
        this.email,
        this.token,
        this.refreshToken,
        this.state,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.code,
        this.number,
        this.woinerType,
        this.lastConnection,
        this.person,
        this.residences,
        this.typeDefault,
        this.typeDefaultName,
        this.image,
    });

    int id;
    String username;
    String email;
    String token;
    String refreshToken;
    int state;
    int roleId;
    int createdAt;
    int updatedAt;
    String type;
    int code;
    String number;
    List<dynamic> woinerType;
    String lastConnection;
    String person;
    List<dynamic> residences;
    int typeDefault;
    String typeDefaultName;
    String image;

    factory UserDetailResponse.fromJson(Map<String, dynamic> json) => UserDetailResponse(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        state: json["state"],
        roleId: json["roleId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        type: json["type"],
        code: json["code"],
        number: json["number"],
        woinerType: List<dynamic>.from(json["woinerType"].map((x) => x)),
        lastConnection: json["lastConnection"],
        person: json["person"],
        residences: json["residences"] != null ?  List<dynamic>.from(json["residences"].map((x) => x)) : null,
        typeDefault: json["typeDefault"],
        typeDefaultName: json["typeDefaultName"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "token": token,
        "refreshToken": refreshToken,
        "state": state,
        "roleId": roleId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "type": type,
        "code": code,
        "number": number,
        "woinerType": List<dynamic>.from(woinerType.map((x) => x)),
        "lastConnection": lastConnection,
        "person": person,
        "residences": List<dynamic>.from(residences.map((x) => x)),
        "typeDefault": typeDefault,
        "typeDefaultName": typeDefaultName,
        "image": image,
    };
}
