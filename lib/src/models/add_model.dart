// To parse this JSON data, do
//
//     final addModel = addModelFromJson(jsonString);

import 'dart:convert';

AddModel addModelFromJson(String str) => AddModel.fromJson(json.decode(str));

String addModelToJson(AddModel data) => json.encode(data.toJson());

class AddModel {
    AddModel({
        this.id,
        this.title,
        this.multimedia,
        this.woinerId,
        this.codeWoiner,
        this.price,
        this.discountPrice,
        this.discountPercentage,
        this.subCategoryParent,
        this.subCategory,
        this.category,
        this.woinerMultimedia,
        this.giftPercentage,
        this.age,
        this.gender,
        this.country,
        this.governorate,
        this.city,
        this.initialStock,
        this.currentStock,
        this.description,
        this.fullname,
        this.initialTime,
        this.finalTime,
        this.woinAdViews,
        this.adsSimilaries,
        this.woinFreeAds,
        this.woinPaidAds,
        this.woinAdIndicator,
        this.adKeyValues,
    });

    int id;
    String title;
    String multimedia;
    int woinerId;
    String codeWoiner;
    double price;
    int discountPrice;
    int discountPercentage;
    dynamic subCategoryParent;
    String subCategory;
    String category;
    String woinerMultimedia;
    int giftPercentage;
    int age;
    int gender;
    String country;
    String governorate;
    String city;
    int initialStock;
    int currentStock;
    String description;
    String fullname;
    String initialTime;
    String finalTime;
    List<dynamic> woinAdViews;
    List<dynamic> adsSimilaries;
    List<dynamic> woinFreeAds;
    List<dynamic> woinPaidAds;
    dynamic woinAdIndicator;
    List<dynamic> adKeyValues;

    factory AddModel.fromJson(Map<String, dynamic> json) => AddModel(
        id: json["id"],
        title: json["title"],
        multimedia: json["multimedia"],
        woinerId: json["woinerId"],
        codeWoiner: json["codeWoiner"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        discountPercentage: json["discountPercentage"],
        subCategoryParent: json["subCategoryParent"],
        subCategory: json["subCategory"],
        category: json["category"],
        woinerMultimedia: json["woinerMultimedia"],
        giftPercentage: json["giftPercentage"],
        age: json["age"],
        gender: json["gender"],
        country: json["country"],
        governorate: json["governorate"],
        city: json["city"],
        initialStock: json["initialStock"],
        currentStock: json["currentStock"],
        description: json["description"],
        fullname: json["fullname"],
        initialTime: json["initialTime"],
        finalTime: json["finalTime"],
        woinAdViews: json["woinAdViews"] != null ? List<dynamic>.from(json["woinAdViews"].map((x) => x)) : null,
        adsSimilaries: json["adsSimilaries"] != null ? List<dynamic>.from(json["adsSimilaries"].map((x) => x)) : null,
        woinFreeAds: json["woinFreeAds"] != null ? List<dynamic>.from(json["woinFreeAds"].map((x) => x)) : null,
        woinPaidAds: json["woinPaidAds"] != null ? List<dynamic>.from(json["woinPaidAds"].map((x) => x)) : null,
        woinAdIndicator: json["woinAdIndicator"],
        adKeyValues: json["adKeyValues"] != null ? List<dynamic>.from(json["adKeyValues"].map((x) => x)) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "multimedia": multimedia,
        "woinerId": woinerId,
        "codeWoiner": codeWoiner,
        "price": price,
        "discountPrice": discountPrice,
        "discountPercentage": discountPercentage,
        "subCategoryParent": subCategoryParent,
        "subCategory": subCategory,
        "category": category,
        "woinerMultimedia": woinerMultimedia,
        "giftPercentage": giftPercentage,
        "age": age,
        "gender": gender,
        "country": country,
        "governorate": governorate,
        "city": city,
        "initialStock": initialStock,
        "currentStock": currentStock,
        "description": description,
        "fullname": fullname,
        "initialTime": initialTime,
        "finalTime": finalTime,
        "woinAdViews": List<dynamic>.from(woinAdViews.map((x) => x)),
        "adsSimilaries": List<dynamic>.from(adsSimilaries.map((x) => x)),
        "woinFreeAds": List<dynamic>.from(woinFreeAds.map((x) => x)),
        "woinPaidAds": List<dynamic>.from(woinPaidAds.map((x) => x)),
        "woinAdIndicator": woinAdIndicator,
        "adKeyValues": List<dynamic>.from(adKeyValues.map((x) => x)),
    };
}
