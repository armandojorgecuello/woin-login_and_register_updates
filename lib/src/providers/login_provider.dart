import 'package:flutter/material.dart';
import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/models/user_login.dart';
import 'package:woin/src/models/device_model.dart';


class LoginProvider with ChangeNotifier {

  String _password;
  String get password => _password;
  set password(String pass){
    _password = pass;
    notifyListeners();
  }

  String _userName;
  String get userName => _userName;
  set userName(String uname){
    _userName = uname;
    notifyListeners();
  }

  Device _device;
  Device get device => _device;
  set device(Device dev){
    _device = dev;
    notifyListeners();
  }

  bool _isLogin;
  bool get isLogin => _isLogin;
  set isLogin(bool isLog){
    _isLogin = isLog;
    notifyListeners();
  }

  UserLoguin _userLogin;
  UserLoguin get userLogin => _userLogin;
  set userLogin(UserLoguin userLog){
    _userLogin = userLog;
    notifyListeners();
  }

  UserDetailResponse _userDetailResponse;
  UserDetailResponse get userDetail => _userDetailResponse;
  set userDetail(UserDetailResponse userDet){
    _userDetailResponse = userDet;
    notifyListeners();
  }

}