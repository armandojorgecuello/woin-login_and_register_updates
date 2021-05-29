import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/services/preguntaSeguridad/preguntaSeguridadJson.dart';
import 'package:woin/src/services/preguntaSeguridad/preguntaSeguridadService.dart';

class preguntaSeguridadBloc {
  List<Question> _lpseguridad = new List();
  BehaviorSubject<List<Question>> _listpreguntaSeg =
      BehaviorSubject<List<Question>>();

  Stream<List<Question>> get preguntaList => _listpreguntaSeg.stream;
  StreamSink<List<Question>> get preguntaListSink => _listpreguntaSeg.sink;

  preguntaSeguridadBloc() {
    init();
  }

  init() async {
    questionService qs = new questionService();
    geoLocation gl = new geoLocation();
    await gl.obtenerGeolocalizacion();

    qs.httpGetQuestions(gl.getLocation, gl.getDevices).then((questions) {
      _lpseguridad.addAll(questions);
      _listpreguntaSeg.sink.add(_lpseguridad);
    });
  }
}

final preguntasbloc = preguntaSeguridadBloc();
