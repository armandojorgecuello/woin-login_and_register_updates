import 'package:woin/src/Base/BaseEntity.dart';

import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/entities/Categories/Subcategory.dart';
import 'package:woin/src/entities/Products/Product.dart';
import 'package:flutter/cupertino.dart';

class Ad extends Entity {
  String title;
  String description;
  double price;
  int state;
  int giftPercentage;
  int discountPercentage;
  int initialStock;
  int currentStock;
  int type;
  int initialTime;
  int finalTime;
  int adParentId;
  int woinerId;
  int categoryId;
  Category category;
  int subcategoryId;
  Subcategory subcategory;
  int secondSubcategoryId;
  Subcategory secondSubcategory;
  int scopeId;
  //Scope scope;
  int genderWoiner;
  List<Product> products;
  String nameCompany;

  Ad.empty() : super(0)
  {
    description = '';
    discountPercentage = 0;
    giftPercentage = 0;
    initialStock = 0;
    nameCompany = '';
    price = 1000.0;
    state = 1;
    title = 'Ad Title';
    currentStock = 0;
    subcategoryId = 0;
    woinerId = 0;
    genderWoiner = 0;
    //scope = new Scope();
  }

  Ad({int id, @required this.nameCompany, this.currentStock, @required this.initialStock, @required this.title,@required this.description,
  @required this.price, @required this.giftPercentage, @required this.discountPercentage, @required this.state, @required this.subcategoryId, this.secondSubcategoryId, @required this.woinerId, this.categoryId, this.adParentId, this.initialTime, this.finalTime, this.genderWoiner, this.products}) : super(id);
  
  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      title: json['title'] as String,
      nameCompany: json['nameCompany'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      giftPercentage: json['giftPercentage'] as int,
      currentStock: json['currentStock'] as int,
      discountPercentage: json['discountPercentage'] as int,
      initialStock: json['initialStock'] as int,
      state: json['state'] as int,
      id: json['id'] as int,
      subcategoryId: 0,
      woinerId: 0
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title,
      'description': description,
      'price': price,
      'state': state,
      'giftPercentage': giftPercentage,
      'discountPercentage': discountPercentage,
      'initialStock': initialStock,
      'currentStock': currentStock,
      'type': type,
      'initialTime': initialTime,
      'finalTime': finalTime,
      'adParentId': adParentId,
      'woinerId': woinerId,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'secondSubcategoryId': secondSubcategoryId,
      'scopeId': scopeId,
      'genderWoiner': genderWoiner,
      'nameCompany': nameCompany,
      'products': products
    };
    map.addAll(super.toJson());
    return map;
  }

  Duration getDuration() {
    return DateTime.fromMillisecondsSinceEpoch(finalTime ?? 0)
            .difference(DateTime.fromMillisecondsSinceEpoch(initialTime ?? 0));
  }
}