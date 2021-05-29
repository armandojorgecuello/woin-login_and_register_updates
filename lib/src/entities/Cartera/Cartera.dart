

import 'package:flutter/cupertino.dart';

class Cartera{
  int type;
  String name;
  double saldoDisponible;
  double montoTransferencia;
  String codigo;
  String fullname;
  String urlFranquicia;
  String nombreBanco;
  int selected;
  double valortransferir;
  double montofinal;


  Cartera({@required this.type,@required this.name, @required this.selected,this.saldoDisponible,this.montoTransferencia,this.codigo,this.fullname,this.urlFranquicia,this.nombreBanco,this.valortransferir,this.montofinal});

}