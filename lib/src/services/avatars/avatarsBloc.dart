import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/services/avatars/avatarsJson.dart';
import 'package:woin/src/services/avatars/avatarsService.dart';

class avatarsBloc {
  List<Avatar> _lavatar = new List();
  BehaviorSubject<List<Avatar>> _listAvatars = BehaviorSubject<List<Avatar>>();

  Stream<List<Avatar>> get AvatarList => _listAvatars.stream;
  StreamSink<List<Avatar>> get AvatarSink => _listAvatars.sink;

  avatarsBloc() {
    init();
  }

  init() async {
    avatarsService avatarsServ = new avatarsService();
    geoLocation gl = new geoLocation();
    await gl.obtenerGeolocalizacion();

    avatarsServ.httpGetAvatars(gl.getLocation, gl.getDevices).then((lavatars) {
      _lavatar.addAll(lavatars);
      _listAvatars.sink.add(_lavatar);
    });
  }
}

final avatarsbloc = avatarsBloc();
