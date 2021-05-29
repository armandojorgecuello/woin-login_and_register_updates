


import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/services/Vehicles/vehicles.dart';
import 'package:woin/src/services/Vehicles/vehiclesService.dart';
import 'package:woin/src/services/preguntaSeguridad/preguntaSeguridad.dart';


class vehiclesBloc{
  List<Vehicle> _lvehicle=new List();
  BehaviorSubject<List<Vehicle>> _lvehicles=BehaviorSubject<List<Vehicle>>();

  Stream<List<Vehicle>> get vehicelsList=>_lvehicles.stream;
  StreamSink <List<Vehicle>> get vehiclesListSink=> _lvehicles.sink;


  vehiclesBloc(){
    init();
  }


  init()async{
  vehiclesService vs= new vehiclesService();

  vs.httpGetVehicles().then((vehicles){

    _lvehicle.addAll(vehicles);
    _lvehicle.add(new Vehicle(id: 100,name: "Ninguno"));
    _lvehicles.sink.add(_lvehicle);

  });







  }

}

final  vehiclesBloC =vehiclesBloc();