


import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/anuncio/AnuncioList.dart';
import 'package:woin/src/services/Anuncio/AnuncioList.dart';

class AnuncioListBloc{

  BehaviorSubject<List<AnuncioAd>>_lanuncio;
  List<AnuncioAd>anuncios;

  //EVENTO PARA FILTROS
  //StreamController<>

  Stream get listAnuncio=>_lanuncio.stream;
  StreamSink get listAnuncioSink=>_lanuncio.sink;


  AnuncioListBloc(){
    _lanuncio=BehaviorSubject<List<AnuncioAd>>();
    anuncios=List();
    cargarAnuncios();
  }


  Future<List<AnuncioAd>> cargarAnuncios() async{
    AnuncioListService as=AnuncioListService();
    anuncios=await as.listAnuncio("");
    _lanuncio.sink.add(anuncios);
    return anuncios;
  }

}


final AnuncioBloc=AnuncioListBloc();