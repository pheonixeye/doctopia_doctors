import 'package:flutter/material.dart';

class PxTheme extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  Brightness _brightness = Brightness.light;
  Brightness get brightness => _brightness;

  void setThemeMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _brightness = _mode == ThemeMode.light ? Brightness.dark : Brightness.light;

    notifyListeners();
  }
}
