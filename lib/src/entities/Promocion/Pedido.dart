import 'package:flutter/cupertino.dart';

class Pedido{
  int id;
  String nombreProducto;
  String modelo;
  String marca;
  int cantidad;
  Color color;
  String serie;
  double costo_domicilio;

  Pedido({this.id,this.nombreProducto,this.color,this.cantidad,this.modelo,this.marca,this.costo_domicilio,this.serie});

}