


import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/Cartera/Cartera.dart';
import 'package:woin/src/entities/Cartera/Franquicia.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';

class carteraService{

  /*
  * TIPO 3 = EMWOIN
  * TIPO 2 =CLIWOIN
  * TIPO 1 =DINERO
  * TIPO 0 =TARJETA
  * */
  BehaviorSubject<List<Cartera>> _listCarteras;
  BehaviorSubject<List<Cartera>> _listCarterasSelected;
  StreamController<Cartera>_addCartera;
  StreamController<Cartera>_selectionCartera;
  List<Cartera> lcarteras;

  //FRANQUICIAS
  List<Franquicia> lfranquicia;
  BehaviorSubject<List<Franquicia>> _listFranquicia;
  StreamController<Franquicia>_selectionFranquicia;

  //GETTER Y SETTER

  Stream<List<Cartera>> get CarteraList=>_listCarteras.stream;
  Stream<List<Cartera>> get CarteraListSelected=>_listCarterasSelected.stream;
  StreamSink<List<Cartera>> get carterasUSer => _listCarteras.sink;
  StreamSink<Cartera> get addCarteraService=>_addCartera.sink;
  StreamSink<Cartera> get selectedCarter=>_selectionCartera.sink;

  Stream<List<Franquicia>> get FranquiciaList=>_listFranquicia.stream;
  StreamSink<Franquicia> get selectedFranquicia=>_selectionFranquicia.sink;



  carteraService(){
    lcarteras= List();
    lfranquicia=List();
    _listCarteras=BehaviorSubject<List<Cartera>>();
    _listCarterasSelected=BehaviorSubject<List<Cartera>>();
    _listFranquicia=BehaviorSubject<List<Franquicia>>();
    _addCartera=StreamController<Cartera>();
    _selectionCartera=StreamController<Cartera>();
    _selectionFranquicia=StreamController<Franquicia>();
    _addCartera.stream.listen(addCartera);
    _selectionCartera.stream.listen((selectedCartera));
    _selectionFranquicia.stream.listen(selectFranquicia);
    crearCarteras();
    crearFranquicias();
  }


  List<Cartera> carteraSelected(){
    List<Cartera> carterasSelected=List();
    for(Cartera car in lcarteras){
      if(car.selected==1){

        carterasSelected.add(car);
      }
    }
    //_listCarterasSelected.sink.add(carterasSelected);
   return carterasSelected;

  }



  void selectFranquicia(Franquicia f){
    for(Franquicia fr in lfranquicia){
      if(fr.codigo==f.codigo){
        fr.selected=fr.selected==1?0:1;
      }

      if(fr.codigo!=f.codigo){
        fr.selected=0;
      }
    }
    _listFranquicia.sink.add(lfranquicia);
  }

  void selectedCartera(Cartera c){
    for(Cartera car in lcarteras){
      if(car.type==c.type){
        car.selected=car.selected==1?0:1;
        if(car.selected==1){
          car.valortransferir=0;
          car.montofinal=0;
        }
      }
    }
    _listCarteras.sink.add(lcarteras);


  }

  void crearCarteras(){
    userdetalle sesion = new userdetalle();
    if(sesion.isTipoUser(2)){
      Cartera c= new Cartera(type: 2, name: "Cliwoin",selected:1,codigo: sesion.obtenerdetalle(2).codewoiner,fullname: "Jaime Daniel Barros",montoTransferencia: 0,saldoDisponible: sesion.obtenerdetalle(2).balance,valortransferir: 0,montofinal: 0);
      lcarteras.add(c);
    }
    if(sesion.isTipoUser(3)){
      Cartera c= new Cartera(type: 3, name: "Emwoin",selected:1,codigo:  sesion.obtenerdetalle(3).codewoiner,fullname: "Jaime Daniel Barros",montoTransferencia: 0,saldoDisponible: sesion.obtenerdetalle(3).balance,valortransferir: 0,montofinal: 0);
      lcarteras.add(c);
    }

    //EFECTIVO
    Cartera c= new Cartera(type: 1, name: "Dinero", selected:1,codigo: "",fullname: "",montoTransferencia: 0,saldoDisponible: 0,nombreBanco: "EFECTIVO",valortransferir: 0,montofinal: 0);
    //lcarteras.add(c);

    //TARJETAS
    Cartera tarjeta=new Cartera(type: 0, name: "Banco",selected:1,fullname: "Jaime Daniel Barros",montoTransferencia: 0,urlFranquicia: "https://i.pinimg.com/originals/06/02/28/060228fa54080f38ee2fd8ff45a4da8e.jpg",nombreBanco: "DAVIVIENDA",valortransferir: 0,montofinal: 0);
    //lcarteras.add(tarjeta);
    _listCarteras.sink.add(lcarteras);


  }

  void crearFranquicias(){

    Franquicia f= new Franquicia(codigo: 1, nombre: "Visa", urlImg: "https://i.pinimg.com/originals/06/02/28/060228fa54080f38ee2fd8ff45a4da8e.jpg", selected: 0);
    Franquicia f1= new Franquicia(codigo: 2, nombre: "Maestro", urlImg: "https://i0.wp.com/www.ebizlatam.com/wp-content/uploads/2017/03/Maestro-Tarjeta.jpg", selected: 0);
    Franquicia f2= new Franquicia(codigo: 3, nombre: "Mastercard", urlImg: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png", selected: 0);
    Franquicia f3= new Franquicia(codigo: 4, nombre: "Dinners Club", urlImg: "https://1000marcas.net/wp-content/uploads/2020/07/Diners-Club-International-logo.png", selected: 0);
    Franquicia f4= new Franquicia(codigo: 5, nombre: "American Express", urlImg: "https://brandemia.org/sites/default/files/inline/images/american_express_logo_wordmark_detail.png", selected: 0);
    lfranquicia.add(f);
    lfranquicia.add(f1);
    lfranquicia.add(f2);
    lfranquicia.add(f3);
    lfranquicia.add(f4);

    _listFranquicia.sink.add(lfranquicia);
   // print("FRANQUCIA LENGTH=>"+lfranquicia.length.toString());


  }

  addCartera(Cartera c){
    int idx=obtenerCartera(c);
    if(idx==-1){
      lcarteras.add(c);
    }else{
      lcarteras.removeAt(idx);
    }

    _listCarteras.sink.add(lcarteras);

  }

  int obtenerCartera(Cartera c){
    int index=-1;
    for(int i=0; i<lcarteras.length;i++){
      if(lcarteras[i].type==c.type){
        index=i;
        break;
      }
    }
    return index;
  }

  void dispose(){
    _addCartera.close();
    _listCarteras.close();
  }


}

final CarteraService=carteraService();