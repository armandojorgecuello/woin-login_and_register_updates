/*import 'dart:async';
import 'dart:convert';

import 'package:woin/src/entities/Ads/Ad.dart';
import 'package:woin/src/services/GenericService.dart';
import 'package:flutter/services.dart' show rootBundle;

class _AdService extends GenericService<Ad> {
  
  List<Ad> processResponse(List<dynamic> jsonList) {
    if(jsonList == null) return [];

    List<Ad> items = new List<Ad>();
    for (var item in jsonList) {
      final ad = new Ad.fromJson(item);
      items.add(ad);
    }
    return items;
  }

  Future<List<Ad>> getAll() async {
    List<dynamic> entities = [];
    final resp = await httpRequest(url: 'ad', method: 'get');
    entities = resp['ads'];
    return processResponse(entities);
  }

  Future<dynamic> create(Ad entity) async {
    final resp = await httpRequest(url: 'ad', method: 'post', body: entity.toJson());
    return resp;
  }

  Future<Ad> update(int id, Ad entity) async {
    final resp = await httpRequest(url: 'ad', method: 'put', body: entity.toJson());
    return resp;
  }

  Future<int> cargarDatos() async{
    List entities = [];
    final resp = await rootBundle.loadString('data/getAd.json');
    Map dataMap = json.decode(resp);
    entities = dataMap['ads'];
    return entities.length;
  }

  Future <List<dynamic>> alldatos() async{
    List entities = [];
    final resp = await rootBundle.loadString('data/getAd.json');
    Map dataMap = json.decode(resp);
    entities = dataMap['ads'];
    return processResponse(entities);
  }

  Future <dynamic> getdato(int index) async{
    List entities = [];
    final resp = await rootBundle.loadString('data/getAd.json');
    Map dataMap = json.decode(resp);
    entities = dataMap['ads'];
    return entities[index];
  }
}

final adService = new _AdService();*/
