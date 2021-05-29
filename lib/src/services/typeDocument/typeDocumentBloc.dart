import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';

import 'package:woin/src/entities/Persons/typeDocument.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/services/typeDocument/typeDocumentService.dart';

class typeDocumentBloc {
  List<typeDocument> _lisDocuments = new List();
  BehaviorSubject<List<typeDocument>> _listtypesDocument =
      BehaviorSubject<List<typeDocument>>();

  Stream<List<typeDocument>> get documentsList => _listtypesDocument.stream;
  StreamSink<List<typeDocument>> get documentsListSink =>
      _listtypesDocument.sink;

  typeDocumentBloc() {
    init();
  }

  init() async {
    //print("INIT BLOC");
    typeDocumentService ds = new typeDocumentService();
    geoLocation gl = new geoLocation();
    await gl.obtenerGeolocalizacion();

    ds.httpDocuments(gl.getLocation, gl.getDevices).then((docs) {
      _lisDocuments.addAll(docs);
      _listtypesDocument.sink.add(_lisDocuments);
    });
  }
}

final documentsbloc = typeDocumentBloc();
