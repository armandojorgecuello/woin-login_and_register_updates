/*import 'dart:async';
import 'dart:convert';
import 'package:woin/src/entities/configuration/ConfigPoint.dart';
import 'package:woin/src/helpers/apiBase.dart';

class _ConfigurationService{
  ApiBaseHelper _api = new ApiBaseHelper();
  Future<List<ConfigPoint>> getConfig() async {
    List<ConfigPoint> configPoints = [];
    Map response = await _api.httpGet('WoinWoinerConfig');
    List<dynamic> list = response['entities'];
    if (list.length != 0) {
      list.forEach((entity)=>configPoints.add(ConfigPoint.fromJson(entity)));
    }
    print(configPoints[0].gift);
    return configPoints;
  }

  Future<dynamic> postConfigPoint(ConfigPoint configPoint) async {
    String jsonBody = json.encode(configPoint.toJson());
    return await _api.httpPost('WoinWoinerConfig', jsonBody);
  }

  Future<ConfigPoint> put(ConfigPoint configPoint, int id) async {
    return await _api.httpPut('configuration/point/$id', configPoint);
  }
}

final configurationService = new _ConfigurationService();*/
