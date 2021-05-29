

import 'package:woin/src/entities/anuncio/anuncioAdd.dart';

class anuncioAd {
  Ad ad;
  List<Multimedia> multimedia;
  producto product;
  FreeAd freeAd;
  PaidAd paidAd;

  anuncioAd({this.ad, this.multimedia, this.product, this.freeAd, this.paidAd});

  anuncioAd.fromJson(Map<String, dynamic> json) {
    ad = json['ad'] != null ? new Ad.fromJson(json['ad']) : null;
    if (json['multimedia'] != null) {
      multimedia = new List<Multimedia>();
      json['multimedia'].forEach((v) {
        multimedia.add(new Multimedia.fromJson(v));
      });
    }
    product =  json['product'] != null ? new producto.fromJson(json['product']) : null;
    freeAd = json['freeAd'] != null ? new FreeAd.fromJson(json['freeAd']) : null;
    paidAd =  json['paidAd'] != null ? new PaidAd.fromJson(json['paidAd']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ad != null) {
      data['ad'] = this.ad.toJson();
    }
    if (this.multimedia != null) {
      data['multimedia'] = this.multimedia.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.freeAd != null) {
      data['freeAd'] = this.freeAd.toJson();
    }
    if (this.paidAd != null) {
      data['paidAd'] = this.paidAd.toJson();
    }
    return data;
  }
}

class Ad {
  int id;
  String title;
  String description;
  String initialTime;
  String finalTime;
  double price;
  int giftPercentage;
  int discountPercentage;
  int initialStock;
  int currentStock;
  int state;
  int type;
  int adParent;
  int woinerId;
  int subcategoryId;
  int productId;
  int createdAt;
  int updatedAt;
  int ageInitial;
  int ageFinal;
  int gender;
  List<int> multimediaIds;
  List<keyValues> keyvalues;

  Ad(
      {this.id,
        this.title,
        this.description,
        this.initialTime,
        this.finalTime,
        this.price,
        this.giftPercentage,
        this.discountPercentage,
        this.initialStock,
        this.currentStock,
        this.state,
        this.type,
        this.adParent,
        this.woinerId,
        this.subcategoryId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.ageInitial,
        this.ageFinal,
        this.gender,
        this.multimediaIds,
        this.keyvalues});

