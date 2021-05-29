

import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/Promocion/Pedido.dart';

class pedidoBloc{
List<Pedido> lpedidos;
BehaviorSubject<List<Pedido>> _listPedido=BehaviorSubject<List<Pedido>>();
final _eventAddPedido= StreamController<Pedido>();
//GETTER Y SETTER
  Stream<List<Pedido>> get PedidoStreamList => _listPedido.stream;
  StreamSink<List<Pedido>> get PedidoListSink => _listPedido.sink;
  StreamSink<Pedido> get addPedidoSink => _eventAddPedido.sink;


  pedidoBloc(){
     lpedidos= List();
    _eventAddPedido.stream.listen(addPedido);
  }

  addPedido(Pedido p){
    if(lpedidos.length==0){
      lpedidos.add(p);
    }else{
      int idx=-1;
      for(int i=0;i<lpedidos.length;i++){
        if(lpedidos[i].id==p.id){
          idx=i;
        }
      }
      if(idx>-1){
        lpedidos.removeAt(idx);
      }else{
        lpedidos.add(p);
      }
    }
    _listPedido.sink.add(lpedidos);

  }

}
final pedidosBloc=pedidoBloc();