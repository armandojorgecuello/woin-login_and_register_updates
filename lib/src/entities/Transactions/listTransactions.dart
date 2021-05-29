class transactionList {
  String message;
  bool status;
  List<MovementsT> entities;
  int code;

  transactionList({this.message, this.status, this.entities, this.code});

  transactionList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<MovementsT>();
      json['entities'].forEach((v) {
        print("ENTITY ADD  -------*/////");
        entities.add(new MovementsT.fromJson(v));
        print("ENTITY ADD");
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

class MovementsT {
  int typeWoinerInTransaction;
  String email;
  WoinEmailGift woinEmailGift;
  int id;
  double amount;
  int state;
  int transactionType;
  String detail;
  int woinerReceiver;
  int walletSender;
  int walletReceiver;
  int subType;
  int createdAt;
  int updatedAt;
  int userId;
  int woinType;
  String token;
  DateTime fechaFormater;
  String emailSender;
  String emailReceiver;
  String avatarReceiver;
  String avatarSender;
  bool isTransactionGift;

  MovementsT(
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
        this.fechaFormater,
        this.isTransactionGift, this.avatarReceiver,this.avatarSender,this.emailReceiver,this.emailSender,this.typeWoinerInTransaction,this.woinerReceiver});

  MovementsT.fromJson(Map<String, dynamic> json) {
    try{
      email = json['email'];
      woinEmailGift = json['woinEmailGift'] != null
          ? new WoinEmailGift.fromJson(json['woinEmailGift'])
          : null;
      id = json['id'];
      amount = json['amount']!=null && json['amount']!=""?double.parse(json['amount'].toString()):0;
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
      emailSender=json['emailSender'];
      emailReceiver=json['emailReceiver'];
      avatarReceiver=json['avatarReceiver'];
      avatarSender=json['avatarSender'];
      typeWoinerInTransaction=json['typeWoinerInTransaction'];
      woinerReceiver=json['woinerReceiver'];
      print("ENTRO ACA MOVEMENTS T");

    }on Exception catch(e){
       print("EXCEPTION*****");
       print(e);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    if (this.woinEmailGift != null) {
      data['woinEmailGift'] = this.woinEmailGift.toJson();
    }
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['state'] = this.state;
    data['transactionType'] = this.transactionType;
    data['detail'] = this.detail;
    data['walletSender'] = this.walletSender;
    data['walletReceiver'] = this.walletReceiver;
    data['subType'] = this.subType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    data['woinType'] = this.woinType;
    data['token'] = this.token;
    data['isTransactionGift'] = this.isTransactionGift;
    return data;
  }
}

class WoinEmailGift {
  int id;
  String email;
  double amount;
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
    print("ENTRO A WOINEMAILGIFT");
    id = json['id'];
    email = json['email'];
    amount = json['amount']!=null?double.parse(json['amount'].toString()):0;
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