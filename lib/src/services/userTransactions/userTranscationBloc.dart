


import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/services/userTransactions/activeOptionsUser.dart';

class userTransactionBloc{
  BehaviorSubject<int> _ActiveOptions = BehaviorSubject<int>();
  Stream<int> get isActiveOptions => _ActiveOptions.stream;
  StreamSink<int> get isActiveOptionsSink =>_ActiveOptions.sink;

  userTransactionBloc(){
    init();
  }
init(){
  activeOptions activeO= new activeOptions();
  _ActiveOptions.sink.add(activeO.active);
  //print("ACA=>"+activeO.active.toString());
}
  activeOptionsUser(){
    activeOptions activeO= new activeOptions();
    activeO.activarOptions();
    _ActiveOptions.sink.add(activeO.active);
   // print("ACA1=>"+activeO.active.toString());
  }





}

final activarOpcionesBloc = userTransactionBloc ();