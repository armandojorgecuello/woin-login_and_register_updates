import 'package:flutter/material.dart';
import 'package:woin/src/Base/BaseEntity.dart';

class Product extends Entity {
  String name;
  String description;
  int subcategoryId; 
  double price; 
  Product({int id, @required this.name}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'subcategoryId': subcategoryId,
      'price': price
    };
    map.addAll(super.toJson());
    return map;
  }
}