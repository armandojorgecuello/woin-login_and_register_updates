


import 'dart:convert';
import 'dart:io';

import 'package:woin/src/entities/Transactions/listTransactions.dart';
import 'package:woin/src/entities/Transactions/transactionJsonPost.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/services/Repository/baseApi.dart';
import 'package:http/http.dart' as http;

class TransactionsService extends BaseApiWoin{

  //OBTENER LISTA DE TRANSACCIONES
  Future<transactionList> obtenerTransactions() async {
    print("OBTENER TRANSACCIONES");
    var responseJson;
    userdetalle sesion = new userdetalle();

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:  'Bearer ${sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm}'
    };

    var response;
    //var params = {'woinLocation': location, 'device': device};
    try {
      Uri uri = Uri.http(ruta, "/api/WoinTransaction/0/100000");
      response = await http.get(uri,
          //body: json.encode({}),
          headers: header);
      print("RESPUESTAAAAAAAAAA¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡");
      //print(response.body);


      if (response.statusCode == 200) {
        print("STATUS 200");
        var jsonr = responseJson = json.decode(response.body);

          try{
            print("ENTRO EN TRY");
            transactionList tl=transactionList.fromJson(jsonr);
            print("RETORNO DE TRANSACCIONES");
            return tl;
          }on Exception catch(ex){
            print(ex);
          }




      } else {
        print("ENTRA ACA 200");
        transactionList tl =transactionList(message: "Error al hacer petición",status: false,code: null,entities: null);
        return tl;
      }
    } on SocketException {
      print("EXCEPTION=> SOCKECT ESCEPTION");
      transactionList tl =transactionList(message: "Error interno socket",status: false,code: null,entities: null);
      return tl;


    } on Exception catch (e) {
      print("EXCEPCION=>"+e.toString());
      transactionList tl =transactionList(message: "Error al hacer petición, Excepción",status: false,code: null,entities: null);
      return tl;


    }

    //print("IMPRIME2=>" + response.body);
  }

  //POST O GUARDAR TRANSACCION
  Future<transactionList> postTransaccion(transactionJson t) async {
    print("REALIZAR  TRANSACCIONES");
    var responseJson;
    userdetalle sesion = new userdetalle();

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:  'Bearer ${sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm}'
    };

    var response;

    print("BODY======>");
    print(json.encode(t));

    //var params = {'woinLocation': location, 'device': device};
    try {
      print("----------------------GUARDAR  TRANSACCION--------------------");
      Uri uri = Uri.http(ruta, "/api/WoinTransaction");
      response = await http.post(uri,
          body: json.encode(t),
          headers: header);
      print("RESPUESTAAAAAAAAAA¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡");
      print(response.body);


      if (response.statusCode == 200) {
        print("STATUS 200");
        var jsonr = responseJson = json.decode(response.body);
        print("----------------------GUARDO TRANSACCION--------------------");

        try{
          print("ENTRO EN TRY");
          transactionList tl=transactionList.fromJson(jsonr);
          print("RETORNO DE TRANSACCIONES");
          return tl;
        }on Exception catch(ex){
          print(ex);
        }
      } else {

        transactionList tl =transactionList(message: "Error al hacer petición",status: false,code: null,entities: null);
        print("----------------------ERROR TRANSACCION--------------------");
        print(response.body);
        print(response.statusCode);
        return tl;
      }
    } on SocketException {
      print("EXCEPTION=> SOCKECT ESCEPTION");
      transactionList tl =transactionList(message: "Error interno socket",status: false,code: null,entities: null);
      return tl;


    } on Exception catch (e) {
      print("EXCEPCION=>"+e.toString());
      transactionList tl =transactionList(message: "Error al hacer petición, Excepción",status: false,code: null,entities: null);
      return tl;


    }

    //print("IMPRIME2=>" + response.body);
  }
  //INTERN 0
  //TRANSFER 1   PAGAR
  // GIFT    3
  //PURCHASE 2
  //RECHARGE 4
  //COMISION 5
  //REDEMPTION 6
  //REQUEST 7  SOLICITAR
  //EMAILGIFT 8

}