import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;  
  bool get getIsDarkMode => this._isDarkMode;
  void changeDarkMode(isDarkMode) {  
    _isDarkMode = isDarkMode;  
    notifyListeners();
  }
}