import 'package:flutter/cupertino.dart';
import 'package:woin/src/Base/BaseEntity.dart';

class ConfigPoint extends Entity{
  int _id;
  int _gift;
  double _minPurshases;
  double _maxPurshases;
  bool _state;
  int _type;

  int get id => this._id;

  set state(bool state) => this._state = state;

  int get gift => this._gift;
  set gift(int gift) => this._gift = gift;

  double get minPurshases => this._minPurshases;
  set minPurshases(double minShopping) => this._minPurshases = minShopping;

  double get maxPurshases => this._maxPurshases;
  set maxPurshases(double maxShopping) => this._maxPurshases = maxShopping;

  int get type => this._type;
  set type(int type) => this._type = type;

  ConfigPoint({int id, @required int gift, @required double minPurshases, @required double maxPurshases,@required int type }):super(id){
    this._gift = gift;
    this._minPurshases = minPurshases;
    this._maxPurshases = maxPurshases;
    this._type = type;
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      // 'id': 0,
      'state': 0,
      'woinerId':1008,
      'minimumGiftPercentage': 0,
      'minPurchases': minPurshases,
      'maxPurchases':maxPurshases,
      'type': type,
      'percentage': gift,
      'giftForCash': 0,
      'minimumGiftLimitAmount':0
    };
    map.addAll(super.toJson());
    return map;
  }

  factory ConfigPoint.fromJson(Map<String, dynamic> json) {
    return ConfigPoint(
      id: json['id'] as int,
      gift: json['percentage'] as int,
      minPurshases: double.parse(json['minPurchases'].toString()),
      maxPurshases: double.parse(json['maxPurchases'].toString()),
      type: json['type'] as int
    );
  }
}