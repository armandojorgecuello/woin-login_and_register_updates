/*import 'package:woin/src/Base/BaseEntity.dart';
import 'package:woin/src/entities/Persons/Person.dart';
import 'package:flutter/material.dart';

class ListWoinerSelected<T>{
  bool isSelected = false;
  T data;
  ListWoinerSelected(this.data);
}

class Woiner extends Entity{
  String _codewoiner;
  String _type;
  Person _person;

  String get codewoiner => this._codewoiner;
  set codewoiner(String codewoiner)=>this._codewoiner = codewoiner;

  Person get person => this._person;
  set person(Person person) => this._person = person;

  String get type => this._type;
  set type(String type) => this._type = type;
  
  Woiner({int id, String codewoiner, Person person, String type}):super(id){
    this._codewoiner = codewoiner;
    this._person = person;
    this._type = type;
  }

  factory Woiner.fromJson(Map<String, dynamic> json) {
    return Woiner(
      codewoiner: json['codewoiner'] as String,
      id: json['id'] as int,
      person: Person.fromJson(json['person'])
    );
  }
}*/
