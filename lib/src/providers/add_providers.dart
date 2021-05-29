import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert' ;

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:woin/src/models/user_login.dart';
import 'package:woin/src/models/add_model.dart';
import 'package:woin/src/providers/login_provider.dart';
import 'package:woin/src/services/Repository/baseApi.dart';

class AddProvider extends BaseApiWoin{




  Future<List<AddModel>> getAllAdds(context )async{
    List<AddModel> listAdds = List();
    UserLoguin userLogin = Provider.of<LoginProvider>(context,).userLogin;
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "location.latitude": "${userLogin.woinLocation.latitude}",
      "location.longitude": "${userLogin.woinLocation.longitude}",
      "location.altitude": "${userLogin.woinLocation..altitude}",
      "device.name": "${userLogin.device.name}",
      "device.mac": "${userLogin.device.mac}",
      "device.ip": "${userLogin.device.ip}"
    };

    http.Response responseGetAdds;

    try {
      Uri uri = Uri.http(ruta,"/api/WoinAd/0/100");
      responseGetAdds = await http.get(
        uri,
        headers: header
      );
      if(responseGetAdds.statusCode == 200){
        var jsonResponse = json.decode(responseGetAdds.body);
        List<dynamic> list = jsonResponse["entities"];
        if(list != null && list.length > 0){
          list.forEach((element) { 
            AddModel addModel = AddModel.fromJson(element);
            listAdds.add(addModel);
          });
        }
        
        return listAdds;
      }

    } on SocketException  {

        print(responseGetAdds.body);
        return listAdds;

    }on Exception catch (e) {

      print(responseGetAdds.body);
      return listAdds;
      
    }
    return listAdds;
  }




}