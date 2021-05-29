/*import 'package:flutter/material.dart';

class KeyboardProvider with ChangeNotifier {
  String _priceWoin = '0', _priceCash = '0', _priceGift = '0';
  List<String> _pin = ['_','_','_','_'];
  int _type = 1, _hubicacionPin=0, percentageGift = 0;
  BoxShadow _shadow = BoxShadow(color: Colors.transparent);
  TextEditingController _controllerPriceWoin = new TextEditingController();
  TextEditingController _controllerPriceCash = new TextEditingController();
  TextEditingController _controllerPriceGift = new TextEditingController();
  bool _huella = false;

  TextEditingController get controllerPriceWoin => this._controllerPriceWoin;
  TextEditingController get controllerPriceCash => this._controllerPriceCash;
  TextEditingController get controllerPriceGift => this._controllerPriceGift;
  String get getPriceWoin => this._priceWoin;
  String get getPriceCash => this._priceCash;
  String get getPriceGift => this._priceGift;
  int get getType => this._type;
  BoxShadow get getShadow => this._shadow;
  List<String> get pin => this._pin;
  bool get huella => this._huella;
  // set setType(int type) => _type = type;

  
  void clearPrice(){
    switch (this._type) {
      case 1:
        this._priceWoin = '0';
        break;
      case 2:
        this._priceCash = '0';
        break;
      case 2:
        this._priceGift = '0';
        break;
      default:
    }
    notifyListeners();
  }
  void setType(type) {
    _type=type;
    notifyListeners();
  }

  void setPercentageGift(int gift){
    this.percentageGift = gift;
    this._priceGift = (double.parse(this._priceWoin)*this.percentageGift/100).toString();
    this._controllerPriceGift.text = this._priceGift;
    notifyListeners();
  }
  void changeControllerPrices(String price){
    switch (getType) {
      case 1:this._controllerPriceWoin.text = price; break;
      case 2:this._controllerPriceCash.text = price; break;
      case 3:this._controllerPriceGift.text = price; break;
      default:
    }
    notifyListeners();
  }
  void clearControllerPrices(){
    this._controllerPriceWoin.text = '';
    this._controllerPriceCash.text = '';
    this._controllerPriceGift.text = '';
    notifyListeners();
  }
  // set setShadow(BoxShadow shadow) => this._shadow = shadow;
  void changePrices(String price, {bool gift}){
    switch (this._type) {
      case 1:
        this._priceWoin = price;
        if(gift){
          this._priceGift = (double.parse(price)*this.percentageGift/100).toString();
          this._controllerPriceGift.text = this._priceGift;
        }
        break;
      case 2:
        this._priceCash = price;
        break;
      case 3:
        this._priceGift = price;
        break;
      default:
    }
    print(' gift ${this._priceGift}');
    notifyListeners();
  }
  void getNumbers(String number){
    if (_hubicacionPin < 4) {
      print(_hubicacionPin);
      _pin[_hubicacionPin] = number;
      _hubicacionPin++;
    }
    // _pin = _pin[0]=='_'?number:'_';
    notifyListeners();
  }
  void clearNumber(){
    if (_hubicacionPin > 0) {
      _hubicacionPin--;
      _pin[_hubicacionPin] = '_'; 
    }
    notifyListeners();
  }

  void clearAll(){
    this._pin = ['_','_','_','_'];
    _hubicacionPin = 0;
    print(this._pin);
    notifyListeners();
  }

  void changeShadow(){
    if (_type != 0) {
      if (_type == 2) {
        this._shadow = BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.grey
                    );
      } else {
        this._shadow = BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.blue
                    );
      }
    } else {
      this._shadow = BoxShadow(color: Colors.transparent);
    }
    notifyListeners();
  }

  void changeHuella(bool huella){
    this._huella = huella;
    notifyListeners();
  }

  void clearPrices(){
    this._priceCash = '0';
    this._priceGift = '0';
    this._priceWoin = '0';
  }
}*/
