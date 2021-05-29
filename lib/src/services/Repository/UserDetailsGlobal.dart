


import 'package:woin/src/models/user_detail.dart';

class UserDetailsGlobal{

  UserDetailResponse usuarioLogueado;
  static UserDetailsGlobal _instance=UserDetailsGlobal._internal();

  set IniciarSesion(UserDetailResponse user){
    usuarioLogueado=user;
  }

  factory UserDetailsGlobal(){
    return _instance;
  }
  UserDetailsGlobal._internal();


}