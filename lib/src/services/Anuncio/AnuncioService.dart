

import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';


class AnuncioService {



  List<paquetePromocion> paquetes;
  BehaviorSubject<List<paquetePromocion>> _paquetesList;

  //EVENTS
  StreamController<int> _typePaquete;

  //GETTER AND SETTER
  Stream get listPaquest=>_paquetesList.stream;
  StreamSink get listPaquetesSink=>_paquetesList.sink;
  StreamSink get tipoPaquete=>_typePaquete.sink;

  AnuncioService(){

   paquetes=List();
    _paquetesList=BehaviorSubject<List<paquetePromocion>>();
    _typePaquete=StreamController();
    _typePaquete.stream.listen(filterType);
    cargarPaquetes();

  }

  void filterType(int type){
    List<paquetePromocion> lr=List();
    if(type==1){
      for(paquetePromocion p in paquetes){
        if(p.type==1){
          lr.add(p);
        }
      }
    }else if(type==2){
      for(paquetePromocion p in paquetes){
        if(p.type==2){
          lr.add(p);
        }
      }
    }else{
      lr.addAll(paquetes);
    }

    _paquetesList.sink.add(lr);
  }


  void cargarPaquetes(){
    paquetePromocion p1= paquetePromocion(codigo: 1,timeI: DateTime(2020,12,29),timef: DateTime(2021,1,15),valor: 25000);
    paquetePromocion p2= paquetePromocion(codigo: 2,timeI: DateTime(2020,12,29),timef: DateTime(2021,2,15),valor: 45000);
    paquetePromocion p3= paquetePromocion(codigo: 3,timeI: DateTime(2020,12,29),timef: DateTime(2021,3,15),valor: 95000);
    paquetePromocion p4= paquetePromocion(codigo: 4,timeI: DateTime(2020,12,29),timef: DateTime(2021,4,15),valor: 300000);
    paquetePromocion p5= paquetePromocion(codigo: 5,timeI: DateTime(2020,12,29),timef: DateTime(2021,5,15),valor: 110000);
    paquetePromocion p6= paquetePromocion(codigo: 6,timeI: DateTime(2020,12,29),timef: DateTime(2021,6,15),valor: 150000);
    paquetePromocion p7= paquetePromocion(codigo: 7,timeI: DateTime(2020,12,29),timef: DateTime(2021,7,15),valor: 105000);
    paquetePromocion p8= paquetePromocion(codigo: 8,timeI: DateTime(2020,12,29),timef: DateTime(2021,8,15),valor: 190000);
    paquetePromocion p9= paquetePromocion(codigo: 9,timeI: DateTime(2020,12,29),timef: DateTime(2021,9,15),valor: 17000);
    paquetePromocion p10= paquetePromocion(codigo: 10,timeI: DateTime(2020,12,29),timef: DateTime(2021,10,15),valor: 29000);
    paquetePromocion p11= paquetePromocion(codigo: 11,timeI: DateTime(2020,12,29),timef: DateTime(2021,11,15),valor: 5500);
    paquetePromocion p12= paquetePromocion(codigo: 12,timeI: DateTime(2020,12,29),timef: DateTime(2022,11,15),valor: 1200000);
    paquetes.add(p1);
    paquetes.add(p2);
    paquetes.add(p3);
    paquetes.add(p4);
    paquetes.add(p5);
    paquetes.add(p6);
    paquetes.add(p7);
    paquetes.add(p8);
    paquetes.add(p9);
    paquetes.add(p10);
    paquetes.add(p11);
    paquetes.add(p12);
    //OBTENER DIFERENCIA DE FECHAS
    for(paquetePromocion p in paquetes){
     int days= p.timef.difference(p.timeI).inDays;
      if(days>30){
        p.type=2;
        p.timeString=(days/30).floor().toString();
      }else{
        p.type=1;
        p.timeString=days.toString();
      }

    }
    _paquetesList.sink.add(paquetes);
  }

}


final anuncioService= AnuncioService();