
import 'package:woin/src/entities/Movements/item_movement_model.dart';
import 'package:woin/src/entities/Movements/movement_api_provider.dart';
import 'package:woin/src/entities/Transactions/listTransactions.dart';

class Repository {
  final movementApiProvider = MovementApiProvider();
  //final pedidoApiProvider = PedidoApiProvider();

  Future<transactionList> fetchAllMovements() =>
      movementApiProvider.fetchMovementList();

/*  Future<ItemPayPedidoModel> fetchAllPedidos() =>
      pedidoApiProvider.fetchPedidosList();*/
}
