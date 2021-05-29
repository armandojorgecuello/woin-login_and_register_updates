import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/services/Repository/centralUser.dart';

class blocUser {
  //BLOC USUARIO LOGUEADO PARA ACTUALIZAR WIDGETS
  BehaviorSubject<userdetalle> _userLogueadoB = BehaviorSubject<userdetalle>();

  centralUser cu = new centralUser();
  BehaviorSubject<int> _selectedTipoUser = BehaviorSubject<int>();
  final _selectedTipo = StreamController<int>();

  Stream<int> get tipoUser => _selectedTipoUser.stream;
  StreamSink<int> get tipoUserg => _selectedTipoUser.sink;

  //GETTER Y SETTER TRANSACTIONS
  //WOINER

  //GETTER Y SETTER USUARIO LOGUEADO BLOC
  Stream<userdetalle> get userSesionG => _userLogueadoB.stream;
  StreamSink<userdetalle> get userSesionGSink => _userLogueadoB.sink;

  StreamSink<int> get asignarTipo => _selectedTipo.sink;

  blocUser() {
    init();
  }

  init() async {
    await _selectedTipoUser.sink.add(cu.toogleButton);

    //CARGAR USUARIOS

    _selectedTipo.stream.listen(modificarTipoUser);
  }

  modificarTipoUser(int tipo) {

    cu.tiposuer = tipo;
    tipoUserg.add(cu.toogleButton);
    userdetalle userlog = new userdetalle();
    userlog.setCuentaActiva = tipo;
    userSesionGSink.add(userlog);
  }
}

final tipoUser = blocUser();
