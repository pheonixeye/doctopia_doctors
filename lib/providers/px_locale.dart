import 'package:flutter/material.dart';

class PxLocale extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void setLocale() {
    if (lang == 'en') {
      _locale = const Locale('en');
      notifyListeners();
    } else if (lang == 'ar') {
      _locale = const Locale('ar');
      notifyListeners();
    }
  }

  void changeLocale() {
    if (_locale == const Locale('en')) {
      _locale = const Locale('ar');
    } else if (_locale == const Locale('ar')) {
      _locale = const Locale('en');
    }
    notifyListeners();
  }

  String? _lang;
  String? get lang => _lang;

  void setLang(String? val) {
    _lang = val;
  }
}
