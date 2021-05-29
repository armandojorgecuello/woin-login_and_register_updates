// To parse this JSON data, do
//
//     final accountDetail = accountDetailFromJson(jsonString);

import 'dart:convert';

AccountDetail accountDetailFromJson(String str) => AccountDetail.fromJson(json.decode(str));

String accountDetailToJson(AccountDetail data) => json.encode(data.toJson());

class AccountDetail {
    AccountDetail({
        this.codewoiner,
        this.nombre,
        this.birthday,
        this.typeWoiner,
        this.biography,
        this.whatsapp,
        this.contacto,
        this.email,
        this.ubicacion,
        this.balance,
    });

    String codewoiner;
    String nombre;
    String birthday;
    int typeWoiner;
    String biography;
    String whatsapp;
    String contacto;
    String email;
    String ubicacion;
    double balance;

    factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
        codewoiner: json["codewoiner"],
        nombre: json["nombre"],
        birthday: json["birthday"],
        typeWoiner: json["typeWoiner"],
        biography: json["biography"],
        whatsapp: json["whatsapp"],
        contacto: json["contacto"],
        email: json["email"],
        ubicacion: json["ubicacion"],
        balance: json["balance"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "codewoiner": codewoiner,
        "nombre": nombre,
        "birthday": birthday,
        "typeWoiner": typeWoiner,
        "biography": biography,
        "whatsapp": whatsapp,
        "contacto": contacto,
        "email": email,
        "ubicacion": ubicacion,
        "balance": balance,
    };
}
