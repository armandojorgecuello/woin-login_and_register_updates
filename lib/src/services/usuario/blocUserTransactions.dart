import 'dart:async';
import 'dart:math';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/users/userTransactions.dart';

class blocUserTransactions {
  BehaviorSubject<List<userTransactions>> _userListWoiner =
      BehaviorSubject<List<userTransactions>>();

  BehaviorSubject<int> _activeDelete = BehaviorSubject<int>();

  final _listageneral = StreamController<List<userTransactions>>();

  final _isactiveDelete = StreamController<int>();

  List<userTransactions> ldelete;
  List<userTransactions> lGENAL;

  int iduserb = 0;

  //GETTER Y SETTER
  Stream<List<userTransactions>> get listGeneral => _userListWoiner.stream;
  StreamSink<List<userTransactions>> get listGeneralSink =>
      _userListWoiner.sink;
  Stream<int> get isActiveDelete => _activeDelete.stream;
  StreamSink<int> get isActiveDeleteSink => _activeDelete.sink;

  StreamSink<List<userTransactions>> get eventAddlist => _listageneral.sink;
  StreamSink<int> get activarSink => _isactiveDelete.sink;
  //PARA AGREGAR ELEMENTOS A LISTA QUE SE VA A BORRAR

  //PARA BORRAR TODOS O SELECCIONADOS
  StreamSink<int> get deleteUser => _isactiveDelete.sink;

  //CONSTRUCTOR
  blocUserTransactions() {
    ldelete = new List();
    lGENAL = new List();
    //EVENTOS
    _listageneral.stream.listen(addListaGnal);
    _userListWoiner.sink.add(new List());

    _isactiveDelete.stream.listen(activarDelete);
  }
  addListaGnal(List<userTransactions> lista) {
    print("ADD A LISTA");
    lGENAL.addAll(lista);
    _userListWoiner.sink.add(lGENAL);
  }

  addToDelete(userTransactions user) {
    if (user.codewoiner == "0") {
      user.codewoiner = iduserb.toString();
      iduserb++;
    }

    if (ldelete.contains(user)) {
      ldelete.remove(user);
      print("ELIMINADO");
    } else {
      ldelete.add(user);

      print("AGREGADO");
    }
    print("DESDE BLOC=>" + ldelete.length.toString());
    if (ldelete.length > 0) {
      _isactiveDelete.sink.add(1);
    } else {
      _isactiveDelete.sink.add(0);
    }
  }

  activarDelete(int opcion) {
    //BORRAR SELECCIONADOS EN LA LISTA
    _activeDelete.sink.add(opcion);
  }
}

final usersTransactionBloc = blocUserTransactions();

