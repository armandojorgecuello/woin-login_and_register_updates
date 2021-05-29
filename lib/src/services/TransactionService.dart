/*import 'dart:async';
import 'dart:convert';
import 'package:woin/src/entities/Transactions/Transaction.dart';
import 'package:woin/src/helpers/apiBase.dart';

class _TransactionService{
  ApiBaseHelper _api = new ApiBaseHelper();

  Future<Transaction> post(Transaction transaction) async {
    return await _api.httpPost('transaction/add', json.decode(transaction.toJson().toString()));
  }

  // Intern = 0,
  //       Transfer = 1,-> esta son tranferencias 
  //       Purchase = 2,
  //       Gift = 3,
  //       Recharge = 4,
  //       Comission = 5,
  //       Reredemption = 6,
  //       Request = 7

  Future postAll(List<Transaction> transactions) async {
    // List<String> body = [];
    // transactions.forEach((transaction)=>body.add(transaction.toJson().toString()));
    List jsonList = List();
    transactions.map((item) => jsonList.add(item.toJson())).toList();
    String jsonBody = json.encode({'entities':jsonList});
    print(jsonBody);
    return await _api.httpPost('WoinTransaction/addRange', jsonBody);
  }

  Future<Transaction> getTransaction() async {
    final response = await _api.httpGet('transaction/get');
    return Transaction.fromJson(response);
  }

  Future<List<Transaction>> getTransactionAll() async {
    return await _api.httpGet('transaction');
  }

  Future<double> getWallet() async{
    var resp = await _api.httpGet('WoinWallet/0');
    List<dynamic> list =  resp['entities'];
    var wallet = list.firstWhere((t)=>t['type'] == 0, orElse: ()=>null);
    print(wallet['balance']);
    if(wallet!=null)return wallet['balance'] as double;
    return 0;
  }
}

final transactionService = new _TransactionService();*/