  Ad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    initialTime = json['initialTime'];
    finalTime = json['finalTime'];
    price = json['price'];
    giftPercentage = json['giftPercentage'];
    discountPercentage = json['discountPercentage'];
    initialStock = json['initialStock'];
    currentStock = json['currentStock'];
    state = json['state'];
    type = json['type'];
    adParent = json['adParent'];
    woinerId = json['woinerId'];
    subcategoryId = json['subcategoryId'];
    productId = json['productId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ageInitial = json['ageInitial'];
    ageFinal = json['ageFinal'];
    gender = json['gender'];
    multimediaIds = json['multimediaIds'].cast<int>();
    if (json['adKeyValues'] != null) {
      keyvalues = new List<keyValues>();
      json['adKeyValues'].forEach((v) {
        keyvalues.add(new keyValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['initialTime'] = this.initialTime;
    data['finalTime'] = this.finalTime;
    data['price'] = this.price;
    data['giftPercentage'] = this.giftPercentage;
    data['discountPercentage'] = this.discountPercentage;
    data['initialStock'] = this.initialStock;
    data['currentStock'] = this.currentStock;
    data['state'] = this.state;
    data['type'] = this.type;
    data['adParent'] = this.adParent;
    data['woinerId'] = this.woinerId;
    data['subcategoryId'] = this.subcategoryId;
    data['productId'] = this.productId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['ageInitial'] = this.ageInitial;
    data['ageFinal'] = this.ageFinal;
    data['gender'] = this.gender;
    data['multimediaIds'] = this.multimediaIds;
    if (this.keyvalues != null) {
      data['AdKeyValues'] = this.keyvalues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Multimedia {
  int id;
  String source;
  String description;
  int type;
  int state;
  int createdAt;
  int updatedAt;
  String imageBase64;
  String imageFile;

  Multimedia(
      {this.id,
        this.source,
        this.description,
        this.type,
        this.state,
        this.createdAt,
        this.updatedAt,
        this.imageBase64,
        this.imageFile});

  Multimedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'];
    description = json['description'];
    type = json['type'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imageBase64 = json['imageBase64'];
    imageFile = json['imageFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source'] = this.source;
    data['description'] = this.description;
    data['type'] = this.type;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['imageBase64'] = this.imageBase64;
    data['imageFile'] = this.imageFile;
    return data;
  }
}



class FreeAd {
  int id;
  int start;
  int end;
  int adId;
  int packetId;
  int createdAt;
  int updatedAt;

  FreeAd(
      {this.id,
        this.start,
        this.end,
        this.adId,
        this.packetId,
        this.createdAt,
        this.updatedAt});

  FreeAd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    adId = json['adId'];
    packetId = json['packetId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    data['adId'] = this.adId;
    data['packetId'] = this.packetId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class PaidAd {
  int id;
  int start;
  int end;
  int adId;
  int packetId;
  int transactionId;
  int createdAt;
  int updatedAt;

  PaidAd(
      {this.id,
        this.start,
        this.end,
        this.adId,
        this.packetId,
        this.transactionId,
        this.createdAt,
        this.updatedAt});

  PaidAd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    adId = json['adId'];
    packetId = json['packetId'];
    transactionId = json['transactionId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    data['adId'] = this.adId;
    data['packetId'] = this.packetId;
    data['transactionId'] = this.transactionId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class RespanuncioAd {
  String message;
  bool status;
  List<Entities> entities;
  int code;

  RespanuncioAd({this.message, this.status, this.entities, this.code});

  RespanuncioAd.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Entities>();
      json['entities'].forEach((v) {
        entities.add(new Entities.fromJson(v));
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

class Entities {
  int id;
  String title;
  String description;
  String initialTime;
  String finalTime;
  double price;
  int giftPercentage;
  int discountPercentage;
  int initialStock;
  int currentStock;
  int state;
  int type;
  int adParent;
  int woinerId;
  int subcategoryId;
  int productId;
  int createdAt;
  int updatedAt;
  int age;
  int gender;
  List<int> multimediaIds;
  List<AdKeyValues> adKeyValues;

  Entities(
      {this.id,
        this.title,
        this.description,
        this.initialTime,
        this.finalTime,
        this.price,
        this.giftPercentage,
        this.discountPercentage,
        this.initialStock,
        this.currentStock,
        this.state,
        this.type,
        this.adParent,
        this.woinerId,
        this.subcategoryId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.age,
        this.gender,
        this.multimediaIds,
        this.adKeyValues});

  Entities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    initialTime = json['initialTime'];
    finalTime = json['finalTime'];
    price = json['price'];
    giftPercentage = json['giftPercentage'];
    discountPercentage = json['discountPercentage'];
    initialStock = json['initialStock'];
    currentStock = json['currentStock'];
    state = json['state'];
    type = json['type'];
    adParent = json['adParent'];
    woinerId = json['woinerId'];
    subcategoryId = json['subcategoryId'];
    productId = json['productId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    age = json['age'];
    gender = json['gender'];
    multimediaIds = json['multimediaIds']!=null?json['multimediaIds'].cast<int>():List();
    if (json['adKeyValues'] != null) {
      adKeyValues = new List<AdKeyValues>();
      json['adKeyValues'].forEach((v) {
        adKeyValues.add(new AdKeyValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['initialTime'] = this.initialTime;
    data['finalTime'] = this.finalTime;
    data['price'] = this.price;
    data['giftPercentage'] = this.giftPercentage;
    data['discountPercentage'] = this.discountPercentage;
    data['initialStock'] = this.initialStock;
    data['currentStock'] = this.currentStock;
    data['state'] = this.state;
    data['type'] = this.type;
    data['adParent'] = this.adParent;
    data['woinerId'] = this.woinerId;
    data['subcategoryId'] = this.subcategoryId;
    data['productId'] = this.productId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['multimediaIds'] = this.multimediaIds;
    if (this.adKeyValues != null) {
      data['adKeyValues'] = this.adKeyValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdKeyValues {
  String key;
  String value;
  int total;

  AdKeyValues({this.key, this.value, this.total});

  AdKeyValues.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['total'] = this.total;
    return data;
  }
}