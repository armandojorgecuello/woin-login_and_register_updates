




import 'package:woin/src/entities/Transactions/transactionJsonPost.dart';

class TransctionsService{
  static final TransctionsService _transactionsService=TransctionsService._internal();
  List<transactionJson> _transaccionList;


  factory TransctionsService(){
    return _transactionsService;
  }

  TransctionsService._internal(){
    if(_transaccionList==null){
      _transaccionList=List();
    }
  }

  addTransaccion(transactionJson t){
    if(_transaccionList==null){
      _transaccionList=List();
    }
    _transaccionList.add(t);
  }

  nuevaTransaccion(){
    _transaccionList.clear();
  }

  List<transactionJson> get listaTransacciones=>_transaccionList;

}