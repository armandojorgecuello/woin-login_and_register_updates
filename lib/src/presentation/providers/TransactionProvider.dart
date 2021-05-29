/*import 'package:woin/src/entities/Transactions/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _listTransactions = [];
  String _note = '';

  List<Transaction> get listTransactions => this._listTransactions.reversed.toList();
  String get note => this._note;

  void addTransaction(int woinerReceiver) {
    this._listTransactions.add(Transaction(woinerReciever: woinerReceiver));
    notifyListeners();
  }

  void deleteTransaction(int index){
    this._listTransactions = this._listTransactions.reversed.toList();
    this._listTransactions.removeAt(index);
    this._listTransactions = this._listTransactions.reversed.toList();
    notifyListeners();
    
  }

  void changeAmount(int woinerReceiver, double value){
    this._listTransactions.firstWhere((t)=>t.woinerReceiver == woinerReceiver, orElse: null)?.amount = value;
    // print(this._listTransactions.firstWhere((t)=>t.woinerReceiver == this._woinerSelected.id, orElse: null)?.amount);
    notifyListeners();
  }

  void changeType(int type){
    print('type $type');
    this._listTransactions.forEach((transaction)=>transaction.type = type);
    // print('type t ${this._listTransactions[0].type}');
    notifyListeners();
  }

  void changeNota(String note){
    this._note = note;
    notifyListeners();
  }

  void clearTransactions(){
    this._listTransactions = [];
    this._note = '';
    notifyListeners();
  }

}*/
