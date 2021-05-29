
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/Movements/repository.dart';
import 'package:woin/src/entities/Transactions/listTransactions.dart';
//import 'package:woin/src/entities/Movements/repository.dart';




class MovementBloc {
  final _repository = Repository();
  final _movementFetcher = BehaviorSubject<transactionList>();

 Stream get allMovements => _movementFetcher.stream;

  fetchAllMovements() async {
    transactionList itemModel = await _repository.fetchAllMovements();
    _movementFetcher.sink.add(itemModel);
  }

  fetchAllMovementsByAction(String accion) async {
    transactionList itemModel = await _repository.fetchAllMovements();

   /* itemModel.movimientos =
        itemModel.movimientos.where((m) => m.accion == accion).toList();*/

    _movementFetcher.sink.add(itemModel);
  }

  fetchAllMovementsByActionDateRange(
      String accion, DateTime startDate, DateTime endDate) async {
    transactionList itemModel = await _repository.fetchAllMovements();

    /*itemModel.movimientos = itemModel.movimientos
        .where((m) =>
            m.accion == accion &&
            startDate.isBefore(DateTime.parse(m.fecha)) &&
            endDate.isAfter(DateTime.parse(m.fecha)))
        .toList();*/

    _movementFetcher.sink.add(itemModel);
  }

  fetchAllMovementsByType(String type) async {
    transactionList itemModel = await _repository.fetchAllMovements();

    /*itemModel.movimientos =
        itemModel.movimientos.where((m) => m.tipo == type).toList();*/

    _movementFetcher.sink.add(itemModel);
  }

  fetchAllMovementsByTypeAction(String type, String action) async {
    transactionList itemModel = await _repository.fetchAllMovements();

    /*itemModel.movimientos = itemModel.movimientos
        .where((m) => m.tipo == type && m.accion == action)
        .toList();*/

    _movementFetcher.sink.add(itemModel);
  }

  fetchAllMovementsByTypeActionDateRange(
      String type, String action, DateTime startDate, DateTime endDate) async {
    transactionList itemModel = await _repository.fetchAllMovements();

    /*itemModel.movimientos = itemModel.movimientos
        .where((m) =>
            m.tipo == type &&
            m.accion == action &&
            startDate.isBefore(DateTime.parse(m.fecha)) &&
            endDate.isAfter(DateTime.parse(m.fecha)))
        .toList();*/

    _movementFetcher.sink.add(itemModel);
  }

  fetchAllMovementsByTypeDateRange(
      String type, DateTime startDate, DateTime endDate) async {
    transactionList itemModel = await _repository.fetchAllMovements();

   /* itemModel.movimientos = itemModel.movimientos
        .where((m) =>
            m.tipo == type &&
            startDate.isBefore(DateTime.parse(m.fecha)) &&
            endDate.isAfter(DateTime.parse(m.fecha)))
        .toList();*/

    _movementFetcher.sink.add(itemModel);
  }

  fetchMovementsByDateRange(DateTime startDate, DateTime endDate) async {
    transactionList itemModel = await _repository.fetchAllMovements();

    /*itemModel.movimientos = itemModel.movimientos
        .where((m) =>
            startDate.isBefore(DateTime.parse(m.fecha)) &&
            endDate.isAfter(DateTime.parse(m.fecha)))
        .toList();*/

    _movementFetcher.sink.add(itemModel);
  }

  dispose() {
    _movementFetcher.close();
  }
}

final movementsBloc = MovementBloc();
