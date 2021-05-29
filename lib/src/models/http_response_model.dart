// To parse this JSON data, do
//
//     final httpResponse = httpResponseFromJson(jsonString);

import 'dart:convert';

HTTPResponse httpResponseFromJson(String str) => HTTPResponse.fromJson(json.decode(str));

String httpResponseToJson(HTTPResponse data) => json.encode(data.toJson());

class HTTPResponse {
    HTTPResponse({
        this.message,
        this.status,
        this.entities,
        this.code,
    });

    String message;
    bool status;
    List<String> entities;
    int code;

    factory HTTPResponse.fromJson(Map<String, dynamic> json) => HTTPResponse(
        message: json["message"],
        status: json["status"],
        entities: List<String>.from(json["entities"].map((x) => x)),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "entities": List<dynamic>.from(entities.map((x) => x)),
        "code": code,
    };
}
