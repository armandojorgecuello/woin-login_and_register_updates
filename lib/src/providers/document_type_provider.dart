import 'package:flutter/foundation.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Persons/typeDocument.dart';

class DoumentTypeProvider with ChangeNotifier {
  
  typeDocument _typeDoc;
  typeDocument get typeDoc => _typeDoc;
  set typeDoc(typeDocument td){
    _typeDoc = td;
    notifyListeners();
  }

  Cities _city;
  Cities get getCity => _city;
  set getCity(Cities ct){
    _city = ct;
    notifyListeners();
  }
  
  Country _country;
  Country get getCountry => _country;
  set getCountry(Country countr){
    _country = countr;
    notifyListeners();
  }

}