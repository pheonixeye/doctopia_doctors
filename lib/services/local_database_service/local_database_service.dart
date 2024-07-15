// ignore_for_file: no_leading_underscores_for_local_identifiers

// import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PxLocalDatabase extends ChangeNotifier {
  static late final SharedPreferences prefs;

  // PxLocalDatabase() {
  //   initDb();
  // }

  Future<void> initDb() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? _theme;
  String get theme => _theme ?? 'light';

  Future<void> saveThemeToDb(String theme) async {
    await prefs.setString("theme", theme);
  }

  void fetchThemeFromDb() {
    _theme = prefs.getString("theme");
    notifyListeners();
  }

  String? _language;
  String get language => _language ?? 'en';

  Future<void> saveLanguageToDb(String lang) async {
    await prefs.setString("lang", lang);
  }

  void fetchLanguageFromDb() {
    _language = prefs.getString("lang");
    notifyListeners();
  }
}
