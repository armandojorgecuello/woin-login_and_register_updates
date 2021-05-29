/*
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:woin/src/entities/Ads/Ad.dart';
import 'package:woin/src/entities/Persons/Person.dart';
import 'package:woin/src/entities/woiner/Woiner.dart';
import 'package:woin/src/helpers/apiBase.dart';
import 'package:flutter/services.dart' show rootBundle;

class _WoinerService{
  ApiBaseHelper _api = new ApiBaseHelper();
  Future<Woiner> getWoiner(int id) async {
    final response = await _api.httpGet("woiner/$id");
    Map resp = json.decode(response);
    return Woiner.fromJson(resp['entity']);
  }
  Future<Person> getPerson() async {
    Map response = await _api.httpGet("WoinPerson");
    return Person.fromJson(response['entities'][0]);
  }

  Future<List<Woiner>> getWoinerAll() async {
    // List<dynamic> response = [];
    List<Woiner> woiners = [];
    final response = await _api.httpGet("woiner");
    Map resp = json.decode(response);
    response.forEach((woiner)=>woiners.add(Woiner.fromJson(woiner['entity'])));
    return woiners;
  }

  Future<dynamic> post(Woiner woiner) async {
    return await _api.httpPost('woiner', woiner);
  }
  List<dynamic> opciones =[];
  _WoinerService(){
    // cargarDatos();
  }

  Future<List<Woiner>> search(String search, {int type =1 }) async {
    if ((search == '' || search.isEmpty || search.length < 4) && type ==1) {
      print('object jum');
      return [];
    }
    Map<String, dynamic> body = {'type': type, 'search': search};
    String jsonBody = json.encode(body);
    List<Woiner> woiners = [];
    Map response = await _api.httpPost("WoinWoiner/search", jsonBody);
    List<dynamic> resp = response['entities'];
    if (resp.length != 0) {
      print(resp[0]['woinPerson']['secondname']);
      resp.forEach((entity){
        Woiner woiner = new Woiner();
        woiner.person = Person.fromJson(entity['woinPerson']);
        woiner.codewoiner = entity['woinWoiners'][0]['codewoiner'];
        woiner.id = entity['woinWoiners'][0]['id'];
        woiner.type = entity['woinWoiners'][0]['roleId'].toString();
        woiners.add(woiner);
      });
    }
    
    return woiners;
  }
}

final woinerService = new _WoinerService();
*/
