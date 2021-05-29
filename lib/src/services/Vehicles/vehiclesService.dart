

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:woin/src/exceptions/api.dart';
import 'package:woin/src/services/Repository/baseApi.dart';
import 'package:woin/src/services/Vehicles/vehicles.dart';


class vehiclesService extends BaseApiWoin {

  Future<List<Vehicle>> httpGetVehicles() async {
    var responseJson;

    final header= {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      Uri uri = Uri.http(ruta,  "/api/Vehicle/0/100");

      var response = await http.get(uri, headers:header);
      if(response.statusCode==200){
        //print("STATUS=200");
        var jsonr= json.decode(response.body);
        Vehicles resp=Vehicles.fromJson(jsonr);
        //print("length"+resp.lsubcategorias.length.toString());
        responseJson= resp.entities;
      }

    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

}