
class WalletRespJson {
  String message;
  bool status;
  List<Wallet> entities;
  int code;

  WalletRespJson({this.message, this.status, this.entities, this.code});

  WalletRespJson.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Wallet>();
      json['entities'].forEach((v) {
        entities.add(new Wallet.fromJson(v));
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

class Wallet {
  int id;
  String number;
  int state;
  double balance;
  int type;
  String typeWalle;
  int woinerId;
  Null walletParent;
  int countryId;
  int createdAt;
  int updatedAt;

  Wallet(
      {this.id,
        this.number,
        this.state,
        this.balance,
        this.type,
        this.typeWalle,
        this.woinerId,
        this.walletParent,
        this.countryId,
        this.createdAt,
        this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    state = json['state'];
    balance = json['balance'];
    type = json['type'];
    typeWalle = json['typeWalle'];
    woinerId = json['woinerId'];
    walletParent = json['walletParent'];
    countryId = json['countryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['state'] = this.state;
    data['balance'] = this.balance;
    data['type'] = this.type;
    data['typeWalle'] = this.typeWalle;
    data['woinerId'] = this.woinerId;
    data['walletParent'] = this.walletParent;
    data['countryId'] = this.countryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}