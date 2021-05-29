

import 'dart:convert';
import 'dart:io';

import 'package:woin/src/entities/anuncio/AnuncioList.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/services/Repository/baseApi.dart';
import 'package:http/http.dart' as http;


class AnuncioListService extends BaseApiWoin{

  Future<List<AnuncioAd>> listAnuncio(String where) async {

    var responseJson;
    userdetalle sesion = new userdetalle();

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:  'Bearer ${sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm}'
    };

    var response;


    print(json.encode(where=="" || where==null?{"where":"1=1"}:{"where":where}));

    try {
      Uri uri = Uri.http(ruta,"/api/WoinAd/GetAds/0/2147483647" );
      response = await http.post(uri ,
          body: json.encode(where=="" || where==null?{"where":"1=1"}:{"where":where}),
          headers: header);
      print("RESP=>"+response.body);


      if (response.statusCode == 200) {
        var jsonr = responseJson = json.decode(response.body);
        respAnuncio rad= respAnuncio .fromJson(jsonr);

        print(rad.Anuncioad.length);
        return rad.Anuncioad;

      } else {
        respAnuncio rad =respAnuncio(message: "Error al hacer petición",status: false,code: null,Anuncioad:  null);
        return rad.Anuncioad;
      }
    } on SocketException {
      respAnuncio rad =respAnuncio(message: "Error interno socket",status: false,code: null,Anuncioad: null);
      return rad.Anuncioad;


    } on Exception catch (e) {
      respAnuncio rad =respAnuncio(message: "Error interno socket",status: false,code: null,Anuncioad: null);
      return rad.Anuncioad;


    }



  }





}