import 'dart:async';
import 'dart:convert';

import 'package:woin/src/entities/Ads/Ad.dart';
import 'package:woin/src/helpers/apiBase.dart';
import 'package:flutter/services.dart' show rootBundle;

class _AdService{
  ApiBaseHelper _helper = new ApiBaseHelper();
  Future<Ad> getAll(int id) async {
    final response = await _helper.httpGet("");
    return Ad.fromJson(response);
  }
  List<dynamic> opciones =[];
  _AdService(){
    // cargarDatos();
  }

  Future <List<dynamic>> alldatos() async{
    final resp = await rootBundle.loadString('data/getAd.json');
    Map dataMap = json.decode(resp);
    opciones = dataMap['ads'];
    return opciones;
  }

  Future <dynamic> getdato(int index) async{
    final resp = await rootBundle.loadString('data/getAd.json');
    Map dataMap = json.decode(resp);
    opciones = dataMap['ads'];
    return opciones[index];
  }
}

final adService = new _AdService();