import 'package:woin/src/Base/BaseEntity.dart';
import 'package:flutter/material.dart';

class Subcategory extends Entity {
  String name;
  int state;
  int categoryId;
  int parentId;

  Subcategory({@required int id, @required this.name, @required this.categoryId, this.state, this.parentId, int createdAt, int updatedAt}) : super(id) {
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int,
      name: json['name'] as String,
      state: json['state'] as int,
      parentId: json['parentId'] as int,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'state': state,
      'categoryId': categoryId,
      'parentId': parentId
    };
    map.addAll(super.toJson());
    return map;
  }

  @override
  String toString() {
    return "$name";
  }
}