class ItemMovementModel {
  List<Movimiento> _movimientos = [];

  ItemMovementModel.fromJson(List<dynamic> parsedJson) {
    _movimientos = parsedJson.map((m) => Movimiento.fromJson(m)).toList();
  }

  List<Movimiento> get movimientos => _movimientos;

  set movimientos(List<Movimiento> movts) => _movimientos = movts;
}

class Movimiento {
  int _id;
  String _fecha;
  String _tipo;
  String _accion;
  int _total;
  _Usuario _usuario;

  Movimiento.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _fecha = parsedJson['fecha'].toString();
    _tipo = parsedJson['tipo'];
    _accion = parsedJson['accion'];
    _total = parsedJson['total'];
    _usuario = _Usuario.fromJson(parsedJson['usuario']);
  }

  int get id => _id;
  String get fecha => _fecha;
  String get tipo => _tipo;
  String get accion => _accion;
  int get total => _total;
  _Usuario get usuario => _usuario;
}

class _Usuario {
  int _id;
  String _nombre;
  String _img;

  _Usuario.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _nombre = parsedJson['nombre'];
    _img = parsedJson['img'];
  }

  int get id => _id;
  String get nombre => _nombre;
  String get img => _img;
}
