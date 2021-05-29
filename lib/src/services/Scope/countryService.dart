import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:http/http.dart' as http;

import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/exceptions/api.dart';
import 'package:woin/src/helpers/LocationDevice.dart';
import 'package:woin/src/services/Repository/baseApi.dart';

class countryBloc extends BaseApiWoin {
  List<Country> _lcountries = new List();
  List<Cities> _lcity = new List();

  BehaviorSubject<List<Country>> _listCountries =
      BehaviorSubject<List<Country>>();
  BehaviorSubject<List<Cities>> _listCity = BehaviorSubject<List<Cities>>();
  final _filtercountry = StreamController<String>();
  final _filtercity = StreamController<String>();
  final _filtercityCountry = StreamController<int>();

  Stream<List<Country>> get CountryList => _listCountries.stream;
  StreamSink<String> get filterCountryB => _filtercountry.sink;

  Stream<List<Cities>> get CityList => _listCity.stream;
  StreamSink<String> get filtercityB => _filtercity.sink;

  StreamSink<int> get filtercityCountry => _filtercityCountry.sink;

  countryBloc() {
    init();
  }

  Future<List<Country>> httpGetCountries() async {
    var responseJson;

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    geoLocation gl = geoLocation();
    await gl.getCurentLocation();

    var params = {"woinLocation": gl.getLocation, "device": gl.getDevices};

    try {
      Uri uri = Uri.http(ruta, "/api/Country/0/10000");
      var response = await http.get(uri,
          headers: header, 
          //body: json.encode(params)
          );
      //print(response.body);
      if (response.statusCode == 200) {
        print("STATUS=200");
        var jsonr = json.decode(response.body);
        RespCountry resp = RespCountry.fromJson(jsonr);
        //print("length"+resp.lsubcategorias.length.toString());
        //print("RESP=>"+jsonr);
        responseJson = resp.countries;
      }
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  void init() async {
    httpGetCountries().then((countries) {
      _lcountries.addAll(countries);
      _filtercountry.stream.listen(_filtrarPaises);
      _listCountries.sink.add(_lcountries);
      _filtercityCountry.stream.listen(obtenerCiudadPais);
      _filtercity.stream.listen(_filtrarCities);
    });

    //_filtercountry.stream.listen(_filtrarPaises);
  }

  Future<int> obtenerCiudadPais(int idpais) async {
    var responseJson;
    int r = 0;
    //print("ACA");

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    geoLocation gl = geoLocation();
    await gl.getCurentLocation();

    var params = {"woinLocation": gl.getLocation, "device": gl.getDevices};
    _lcity.clear();
    _listCity.sink.add(null);

    try {
      Uri uri = Uri.http(ruta,"/api/Country/countryWithCity/" + idpais.toString() );
      var response = await http.get(
          uri,
          headers: header,
          //body: json.encode(params)
        );
      //print(response.body);
      if (response.statusCode == 200) {
        //print("STATUS=200");
        var jsonr = json.decode(response.body);
        respCityCountry resp = respCityCountry.fromJson(jsonr);
        //print("length"+resp.lsubcategorias.length.toString());
        responseJson = resp.entities[0].cities;
        _lcity.addAll(responseJson);
        _listCity.sink.add(responseJson);
        r = 1;
      }
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return r;
  }

  _filtrarPaises(String valor) {
    List<Country> ls = new List();
    if (valor != "") {
      for (Country s in _lcountries) {
        if (s.name.toLowerCase().contains(valor.trim().toLowerCase())) {
          ls.add(s);
        }
      }
    } else {
      ls.addAll(_lcountries);
    }

    _listCountries.sink.add(ls);
  }

  _filtrarCities(String valor) {
    List<Cities> ls = new List();
    if (valor != "") {
      for (Cities s in _lcity) {
        if (s.name.toLowerCase().contains(valor.trim().toLowerCase())) {
          ls.add(s);
        }
      }
    } else {
      ls.addAll(_lcity);
    }

    _listCity.sink.add(ls);
  }
}

final countryService = countryBloc();

class respCityCountry {
  String message;
  bool status;
  List<Entities> entities;
  int code;

  respCityCountry({this.message, this.status, this.entities, this.code});

  respCityCountry.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Entities>();
      json['entities'].forEach((v) {
        entities.add(new Entities.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.entities != null) {
      data['entities'] = this.entities.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Entities {
  int id;
  String name;
  int state;
  int createdAt;
  int updatedAt;
  List<Cities> cities;

  Entities(
      {this.id,
      this.name,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.cities});

  Entities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
