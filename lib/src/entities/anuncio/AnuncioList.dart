class respAnuncio {
  String message;
  bool status;
  List<AnuncioAd> Anuncioad;
  int code;

  respAnuncio({this.message, this.status, this.Anuncioad, this.code});

  respAnuncio.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      Anuncioad = new List<AnuncioAd>();
      json['entities'].forEach((v) { Anuncioad.add(new AnuncioAd.fromJson(v)); });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.Anuncioad != null) {
      data['entities'] = this.Anuncioad.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class AnuncioAd {
  int id;
  String title;
  String multimedia;
  int woinerId;
  int price;
  int discountPrice;
  int discountPercentage;
  String subCategoryParent;
  String subCategory;
  String category;
  String woinerMultimedia;
  int giftPercentage;
  int age;
  String codeWoiner;
  int gender;
  String country;
  String governorate;
  String city;
  int initialStock;
  int currentStock;
  String description;
  String dateInitialTime;
  int initialTime;
  String dateFinalTime;
  int finalTime;
  String fullname;
  List<WoinAdViews> woinAdViews;
  List<Multimedias> multimedias;
  List<AnuncioAd> adsSimilaries;
  List<WoinFreeAds> woinFreeAds;
  List<WoinPaidAds> woinPaidAds;
  WoinAdIndicator woinAdIndicator;
  List<AdKeyValues> adKeyValues;

  AnuncioAd({this.id,this.title, this.multimedia, this.woinerId, this.price, this.discountPrice, this.discountPercentage, this.subCategoryParent, this.subCategory, this.category, this.woinerMultimedia, this.giftPercentage, this.age, this.gender, this.country, this.governorate, this.city, this.initialStock, this.currentStock, this.description, this.dateInitialTime, this.initialTime, this.dateFinalTime, this.finalTime, this.fullname, this.woinAdViews, this.adsSimilaries, this.woinFreeAds, this.woinPaidAds, this.woinAdIndicator, this.adKeyValues,this.codeWoiner});

  AnuncioAd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    multimedia = json['multimedia'];
    woinerId = json['woinerId'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    discountPercentage = json['discountPercentage'];
    subCategoryParent = json['subCategoryParent'];
    subCategory = json['subCategory'];
    category = json['category'];
    woinerMultimedia = json['woinerMultimedia'];
    giftPercentage = json['giftPercentage'];
    age = json['age'];
    gender = json['gender'];
    country = json['country'];
    governorate = json['governorate'];
    city = json['city'];
    initialStock = json['initialStock'];
    currentStock = json['currentStock'];
    description = json['description'];
    dateInitialTime = json['dateInitialTime'];
    initialTime = json['initialTime'];
    dateFinalTime = json['dateFinalTime'];
    finalTime = json['finalTime'];
    fullname = json['fullname'];
    codeWoiner=json['codeWoiner'];
    title=json['title'];
    if (json['woinAdViews'] != null) {
      woinAdViews = new List<WoinAdViews>();
      json['woinAdViews'].forEach((v) { woinAdViews.add(new WoinAdViews.fromJson(v)); });
    }
    if (json['multimedias'] != null) {
      multimedias= new List<Multimedias>();
      json['multimedias'].forEach((v) { multimedias.add(new Multimedias.fromJson(v)); });
    }
    if (json['adsSimilaries'] != null) {
      adsSimilaries = new List<AnuncioAd>();
      json['adsSimilaries'].forEach((v) { adsSimilaries.add(new AnuncioAd.fromJson(v)); });
    }else{
      adsSimilaries=null;
    }
    if (json['woinFreeAds'] != null) {
      woinFreeAds = new List<WoinFreeAds>();
      json['woinFreeAds'].forEach((v) { woinFreeAds.add(new WoinFreeAds.fromJson(v)); });
    }else{
      woinFreeAds=null;
    }
    if (json['woinPaidAds'] != null) {
      woinPaidAds = new List<WoinPaidAds>();
      json['woinPaidAds'].forEach((v) { woinPaidAds.add(new WoinPaidAds.fromJson(v)); });
    }else{
      woinPaidAds=null;
    }
    woinAdIndicator = json['woinAdIndicator'] != null ? new WoinAdIndicator.fromJson(json['woinAdIndicator']) : null;
    if (json['adKeyValues'] != null) {
      adKeyValues = new List<AdKeyValues>();
      json['adKeyValues'].forEach((v) { adKeyValues.add(new AdKeyValues.fromJson(v)); });
    }else{
      adKeyValues=null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title']=this.title;
    data['multimedia'] = this.multimedia;
    data['woinerId'] = this.woinerId;
    data['price'] = this.price;
    data['discountPrice'] = this.discountPrice;
    data['discountPercentage'] = this.discountPercentage;
    data['subCategoryParent'] = this.subCategoryParent;
    data['subCategory'] = this.subCategory;
    data['category'] = this.category;
    data['woinerMultimedia'] = this.woinerMultimedia;
    data['giftPercentage'] = this.giftPercentage;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['country'] = this.country;
    data['governorate'] = this.governorate;
    data['city'] = this.city;
    data['initialStock'] = this.initialStock;
    data['currentStock'] = this.currentStock;
    data['description'] = this.description;
    data['dateInitialTime'] = this.dateInitialTime;
    data['initialTime'] = this.initialTime;
    data['dateFinalTime'] = this.dateFinalTime;
    data['finalTime'] = this.finalTime;
    data['fullname'] = this.fullname;
    data['codeWoiner']=this.codeWoiner;
    if (this.woinAdViews != null) {
      data['woinAdViews'] = this.woinAdViews.map((v) => v.toJson()).toList();
    }
    if (this.multimedias != null) {
      data['multimedias'] = this.multimedias.map((v) => v.toJson()).toList();
    }
    if (this.adsSimilaries != null) {
      data['adsSimilaries'] = this.adsSimilaries.map((v) => v.toJson()).toList();
    }
    if (this.woinFreeAds != null) {
      data['woinFreeAds'] = this.woinFreeAds.map((v) => v.toJson()).toList();
    }
    if (this.woinPaidAds != null) {
      data['woinPaidAds'] = this.woinPaidAds.map((v) => v.toJson()).toList();
    }
    if (this.woinAdIndicator != null) {
      data['woinAdIndicator'] = this.woinAdIndicator.toJson();
    }
    if (this.adKeyValues != null) {
      data['adKeyValues'] = this.adKeyValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WoinAdViews {
  int id;
  int woinerId;
  int adId;
  int preferred;
  int like;
  int shared;
  int createdAt;
  int updatedAt;

  WoinAdViews({this.id, this.woinerId, this.adId, this.preferred, this.like, this.shared, this.createdAt, this.updatedAt});

  WoinAdViews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    woinerId = json['woinerId'];
    adId = json['adId'];
    preferred = json['preferred'];
    like = json['like'];
    shared = json['shared'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['woinerId'] = this.woinerId;
    data['adId'] = this.adId;
    data['preferred'] = this.preferred;
    data['like'] = this.like;
    data['shared'] = this.shared;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}


class WoinFreeAds {
  int id;
  int start;
  int end;
  int adId;
  int packetId;
  int createdAt;
  int updatedAt;

  WoinFreeAds({this.id, this.start, this.end, this.adId, this.packetId, this.createdAt, this.updatedAt});

  WoinFreeAds.fromJson(Map<String, dynamic> json) {
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

class WoinPaidAds {
  int id;
  int start;
  int end;
  int adId;
  int packetId;
  int transactionId;
  int createdAt;
  int updatedAt;

  WoinPaidAds({this.id, this.start, this.end, this.adId, this.packetId, this.transactionId, this.createdAt, this.updatedAt});

  WoinPaidAds.fromJson(Map<String, dynamic> json) {
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

class WoinAdIndicator {
  int id;
  int adId;
  double rating;
  int expectedViews;
  int currentViews;
  int viewsPercentage;
  int purchases;
  int purchasesPercentage;
  int totalDuration;
  int  remainingDuration;
  int shared;
  int likes;
  int percentageLikesViews;
  int indexView;
  int indexPreferred;
  int indexPurchased;
  int createdAt;
  int updatedAt;

  WoinAdIndicator({this.id, this.adId, this.rating, this.expectedViews, this.currentViews, this.viewsPercentage, this.remainingDuration,this.purchases, this.purchasesPercentage, this.totalDuration,  this.shared, this.likes, this.percentageLikesViews, this.indexView, this.indexPreferred, this.indexPurchased, this.createdAt, this.updatedAt});

  WoinAdIndicator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adId = json['adId'];
    rating = json['rating'];
    expectedViews = json['expectedViews'];
    currentViews = json['currentViews'];
    viewsPercentage = json['viewsPercentage'];
    purchases = json['purchases'];
    purchasesPercentage = json['purchasesPercentage'];
    totalDuration = json['totalDuration'];
   remainingDuration = json['remainingDuration'];
    shared = json['shared'];
    likes = json['likes'];
    percentageLikesViews = json['percentageLikesViews'];
    indexView = json['indexView'];
    indexPreferred = json['indexPreferred'];
    indexPurchased = json['indexPurchased'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adId'] = this.adId;
    data['rating'] = this.rating;
    data['expectedViews'] = this.expectedViews;
    data['currentViews'] = this.currentViews;
    data['viewsPercentage'] = this.viewsPercentage;
    data['purchases'] = this.purchases;
    data['purchasesPercentage'] = this.purchasesPercentage;
    data['totalDuration'] = this.totalDuration;
    //data['remainingDuration'] = this.remainingDuration;
    data['shared'] = this.shared;
    data['likes'] = this.likes;
    data['percentageLikesViews'] = this.percentageLikesViews;
    data['indexView'] = this.indexView;
    data['indexPreferred'] = this.indexPreferred;
    data['indexPurchased'] = this.indexPurchased;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class AdKeyValues {
  String key;
  String value;
  int total;
  int id;
  int parentId;

  AdKeyValues({this.key, this.value, this.total, this.id, this.parentId});

  AdKeyValues.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    total = json['total'];
    id = json['id'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['total'] = this.total;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    return data;
  }
}

class Multimedias {
  int id;
  String source;
  String description;
  int type;
  int state;
  int createdAt;
  int updatedAt;
  String imageBase64;
  String imageFile;

  Multimedias(
      {this.id,
        this.source,
        this.description,
        this.type,
        this.state,
        this.createdAt,
        this.updatedAt,
        this.imageBase64,
        this.imageFile});

  Multimedias.fromJson(Map<String, dynamic> json) {
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