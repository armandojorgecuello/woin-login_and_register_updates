import 'dart:async';
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/Products/ProductsModel.dart';


class CardListBloc{
  BehaviorSubject<List<Product>> _listProducts=BehaviorSubject<List<Product>>();
  final _megusta= StreamController<Product>();
  List<Product> _lproducts;
  //GET LIST PRODUCTS
  Stream<List<Product>> get ProductList=>_listProducts.stream;
  StreamSink <List<Product>> get productSink=> _listProducts.sink;

  //ME GUSTA PRODUCTO
  StreamSink<Product> get likeProduct=>_megusta.sink;

  CardListBloc(){
    init();
  }
  void init() async{
    
    Products listp= new Products();
    _lproducts= List<Product>();
    _lproducts.addAll(listp.listProducts);
    //print("TOTAL PRODUCTS"+listp.listProducts.length.toString());
    _megusta.stream.listen(_likeProducts);
   await _listProducts.sink.add(_lproducts);
  
  }

  void dispose(){
    _listProducts.close();
    _megusta.close();
  }

  _likeProducts(Product p){
    int likeActual=p.like;
    int likeAct= likeActual==0 ? 1 : 0;
    _lproducts[p.indx-1].like=likeAct;
    productSink.add(_lproducts);
  }
}

final porductBloc=CardListBloc();