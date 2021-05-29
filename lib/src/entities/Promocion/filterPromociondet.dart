

import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Persons/gender.dart';

class filterPromociondet{

  //OBTENENER VALORES Y SETEAR CAMPOS AL CAMBIAR DE ESTADO EL COMPONENTE DE FILTRO
  Country pais;
  Governorates depto;
  Cities city;
  String pd;
  String ph;
  String rd;
  String rh;
  String dd;
  String dh;
  String ed;
  String eh;
  genero sexo;


  //CAMPOS PARA CREAR QUERYS
  String querypais;
  String querydepto;
  String queryciudad;
  String queryPrecio;
  String queryregalo;
  String queryDescuento;
  String queryEdad;
  String querysexo;

  filterPromociondet({this.querypais,this.querydepto,this.queryciudad,this.queryDescuento,this.queryEdad,this.queryPrecio,this.queryregalo,this.querysexo,
  this.pais,this.depto,this.city,this.pd,this.ph,this.rd,this.rh,this.dd,this.dh,this.ed,this.eh,this.sexo});
  String obtenerQueryFinal(){
    String query=this.querypais!=""?this.querypais:" ";
    query+=this.querypais!="" && (this.querydepto!="" || this.queryciudad!="" || this.queryPrecio!="" || this.queryregalo!="" || this.queryDescuento!="" || this.queryEdad!="" || this.querysexo!="")?" AND ":"";
    query+=this.querydepto!=""?this.querydepto:" ";
    query+=this.querydepto!="" && (this.queryciudad!="" || this.queryPrecio!="" || this.queryregalo!="" || this.queryDescuento!="" || this.queryEdad!="" || this.querysexo!="")?" AND ":"";
    query+=this.queryciudad!=""?this.queryciudad:" ";
    query+=this.queryciudad!="" && (this.queryPrecio!="" || this.queryregalo!="" || this.queryDescuento!="" || this.queryEdad!="" || this.querysexo!="")?" AND ":"";
    query+=this.queryPrecio!=""?this.queryPrecio:" ";
    query+=this.queryPrecio!="" && (this.queryregalo!="" || this.queryDescuento!="" || this.queryEdad!="" || this.querysexo!="")?" AND ":"";
    query+=this.queryregalo!=""?this.queryregalo:" ";
    query+=this.queryregalo!="" && (this.queryDescuento!="" || this.queryEdad!="" || this.querysexo!="")?" AND ":"";
    query+=this.queryDescuento!=""?this.queryDescuento:" ";
    query+=this.queryDescuento!="" && ( this.queryEdad!="" || this.querysexo!="")?" AND ":"";
    query+=this.queryEdad!=""?this.queryEdad:" ";
    query+=this.queryEdad!="" && this.querysexo!=""?" AND ":"";
    query+=this.querysexo!=""?this.querysexo:" ";
    return query;
  }
  int totalfilters(){
    int cont=0;
    if(querypais!=""){
      cont++;
    }
    if(querydepto!=""){
      cont++;
    }
    if(queryciudad!=""){
      cont++;
    }
    if(queryPrecio!=""){
      cont++;
    }
    if(queryregalo!=""){
      cont++;
    }
    if(queryDescuento!=""){
      cont++;
    }
    if(queryEdad!=""){
      cont++;
    }
    if(querysexo!=""){
      cont++;
    }
    return cont;

  }
}