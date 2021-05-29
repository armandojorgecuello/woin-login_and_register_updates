import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Persons/gender.dart';

class tipoAnuncio {
  String nombre;
  String tipo;
  Color color;
  IconData icono;

  tipoAnuncio(this.nombre, this.tipo, this.color, this.icono);
}

class lugarOfertaAnuncio {
  Country pais;
  Governorates depto;
  Cities city;

  lugarOfertaAnuncio({this.pais, this.city, this.depto});
}

class mercadoObjetivoClass {
  int edadDesde;
  int edadHasta;
  int todaEdad;
  genero gender;
  mercadoObjetivoClass(
      {this.edadDesde, this.edadHasta, this.gender, this.todaEdad});

  bool isTodaEdad() {
    if (todaEdad != null) {
      if (todaEdad > 0) {
        return true;
      }
    }

    return false;
  }

  bool tieneEdad() {
    if (edadDesde != null) {
      if (edadDesde > 0) {
        return true;
      }
    }
    return false;
  }
}

class infoOferta{
  String titulo;
  String descripcion;

  infoOferta({this.titulo,this.descripcion});
}

class precioOferta{
  double precio;
  double descuento;
  double vdescuento;
  double precioFinal;
  double regalo;
  double vregalo;
  int disponible;

  precioOferta({this.precio,this.descuento,this.vdescuento,this.precioFinal,this.regalo,this.vregalo,this.disponible});
}

class paquetePromocion{
  int codigo;
  double valor;
  DateTime timeI;
  DateTime timef;
  String timeString;
  int type;
  paquetePromocion({this.codigo,this.valor,this.timeI,this.timef,this.timeString,this.type});
}


class CaracteristicasAn{
  String img1;
  String img2;
  String img3;
  String img4;
  String img5;
  String img6;
  List<valorAtributos> valores;
  List<atributosProducto>detalleProduct;
  String nombreProduct;

  CaracteristicasAn({this.img1,this.img2,this.img3,this.img4,this.img5,this.img6,this.nombreProduct,this.detalleProduct,this.valores});

}

class atributosProducto{
  String titulo;
  atributosProducto({this.titulo});

}


class valorAtributos{
  int id;
  List<String> llaves;
  List<String> valores;
  int cantidad;
  valorAtributos({this.id,this.llaves,this.valores,this.cantidad});

  int obtenerIndex(String llave){
    for(int i=0;i<llaves.length;i++){
      if(llaves[i].toLowerCase().trim()==llave.toLowerCase().trim()){
        return i;
      }
    }
    return -1;
  }
}

class imgIndex{
  int index;
  String imagen;
  imgIndex({this.index,this.imagen});

}


class fechaAnuncio{
  DateTime fechadesde;
  DateTime fechaHasta;
  fechaAnuncio({this.fechadesde,this.fechaHasta});
}

class producto{

 int id;
 String name;
 String description;
 int subcategoryId;
 double price;
 int createdAt;
 int updatedAt;


 producto({this.name,this.description,this.price,this.subcategoryId,this.createdAt,this.updatedAt});
 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = new Map<String, dynamic>();
   data['name'] = this.name;
   data['description'] = this.description;
   data['subcategoryId'] = this.subcategoryId;
   data['price'] = this.price;
   data['createdAt'] = this.createdAt;
   data['updatedAt'] = this.updatedAt;

   return data;
 }

 producto.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   name = json['name'];
   description = json['description'];
   subcategoryId = json['subcategoryId'];
   price = json['price'];
   createdAt = json['createdAt'];
   updatedAt = json['updatedAt'];
 }

}



class keyValues{
  int id;
  String keys;
  String valores;
  int parent;
  int total;

  keyValues({this.id,this.keys,this.valores,this.parent,this.total});


 /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.keys!= null) {
      for(int i=0;i<keys.length;i++){
        data["${keys[i].toLowerCase()}"]=valores[i];
      }
    }




    data['parent'] = this.parent;
    data['total'] = this.total;
    return data;

}*/
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["key"] =this.keys;
    data["value"]=this.valores;
    data['total'] = this.total;
    data['parentId'] = this.parent;


    return data;
  }

  keyValues.fromJson(Map<String, dynamic> json) {
    keys = json['key'];
    valores = json['value'];
    total = json['total'];
    parent=json["parentId"];
  }


}


