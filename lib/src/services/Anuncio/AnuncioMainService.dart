

import 'dart:convert';
import 'dart:io';

import 'package:woin/src/entities/anuncio/AnuncioMain.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/services/Repository/baseApi.dart';
import 'package:http/http.dart' as http;

class mainAnuncioService extends BaseApiWoin{

  //CREAR ANUNCIO
  Future<RespanuncioAd> addAnuncio(anuncioAd anuncio) async {
    var responseJson;
    userdetalle sesion = new userdetalle();

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:  'Bearer ${sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm}'
    };



    var response;


    print(json.encode(anuncio));

    try {
      Uri uri = Uri.http(ruta,"/api/WoinAd" );

      response = await http.post(uri,
          body: json.encode(anuncio),
          headers: header);
      print("RESP=>"+response.body);


      if (response.statusCode == 200) {
        var jsonr = responseJson = json.decode(response.body);
        RespanuncioAd rad=RespanuncioAd.fromJson(jsonr);
        return rad;

      } else {
        RespanuncioAd rad =RespanuncioAd(message: "Error al hacer petición",status: false,code: null,entities: null);
        return rad;
      }
    } on SocketException {
      RespanuncioAd rad =RespanuncioAd(message: "Error interno socket",status: false,code: null,entities: null);
      return rad;
     

    } on Exception catch (e) {
      print("EXCEPCION=>"+e.toString());
      RespanuncioAd rad =RespanuncioAd(message: "Error al hacer petición, Excepción",status: false,code: null,entities: null);
      return rad;

    
    }

    //print("IMPRIME2=>" + response.body);
  }

}

final MainAnuncioService=mainAnuncioService();