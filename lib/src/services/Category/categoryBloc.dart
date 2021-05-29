import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/services/Category/categoryService.dart';

class categoryBloc {
  List<Category> _lcategories = new List();
  BehaviorSubject<List<Category>> _listCategories = BehaviorSubject<List<Category>>();

  Stream<List<Category>> get categoriesList => _listCategories.stream;
  StreamSink<List<Category>> get categoriesListSink => _listCategories.sink;

  categoryBloc() {
    init();
  }

  init() async {
    print("INIT BLOC");
    categoryService cs = new categoryService();
    geoLocation gl = new geoLocation();
    await gl.obtenerGeolocalizacion();

    cs.httpGetCategories(gl.getLocation, gl.getDevices).then((categories) {
      _lcategories.addAll(categories);
      _listCategories.sink.add(_lcategories);
    });
  }
}

final categoriesbloc = categoryBloc();
