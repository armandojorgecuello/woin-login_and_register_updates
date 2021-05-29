class filterTransaction {
  int pageDesde;
  int pageHasta;
  String search;
  int type;

  filterTransaction({this.pageDesde, this.pageHasta, this.search, this.type});
}

class selectedWoiners {
  userTransactions user;
  int type;

  selectedWoiners({this.user, this.type});
}

class userTransactions {
  String fullname;
  String email;
  String telefono;
  int type;
  int woinerId;
  String tipoStr;
  String indicativo;
  String imagen;
  String codewoiner;
  double puntos;
  double compras;
  double ventas;
  int selected;
  int red;
  String pais;
  String ciudad;
  int codpais;
  int codciudad;
  String cedula;
  String ncuenta;
  String nota;
  double calificacion;
  double montopuntoOld;
  double montocompraOld;
  int valorFijo;
  int efecfijo;

  userTransactions(
      {this.fullname,
      this.email,
      this.tipoStr,
      this.telefono,
      this.type,
      this.imagen,
      this.codewoiner,
      this.puntos,
      this.compras,
      this.ventas,
      this.selected,
      this.woinerId,
      this.red,
      this.ciudad,
      this.pais,
      this.codciudad,
      this.codpais,
      this.indicativo,
      this.cedula,
      this.ncuenta,
        this.efecfijo,
        this.valorFijo,
        this.calificacion,
        this.montocompraOld,
        this.montopuntoOld,
        this.nota,
      }){


  }

  userTransactions.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullname = json['fullName'];
    telefono = json['phone'];
    indicativo = json['indicative'];
    imagen = json['image'];
    type = json['type'];
    tipoStr = json['typeName'];
    codewoiner = json['codeWoiner'];
    woinerId = json['woinerId'];
    ciudad = json['city'];
    pais = json['country'];
    codpais = json['countryId'];
    codciudad = json['cityId'];
    cedula = json['documentNumber'];
    indicativo = json['indicative'];
    ncuenta = json['walletAccount'];
    selected = 0;
    puntos = 0;
    ventas = 0;
    compras = 0;
    red = 0;
    calificacion = 0;
    nota = "";
    montocompraOld=0;
    montopuntoOld=0;
    valorFijo=0;
    efecfijo=0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullName'] = this.fullname;
    data['phone'] = this.telefono;
    data['indicative'] = this.indicativo;
    data['image'] = this.imagen;
    data['type'] = this.type;
    data['typeName'] = this.tipoStr;
    data['codeWoiner'] = this.codewoiner;
    data['woinerId'] = this.woinerId;

    return data;
  }
}

class respUserTransacction {
  String message;
  bool status;
  List<userTransactions> usuarios;
  int code;

  respUserTransacction({this.message, this.status, this.usuarios, this.code});

  respUserTransacction.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      usuarios = new List<userTransactions>();
      json['entities'].forEach((v) {
        usuarios.add(new userTransactions.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.usuarios != null) {
      data['entities'] = this.usuarios.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

/*class userTransactionsList {
  List<userTransactions> listasuarios;
  userTransactionsList() {
    listasuarios = new List();
    userTransactions u = new userTransactions(
        fullname: "Jaime Daniel Barros Mendoza",
        email: "jaime@gmail.com",
        telefono: "3015662999",
        type: 2,
        imagen: "",
        codewoiner: 3568,
        compras: 0,
        puntos: 0,
        selected: 0);
    userTransactions u1 = new userTransactions(
        fullname: "Laurieth Linares Caña",
        email: "chicacancer@gmail.com",
        telefono: "3015662888",
        type: 3,
        imagen: "",
        codewoiner: 3569,
        compras: 0,
        puntos: 0,
        selected: 0);
    userTransactions u2 = new userTransactions(
        fullname: "Maria Daniela Pinto Barros",
        email: "daniela2504@gmail.com",
        telefono: "3015662777",
        type: 2,
        imagen: "",
        codewoiner: 3570,
        compras: 0,
        puntos: 0,
        selected: 0);
    userTransactions u3 = new userTransactions(
        fullname: "Luis Fabian Pinto Barros",
        email: "luisfa1108@gmail.com",
        telefono: "3015662666",
        type: 3,
        imagen: "",
        codewoiner: 3571,
        compras: 0,
        puntos: 0,
        selected: 0);
    userTransactions u4 = new userTransactions(
        fullname: "Maria Adela Mendoza Plata",
        email: "mademepla2704@gmail.com",
        telefono: "3015662555",
        type: 3,
        imagen: "",
        codewoiner: 3572,
        compras: 0,
        puntos: 0,
        selected: 0);
    listasuarios.add(u);
    listasuarios.add(u1);
    listasuarios.add(u2);
    listasuarios.add(u3);
    listasuarios.add(u4);
  }
}*/

class MontoTransactions {
  double montopuntosAll;
  double montoefecAll;
  double efbase;
  double puntobase;
  double efectivo;
  double puntos;
  int opcion;
  double venta;
  double porcentaje;
  double saldoDisponible;

  MontoTransactions(
      {this.efectivo,
      this.puntos,
      this.opcion,
      this.efbase,
      this.puntobase,
      this.porcentaje,
      this.saldoDisponible,
      this.venta});
}

class montoUsers {
  List<userTransactions> users;
  MontoTransactions monto;
  montoUsers({this.users, this.monto});
}
