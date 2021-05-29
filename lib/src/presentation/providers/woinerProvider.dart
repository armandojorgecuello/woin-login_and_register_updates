/*

import 'package:woin/src/entities/Transactions/Transaction.dart';
import 'package:woin/src/entities/woiner/Woiner.dart';
import 'package:flutter/material.dart';

class WoinerProvider with ChangeNotifier {
  List<ListWoinerSelected<Woiner>> _listWoiner = [];  
  Woiner _woinerSelected;
  List<Transaction> _listTransactions = [];
  bool _checkTodo = false;
  int countSelects = 0;

  List<ListWoinerSelected<Woiner>> get listWoiner => this._listWoiner.reversed.toList();
  Woiner get woinerSelected => this._woinerSelected;
  List<Transaction> get listTransactions => this._listTransactions.reversed.toList();
  bool get checkTodo => this._checkTodo;

  set woinerSelected(Woiner woiner) => this._woinerSelected = woiner;


  bool addWoiner(Woiner woiner) {
    bool resp = false;
    if(this._listWoiner.length>0){
      if(this._listWoiner.firstWhere((w)=>w.data.id == woiner.id, orElse: ()=>null) == null){
        this._listWoiner.add(ListWoinerSelected(woiner));
        this._listTransactions.add(Transaction(woinerReciever: woiner.id));
        this._woinerSelected =null;
        resp=true;
      }else{
        resp=false;
      }
    }else{
      this._listWoiner.add(ListWoinerSelected(woiner));
      this._listTransactions.add(Transaction(woinerReciever: woiner.id));
      this._woinerSelected = woiner;
      resp=true;
    }
    notifyListeners();
    return resp;
  }

  bool deleteWoiner(int index){
    this._listWoiner = this._listWoiner.reversed.toList();
    this._listTransactions = this._listTransactions.reversed.toList();
    bool resp = this._listWoiner.removeAt(index) == null?false:true;
    this._listTransactions.removeAt(index);
    this._listWoiner = this._listWoiner.reversed.toList();
    this._listTransactions = this._listTransactions.reversed.toList();
    this._woinerSelected = null;
    notifyListeners();
    return resp;
  }

  void changeWoinerSelected(Woiner woiner){
    this._woinerSelected = woiner;
    notifyListeners();
  }

  void clearWoinerSelected(){
    _listWoiner.firstWhere((t)=>t.data == this._woinerSelected, orElse: ()=>null)?.isSelected=false;
    this._woinerSelected = null;
    notifyListeners();
  }
  void changeAmount(double value){
    this._listTransactions.firstWhere((t)=>t.woinerReceiver == this._woinerSelected.id, orElse: null)?.amount = value;
    // print(this._listTransactions.firstWhere((t)=>t.woinerReceiver == this._woinerSelected.id, orElse: null)?.amount);
    notifyListeners();
  }
  int countListSelect(){
    return this._listWoiner.where((data)=>data.isSelected == true).toList().length;
  }

  void changeCheckTodo(bool checkTodo){
    if(checkTodo){
      this._checkTodo = this._listWoiner.length == countListSelect()?true:false;
    }else {
      this._checkTodo = checkTodo;
      this._woinerSelected = null;
    }
    notifyListeners();
  }
  void changeIsSelect(ListWoinerSelected woiner){
    this._listWoiner.firstWhere((w)=>w.data.id == woiner.data.id, orElse: null)?.isSelected = !woiner.isSelected;
    notifyListeners();
  }

  void clearWoinersSelected(){
    this._listWoiner = [];
    this._woinerSelected = null;
    notifyListeners();
  }
}*/