/*import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';

import 'package:woin/src/services/usuario/userService.dart';

class blocUserTransactions {
  userdetalle sesion = new userdetalle();
  String busqueda = "";
  int id = 0;
  //BLOC USER FOR TRANSACTIONS
  //LISTAS QUE VAN GUARDANDO LOS USUARIOS QUE VAN AGRGANDO DE LAS PETICIONES
  List<userTransactions> uRed;
  List<userTransactions> uwoiners;
  // LISTA PARA AGREGAR REFERIDOS
  List<userTransactions> listReferidoUSer = new List();
  // LISTA PARA AGREGAR A ELIMINAR
  List<userTransactions> selectedDelete = new List();
  //LISTA SELECCIONADOS
  List<userTransactions> uselected = new List();

  List<userTransactions> USER_GENERAL;

  // STREAM BUILDER
  BehaviorSubject<List<userTransactions>> _userListWoiner =
      BehaviorSubject<List<userTransactions>>();
  BehaviorSubject<List<userTransactions>> _userListReferido =
      BehaviorSubject<List<userTransactions>>();
  BehaviorSubject<List<userTransactions>> _userListSelected =
      BehaviorSubject<List<userTransactions>>();
  BehaviorSubject<List<userTransactions>> _userListSelectedToDelete =
      BehaviorSubject<List<userTransactions>>();
  BehaviorSubject<int> _isreload = BehaviorSubject<int>();
  BehaviorSubject<int> _filtroLista = BehaviorSubject<int>();

  // EVENTOS
  final _SelectedWoiner = StreamController<selectedWoiners>();
  final _delectedWoiner = StreamController<userTransactions>();
  final _adddelectedList = StreamController<String>();
  final _borrarSeleccionados = StreamController<int>();
  final _addReferido = StreamController<userTransactions>();
  final _filtrarUsertype = StreamController<filterTransaction>();
 
  final _reload = StreamController<int>();
  final _filterList = StreamController<int>();

  //GETTER Y SETTER

  StreamSink<selectedWoiners> get selectedWoiner => _SelectedWoiner.sink;
  StreamSink<filterTransaction> get moreUser => _filtrarUsertype.sink;
  StreamSink<userTransactions> get deleteWoiner => _delectedWoiner.sink;
  StreamSink<userTransactions> get agregarReferido => _addReferido.sink;
  StreamSink<String> get addDeleteList => _adddelectedList.sink;
  StreamSink<int> get deleteSelected => _borrarSeleccionados.sink;
  Stream<List<userTransactions>> get listwoiner => _userListWoiner.stream;
  StreamSink<List<userTransactions>> get listWoinerSink => _userListWoiner.sink;
  Stream<List<userTransactions>> get listReferido => _userListReferido.stream;
  StreamSink<List<userTransactions>> get listReferidoSink =>
      _userListReferido.sink;
  Stream<List<userTransactions>> get listSelected => _userListSelected.stream;
  StreamSink<List<userTransactions>> get listSelectedSink =>
      _userListSelected.sink;
  Stream<List<userTransactions>> get listSelectedToDelete =>
      _userListSelectedToDelete.stream;
  StreamSink<List<userTransactions>> get listSelectedToDeleteSink =>
      _userListSelectedToDelete.sink;
  StreamSink<filterTransaction> get busquedaStringUser => _stringbusqueda.sink;
  Stream<int> get isReload => _isreload.stream;
  StreamSink<int> get reloadUsers => _reload.sink;
  StreamSink<int> get insertList => _reload.sink;
  StreamSink<int> get addListaFiltro => _filterList.sink;
  Stream<int> get listaFiltro => _filtroLista.stream;
  int ocupado = 0;

  blocUserTransactions() {
    //userTransactionsList ul = new userTransactionsList();
    //print(ul.listasuarios.length);
    reload();

    //  print("INIT CARGADO=>" + uEm.length.toString());

    _userListSelected.sink.add(null);
    _userListReferido.sink.add(null);

    //ESCUCHADOR DE EVENTOS
    _SelectedWoiner.stream.listen(seleccionarWoiner);
    _delectedWoiner.stream.listen(deleteWoinWoiner);
    _adddelectedList.stream.listen(addListaSelectedToDelete);
    _borrarSeleccionados.stream.listen(borrarSeleccion);
    _addReferido.stream.listen(addReferido);
    _stringbusqueda.stream.listen(filtrarString);
    _reload.stream.listen(cargarUsers1);
    _filterList.stream.listen(obtenerListaFiltro);
    _filtrarUsertype.stream.listen(filterTypeUser);
  }

  filterTypeUser(filterTransaction filter) {
    List<userTransactions> list;
    if (filter.search == null) {
      filter.search = "";
    }

    if (filter.type == 2 || filter.type == 3) {
      print("TOTAL WOINER TYPE=>");
      list = USER_GENERAL
          .where((u) =>
              (u.type == filter.type) &&
              (u.codewoiner.contains(filter.search) ||
                  u.fullname.contains(filter.search) ||
                  u.email.contains(filter.search)))
          .toList();
      print("TOTAL WOINER TYPE=>" + list.length.toString());
    } else if (filter.type == 0) {
      print("RED");
      list = USER_GENERAL
          .where((u) =>
              u.red == 1 &&
              (u.codewoiner.contains(filter.search) ||
                  u.fullname.contains(filter.search) ||
                  u.email.contains(filter.search)))
          .toList();
      print("TOTAL RED=>" + list.length.toString());
    } else {
      print("WOINERS");

      list = USER_GENERAL
          .where((u) => (u.codewoiner.contains(filter.search) ||
              u.fullname.contains(filter.search) ||
              u.email.contains(filter.search)))
          .toList();
      print("TOTAL WOINERS=>" + list.length.toString());
    }

    _userListWoiner.sink.add(list);
  }

  obtenerListaFiltro(int lista) {
    _filtroLista.sink.add(lista);
  }

  cargarUsers1(int val) {
    _isreload.sink.add(val);
  }

 

 

  reload() async {
    uRed = new List();
    uwoiners = new List();
    uselected = new List();
    USER_GENERAL = new List();

    await cargarListaGnal();
    usersTransactionBloc.reloadUsers.add(1);

    _userListSelected.sink.add(null);
    _userListReferido.sink.add(null);
  }

  List<userTransactions> obtenerWoinerFilter(int type) {
    List<userTransactions> listaResult = new List<userTransactions>();
    if (type == 3 || type == 2) {
      for (userTransactions u in USER_GENERAL) {
        if (u.type == type && u.red == 1) {
          listaResult.add(u);
        }
      }
    } else if (type == 0) {
      for (userTransactions u in USER_GENERAL) {
        if (u.red == 1) {
          listaResult.add(u);
        }
      }
    } else {
      for (userTransactions u in USER_GENERAL) {
        if (u.red != 1) {
          listaResult.add(u);
        }
      }
    }

    return listaResult;
  }

// LISTADO INICIAL DE 20 TODAS LAS LISTAS


  borrarSeleccion(int borrar) {
    if (borrar == 1) {
      //print("A BORRAR=>" + selectedDelete.length.toString());
      for (userTransactions u in selectedDelete) {
        if (USER_GENERAL.contains(u)) {
          obtenerSeleccionado(u.codewoiner).selected = 0;
        }
      }
      for (userTransactions u in selectedDelete) {
        // print("CODE WOINER=>" + u.codewoiner.toString());
        if (listReferidoUSer.contains(u)) {
          listReferidoUSer.remove(u);
          print("BORRAR REFERIDO");
        }
      }
      selectedDelete.clear();
      actualizarSeleccionados();
    } else {
      for (userTransactions u in USER_GENERAL) {
        u.selected = 0;
      }
      listReferidoUSer.clear();
      selectedDelete.clear();
      actualizarSeleccionados();
    }

    //print("METODO BORRAR TODO");
  }

  seleccionarWoiner(selectedWoiners filter) async {
    int index = -1;
    for (int i = 0; i < uselected.length; i++) {
      if (uselected[i].codewoiner == filter.user.codewoiner) {
        index = i;
      }
    }
    if (index == -1) {
      uselected.add(filter.user);
    } else {
      print("REMOVER");
      uselected.removeAt(index);
    }
    _userListSelected.sink.add(uselected);
    await actualizarListas(filter.user);
  }

  actualizarListas(userTransactions user) async {
    for (userTransactions u1 in uRed) {
      if (u1.codewoiner == user.codewoiner) {
        u1.selected = user.selected;
      }
    }

    for (userTransactions u1 in uwoiners) {
      if (u1.codewoiner == user.codewoiner) {
        u1.selected = user.selected;
      }
    }
  }

  addReferido(userTransactions user) {
    List<userTransactions> lselected = new List<userTransactions>();
    user.codewoiner = id.toString();
    // print("METODO");
    print("ID=>" + user.codewoiner.toString());
    userTransactions enc;
    for (userTransactions u in listReferidoUSer) {
      if (u.codewoiner == user.codewoiner) {
        enc = u;
        break;
      }
    }
    if (enc == null) {
      listReferidoUSer.add(user);
      print("AGREGADO REFERIDO");
      id++;
    } else {
      listReferidoUSer.remove(user);
      print("REMOVER REFERIDO");
    }

    for (userTransactions u in USER_GENERAL) {
      if (u.selected == 1) {
        lselected.add(u);
      }
    }

    lselected.addAll(listReferidoUSer);

    //actualizarSeleccionados(uRed);

    _userListReferido.sink.add(listReferidoUSer);
    _userListSelected.sink.add(lselected);
  }

  addListaSelectedToDelete(String codewoiner) {
    userTransactions user = obtenerSeleccionado(codewoiner);
    if (user == null) {
      user = obtenerReferido(codewoiner);
    }
    if (selectedDelete.contains(user) == false) {
      selectedDelete.add(user);
      print("AGREGADO");
    } else {
      selectedDelete.remove(user);
      print("ELIMINADO");
    }
    _userListSelectedToDelete.sink.add(selectedDelete);
  }

  userTransactions obtenerSeleccionado(String code) {
    for (userTransactions u in USER_GENERAL) {
      if (u.codewoiner == code) {
        return u;
      }
    }
  }

  userTransactions obtenerReferido(String code) {
    for (userTransactions u in listReferidoUSer) {
      if (u.codewoiner == code) {
        return u;
      }
    }
  }

  deleteWoinWoiner(userTransactions user) {
    for (userTransactions u in USER_GENERAL) {
      if (u.codewoiner == user.codewoiner) {
        u.selected = 0;
        break;
      }
    }
    for (userTransactions u in listReferidoUSer) {
      if (u.codewoiner == user.codewoiner) {
        listReferidoUSer.remove(user);
        break;
      }
    }

    /* if (selectedDelete.isNotEmpty) {
      for (userTransactions u in selectedDelete) {
        if (u.codewoiner == user.codewoiner) {
          selectedDelete.remove(user);
        }
      }
    }*/
    //print("A ELIMINAR");
    actualizarSeleccionados();
  }

  actualizarSeleccionados() {
    List<userTransactions> lselected = new List();
    for (userTransactions u in USER_GENERAL) {
      if (u.selected == 1) {
        lselected.add(u);
      }
    }

    uselected.clear();
    uselected.addAll(lselected);
    uselected.addAll(listReferidoUSer);
    _userListSelected.sink.add(uselected);
    _userListReferido.sink.add(listReferidoUSer);
    _userListWoiner.sink.add(USER_GENERAL);
  }
}

final usersTransactionBloc = blocUserTransactions();*/
