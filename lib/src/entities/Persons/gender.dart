class genero {
  int id;
  String name;

  genero({this.id, this.name});
}

class listGender {
  List<genero> listagenero;

  listGender() {
    listagenero = new List();
  }

  Future<List<genero>> obtenerGeneros() async {
    genero g1 = new genero(id: 1, name: "Masculino");
    genero g2 = new genero(id: 2, name: "Femenino");
    genero g3 = new genero(id: 3, name: "Otro");

    listagenero.add(g1);
    listagenero.add(g2);
    listagenero.add(g3);

    return listagenero;
  }
}
