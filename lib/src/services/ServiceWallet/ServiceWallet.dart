import 'dart:convert';
import 'dart:io';

import 'package:woin/src/entities/Wallet/walletEntity.dart';
import 'package:woin/src/exceptions/api.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/services/Repository/baseApi.dart';
import 'package:http/http.dart' as http;

class WalletService extends BaseApiWoin{
  userdetalle sesion = new userdetalle();
  
  Future<WalletRespJson> obtenerWallet(int type,int cuenta) async {
    var responseJson;

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${cuenta == 2 ? sesion.getTokenCli : sesion.getTokenEm}',
    };
    print("PETICION WALLET");
    var response;
    try {
      Uri uri = Uri.http(ruta, "/api/WoinWallet/"+type.toString());
      response = await http.get(uri,
          headers: header,
          //body: json.encode({})
          );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonr = responseJson = json.decode(response.body);
        WalletRespJson wj = WalletRespJson.fromJson(jsonr);
        print("RESPONSE OK");
        return wj;
      }
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    var jsonr = responseJson = json.decode(response.body);
    print(jsonr);
    return WalletRespJson.fromJson(jsonr);
    ;
  }
}