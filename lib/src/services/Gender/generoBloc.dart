import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/Persons/gender.dart';


class generoBloc {
  List<genero> _lgeneros = new List();
  BehaviorSubject<List<genero>> _listgender = BehaviorSubject<List<genero>>();

  Stream<List<genero>> get genderList => _listgender.stream;
  StreamSink<List<genero>> get genderListSink => _listgender.sink;

  generoBloc() {
    init();
  }

  init() async {
    listGender lg = new listGender();
    final lgen = await lg.obtenerGeneros();
    _lgeneros.addAll(lgen);
    _listgender.sink.add(_lgeneros);
  }
}

final gendersbloc = generoBloc();
