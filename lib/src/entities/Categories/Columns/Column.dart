import 'package:woin/src/Base/BaseEntity.dart';
import 'package:flutter/material.dart';

class Column extends Entity
{
  String name;
  ColumnState state;
  Column({int id: 0, @required this.name, @required this.state}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'state': state
    };
    map.addAll(super.toJson());
    return map;
  }
}

enum ColumnState
{
  inactive,
  active
}