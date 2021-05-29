
import 'package:flutter/cupertino.dart';

class Transaccion{
  String idMovimiento;
  String codeWoinerEmisor;
  String codeWoinerReceptor;
  double monto;
  int carteraOrigen;
  String ncarteraOrrigen;
  int carteraDestino;
  String ncarteraDestino;


  Transaccion({@required this.idMovimiento,@required this.codeWoinerEmisor,@required this.codeWoinerReceptor,@required this.monto,@required this.carteraOrigen,@required this.carteraDestino,this.ncarteraDestino,this.ncarteraOrrigen});


}