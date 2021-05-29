import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';
import 'package:woin/src/services/Repository/baseApi.dart';

class categoryService extends BaseApiWoin {
  Future<List<Category>> httpGetCategories(
      WoinLocation location, Device device) async {
    var responseJson;
    //print("GET CAT");
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
      Uri uri = Uri.http(ruta, "/api/WoinCategory/0/100");
      var response = await http.get(
        uri,
        //body: json.encode(params),
        headers: header,
      );

      //print("RESPS=>" + response.body);
      if (response.statusCode == 200) {
        // print("STATUS=200");
        var jsonr = json.decode(response.body);
        Respcategory resp = Respcategory.fromJson(jsonr);
        //print("length"+resp.lsubcategorias.length.toString());
        responseJson = resp.categorias;
      }
    } on Exception catch (e) {
      // The request was made and the server responded with a status code

      // Something happened in setting up or sending the request that triggered an Error

      //print("ACA" + e.toString());
    }
    return responseJson;
  }
}
