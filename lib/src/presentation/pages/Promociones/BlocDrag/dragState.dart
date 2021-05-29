
import 'package:flutter/cupertino.dart';

class DragState with ChangeNotifier {

  int state=1;

  void chageState(int st){
    this.state=st;
    notifyListeners();
  }

}