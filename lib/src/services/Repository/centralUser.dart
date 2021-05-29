class centralUser {
  int toogleButton = 2;
  set tiposuer(int tipo) {
    toogleButton = tipo;
  }

  static centralUser _instance = centralUser._internal();

  factory centralUser() {
    return _instance;
  }

  centralUser._internal();
}
