import 'dart:convert';

import 'package:http/http.dart';
import 'package:woin/src/entities/Transactions/listTransactions.dart';
import 'package:woin/src/services/Repository/baseApi.dart';


class MovementApiProvider extends BaseApiWoin {
  Client client = Client();

  //final _apiKey = 'b3614c94f521c384ac8444f1f465136b';
  // final _baseUrl = "http://192.168.43.95:1337";

  Future<transactionList> fetchMovementList() async {
    print("entered");
    Uri uri = Uri.http(ruta, "/api/WoinTransaction/0/100000");
    final response = await client.get(uri);

    print(response.body.toString());

    if (response.statusCode == 200) {
      print("ACAAAAAAA000000");
      // If the call to the server was successful, parse the JSON
      return transactionList.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      //throw Exception('Failed to load movement');
    }
  }
}
