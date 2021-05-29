import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:woin/src/models/user_login.dart';

import 'package:woin/src/exceptions/api.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';
import 'package:woin/src/services/Repository/baseApi.dart';
import 'package:woin/src/services/avatars/avatarsJson.dart';

class avatarsService extends BaseApiWoin {
  Future<List<Avatar>> httpGetAvatars(
      WoinLocation location, Device device) async {
    var responseJson;

    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: "application/json",
    };
    device.id = 0;
    device.userId = 0;
    device.createdAt = 0;
    device.updatedAt = 0;

    var params = {'woinLocation': location, 'device': device};

    try {
      Uri uri = Uri.http(ruta, "/api/WoinAvatar/0/100");
      var response = await http.get(
        uri,
        //body: json.encode(params),
        headers: header,
      );

      //print("RESPA=>" + response.body);

      if (response.statusCode == 200) {
        print("STATUS=200");
        var jsonr = json.decode(response.body);
        Avatars resp = Avatars.fromJson(jsonr);
        //print("length"+resp.lsubcategorias.length.toString());
        responseJson = resp.entities;
      }
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
