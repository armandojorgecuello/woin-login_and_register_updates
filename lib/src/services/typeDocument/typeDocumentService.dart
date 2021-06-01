import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:woin/src/entities/Persons/typeDocument.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';
import 'package:woin/src/services/Repository/baseApi.dart';

class typeDocumentService extends BaseApiWoin {

  Future<List<typeDocument>> httpDocuments(WoinLocation location, Device device) async {
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

    //print(json.encode(params));

    try {
      Uri uri = Uri.http(ruta,  "/api/WoinDocument/typeDocument");
      var response = await http.get(
        uri,
       //body: json.encode(params),
        headers: header,
      );

      print("RESPS=>" + response.body);
      if (response.statusCode == 200) {
        // print("STATUS=200");
        var jsonr = json.decode(response.body);
        respTypeDocument resp = respTypeDocument.fromJson(jsonr);
        //print("length"+resp.lsubcategorias.length.toString());
        responseJson = resp.tiposDocumentos;
      }
    } on Exception catch (e) {
      // The request was made and the server responded with a status code

      // Something happened in setting up or sending the request that triggered an Error

      //print("ACA" + e.toString());
    }
    return responseJson;
  }
}
