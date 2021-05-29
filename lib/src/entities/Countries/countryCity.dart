import 'package:woin/src/entities/Countries/Country.dart';

class countryCity {
  Country _country;
  Cities _city;
  int _val;

  set setCountry(Country pais) {
    _country = pais;
  }

  set setCity(Cities city) {
    _city = city;
  }

  set setValido(int val) {
    _val = val;
  }

  Cities get getCity => _city;
  Country get getcountry => _country;
  int get ubicacionValida => _val;
  countryCity();
}
