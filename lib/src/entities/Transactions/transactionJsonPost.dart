class transactionJson {
  int woinerIdReceirve;
  Transaction transaction;
  int walletType;

  transactionJson({this.woinerIdReceirve, this.transaction, this.walletType});

  transactionJson.fromJson(Map<String, dynamic> json) {
    woinerIdReceirve = json['woinerIdReceirve'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    walletType = json['walletType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.woinerIdReceirve!=null){
      data['woinerIdReceirve'] = this.woinerIdReceirve;
    }

    if (this.transaction != null) {
      data['transaction'] = this.transaction.toJson();
    }
    data['walletType'] = this.walletType;
    return data;
  }
}

class Transaction {
  String email;
  WoinEmailGift woinEmailGift;
  int id;
  int amount;
  int state;
  int transactionType;
  String detail;
  int walletSender;
  int walletReceiver;
  int subType;
  int createdAt;
  int updatedAt;
  int userId;
  int woinType;
  String token;
  bool isTransactionGift;

  Transaction(
      {this.email,
        this.woinEmailGift,
        this.id,
        this.amount,
        this.state,
        this.transactionType,
        this.detail,
        this.walletSender,
        this.walletReceiver,
        this.subType,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.woinType,
        this.token,
        this.isTransactionGift});

  Transaction.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    woinEmailGift = json['woinEmailGift'] != null
        ? new WoinEmailGift.fromJson(json['woinEmailGift'])
        : null;
    id = json['id'];
    amount = json['amount'];
    state = json['state'];
    transactionType = json['transactionType'];
    detail = json['detail'];
    walletSender = json['walletSender'];
    walletReceiver = json['walletReceiver'];
    subType = json['subType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    woinType = json['woinType'];
    token = json['token'];
    isTransactionGift = json['isTransactionGift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   if(this.email!=null ){
     data['email'] = this.email;
   }
    if (this.woinEmailGift != null) {
      data['woinEmailGift'] = this.woinEmailGift.toJson();
    }

    if(this.id!=null ){
      data['id'] = this.id;
    }

    data['amount'] = this.amount;
    data['state'] = this.state;
    data['transactionType'] = this.transactionType;
    data['detail'] = this.detail;

    if(this.walletReceiver!=null ){
      data['walletReceiver'] = this.walletReceiver;
    }

    if(this.walletSender!=null ){
      data['walletSender'] = this.walletSender;
    }

    if(this.subType!=null ){
      data['subType'] = this.subType;
    }

    if(this.createdAt!=null ){
      data['createdAt'] = this.createdAt;
    }

    if(this.updatedAt!=null ){
      data['updatedAt'] = this.updatedAt;
    }

    if(this.userId!=null ){
      data['userId'] = this.userId;
    }

    data['woinType'] = this.woinType;
    data['token'] = this.token;

    if(this.isTransactionGift!=null ){
      data['isTransactionGift'] = this.isTransactionGift;
    }

    return data;
  }
}

class WoinEmailGift {
  int id;
  String email;
  int amount;
  int state;
  int woinerId;
  int transactionId;
  int createdAt;
  int updatedAt;

  WoinEmailGift(
      {this.id,
        this.email,
        this.amount,
        this.state,
        this.woinerId,
        this.transactionId,
        this.createdAt,
        this.updatedAt});

  WoinEmailGift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    amount = json['amount'];
    state = json['state'];
    woinerId = json['woinerId'];
    transactionId = json['transactionId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['amount'] = this.amount;
    data['state'] = this.state;
    data['woinerId'] = this.woinerId;
    data['transactionId'] = this.transactionId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}