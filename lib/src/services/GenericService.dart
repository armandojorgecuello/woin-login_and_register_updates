/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:woin/src/Base/BaseEntity.dart';

abstract class GenericService<T extends Entity> {
  String _url = 'api.woin.com';

  Future<dynamic> _get(Uri url) async {
    final resp = await http.get(url);
    return json.decode(resp.body);
  }

  Future<dynamic> _post({@required Uri url, dynamic body}) async {
    final resp = await http.post(url, body: body);
    return json.decode(resp.body);
  }

  Future<dynamic> _put({@required Uri url, dynamic body}) async {
    final resp = await http.put(url, body: body);
    return json.decode(resp.body);
  }

  Future<dynamic> httpRequest({@required String url, Map<String, String> queryParams, dynamic body, @required String method}) async {
    final request = Uri.https(_url, url, queryParams);
    switch (method.toUpperCase()) {
      case 'GET':
        return await _get(request);
        break;
      case 'POST':
        return await _post(url: request, body: body);
        break;
      case 'PUT':
        return await _put(url: request, body: body);
        break;
      default:
        throw new Exception('Invalid Http Method');
    }
  }
}*/
