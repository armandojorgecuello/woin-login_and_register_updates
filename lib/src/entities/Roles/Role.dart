import 'package:woin/src/Base/BaseEntity.dart';
import 'package:flutter/material.dart';
/*
 * Woin 
 *
 * Woin TDD architecture + clean code
 * 
 * @link https://dev-woin@dev.azure.com/dev-woin/app.woin/_git/woin
 * @since  0.1 rev
 * @author Kenneth Raul Mendoza Lopez <kenne_8@outlook.es>
 * @file Domain/Entities
 * @observations use abstractions for Entities
 * @HU 0: Infraestructure
 * @task Task: Infraestructura
 */

class Role extends Entity {
  final String name, description;
  Role({int id, @required this.name, @required this.description}) : super(id);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'description': description,
    };
    map.addAll(super.toJson());
    return map;
  }
}

