import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


import 'package:woin/src/exceptions/api.dart';

class ApiBaseHelper {

  final String _baseUrl = "http://woin.com.co/api/";
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders
        .authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjEwMDgiLCJVc2VySWQiOiIyMDA4IiwiUGVyc29uSWQiOiIxMDA4IiwiUm9sZSI6IjIiLCJVc2VybmFtZSI6Inplcm9zMSIsIkVtYWlsIjoid293emVyb3MyQGdtYWlsLmNvbSIsIlR5cGVXb2luZXIiOiI2MzZjNjk3NzZmNjk2ZTY1NzIiLCJjb2RlV29pbmVyIjoiQjJFQjM4OEI1NDQiLCJIYXNoIjoiZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SkpaQ0k2SWpJd01EZ2lMQ0pTYjJ4bElqb2lNU0lzSWxWelpYSnVZVzFsSWpvaWVtVnliM014SWl3aVJXMWhhV3dpT2lKM2IzZDZaWEp2Y3pKQVoyMWhhV3d1WTI5dElpd2lWSGx3WlZkdmFXNWxjaUk2SWpjMU56TTJOVGN5SWl3aVUzUmhkR1VpT2lJeElpd2libUptSWpveE5UZzNNalUzTXpRekxDSmxlSEFpT2pFMU9EYzROakl4TkRNc0ltbGhkQ0k2TVRVNE56STFOek0wTTMwLk9JVTgyZV85NXdNckt3NTRuOTFIRXNYOXlNeklBSEZMNnZtMjU5TXR4ejAiLCJTdGF0ZSI6IjEiLCJuYmYiOjE1ODcyNTczNjMsImV4cCI6MTU4Nzg2MjE2MywiaWF0IjoxNTg3MjU3MzYzfQ.Hkl4M_aWn5ePAzhV4Pv_W1L3DV0MOr0P--dDv8Ob5Y8',
  };

  Future<dynamic> httpGet(String url) async {
    var responseJson;
    try {
      Uri uri = Uri.https(_baseUrl , url);
      final response = await http.get(uri, headers: this.headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> httpPost(String url, dynamic body) async {
    print('Api Post, url $url');
    var responseJson;
    try {
       Uri uri = Uri.https(_baseUrl , url);
      final response = await http.post(uri, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> httpPut(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
       Uri uri = Uri.https(_baseUrl , url);
      final response = await http.put(
          uri, body: body, headers: this.headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> httpDelete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
       Uri uri = Uri.https(_baseUrl , url);
      final response = await http.delete(uri, headers: this.headers);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }


  dynamic _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }




}


