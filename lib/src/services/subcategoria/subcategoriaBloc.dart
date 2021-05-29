

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:http/http.dart' as http;
import 'package:woin/src/entities/subcategorias/subcategorias.dart';
import 'package:woin/src/exceptions/api.dart';
import 'package:woin/src/services/Repository/baseApi.dart';

class subcategoriaBloc extends BaseApiWoin{

  List<Subcategoria> lsubcatGnal=new List();
  List<Subcategoria> lsubcat=new List();
  List<Subcategoria> lsubcatSon=new List();
  BehaviorSubject<List<Subcategoria>> _listSubcategorias=BehaviorSubject<List<Subcategoria>>();
  BehaviorSubject<List<Subcategoria>> _listSubcategoriasSon=BehaviorSubject<List<Subcategoria>>();
  BehaviorSubject<List<Subcategoria>> _listSubcategoriasGnal=BehaviorSubject<List<Subcategoria>>();

  final _selected= StreamController<Subcategoria>();
  final _filtersubcat= StreamController<String>();
  final _selectedParent=StreamController<Subcategoria>();


  Stream<List<Subcategoria>> get SubcategoriaList=>_listSubcategorias.stream;
  StreamSink <List<Subcategoria>> get subcategoriaSink=> _listSubcategorias.sink;

  Stream<List<Subcategoria>> get SubcategoriaListSon=>_listSubcategoriasSon.stream;
  StreamSink <List<Subcategoria>> get subcategoriaSonSink=> _listSubcategoriasSon.sink;

  Stream<List<Subcategoria>> get SubcategoriaListGnal=>_listSubcategoriasGnal.stream;
  StreamSink <List<Subcategoria>> get subcategoriaGnal=> _listSubcategoriasGnal.sink;

  //
  StreamSink<Subcategoria> get selectedSubcat=>_selected.sink;
  StreamSink<String> get filterSubcat => _filtersubcat.sink;
  StreamSink<Subcategoria> get seleccionarParent => _selectedParent.sink;

  subcategoriaBloc(){
    init();
  }

  Future<List<Subcategoria>> httpGetSubcategorias() async {
    var responseJson;

    final header= {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      Uri uri = Uri.http(ruta, "/api/WoinSubcategory/0/1000");
      var response = await http.get(uri, headers:header);
      if(response.statusCode==200){
        //print("STATUS=200");
        var jsonr= json.decode(response.body);
       respSubcategoria resp=respSubcategoria.fromJson(jsonr);
       //print("length"+resp.lsubcategorias.length.toString());
        responseJson= resp.lsubcategorias;
      }

    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  void init() async{

    httpGetSubcategorias().then((subcats){
      //print(subcats[0].id);
      lsubcatGnal=subcats;
      lsubcatSon=subcats.where((s)=>s.parentId!=null || s.parentId!=0).toList();
      lsubcat=subcats.where((s)=>s.parentId==null || s.parentId==0).toList();
      _selected.stream.listen(_selectedItem);
      _filtersubcat.stream.listen(_filtrarSubcategorias);
       _listSubcategorias.sink.add(lsubcat);
       _listSubcategoriasSon.sink.add(lsubcatSon);
       _listSubcategoriasGnal.sink.add(lsubcatGnal);
       _selectedParent.stream.listen(_selectedParentF);

    });


  }
  _selectedParentF(Subcategoria sc){
    lsubcatSon.clear();
    for(Subcategoria s in lsubcatGnal){
      if(s.parentId==sc.id){
        lsubcatSon.add(s);
      }
    }
    _listSubcategoriasSon.sink.add(lsubcatSon);

  }

  _selectedItem(Subcategoria sc){
   int selected=sc.selected;
   int selectAct= selected==0 ? 1 : 0;
    lsubcat[obtenerIndxSub(sc)].selected=selectAct;
    //print("SELECTED=>"+sc.selected.toString());
    subcategoriaSink.add(lsubcat);
  }


  int obtenerIndxSub(Subcategoria sc){
    for(int i=0;i<lsubcat.length;i++){
      if(lsubcat[i].id==sc.id){
        return i;
      }
    }
    return -1;
  }

  _filtrarSubcategorias(String valor){
    List<Subcategoria> ls = new List();
    if(valor==""){
      ls.addAll(lsubcatGnal);
    }else {

      for (Subcategoria s in lsubcatGnal) {
        if (s.name.toLowerCase().contains(valor.trim().toLowerCase())) {
          ls.add(s);
        }
      }
    }
    subcategoriaSonSink.add(ls.where((s)=>s.parentId!=null || s.parentId!=0).toList());
    subcategoriaSink.add(ls.where((s)=>s.parentId==null || s.parentId==0).toList());
    subcategoriaGnal.add(ls);
  }


}

final subcategorias =subcategoriaBloc();