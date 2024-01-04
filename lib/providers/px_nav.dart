import 'package:flutter/material.dart';

class PxNav extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  bool _extended = false;
  bool get extended => _extended;

  void setIndex(int i) {
    _index = i;
    notifyListeners();
  }

  void setExtended() {
    _extended = !_extended;
    notifyListeners();
  }
}
