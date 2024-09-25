// ignore_for_file: no_leading_underscores_for_local_identifiers

// import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
// import 'package:flutter/foundation.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PxLocalDatabase extends ChangeNotifier {
  static late final SharedPreferencesAsync _prefs;

  PxLocalDatabase._();

  factory PxLocalDatabase._internal() {
    _prefs = SharedPreferencesAsync();
    return PxLocalDatabase._();
  }

  static PxLocalDatabase get instance => PxLocalDatabase._internal();

  static String? _theme;
  String get theme => _theme ?? 'light';

  Future<void> saveThemeToDb(String theme) async {
    await _prefs.setString("theme", theme);
  }

  Future<void> fetchThemeFromDb() async {
    _theme = await _prefs.getString("theme");
    notifyListeners();
  }

  static String? _language;
  String get language => _language ?? 'en';

  Future<void> saveLanguageToDb(String lang) async {
    await _prefs.setString("lang", lang);
  }

  Future<void> fetchLanguageFromDb() async {
    _language = await _prefs.getString("lang");
    notifyListeners();
  }

  static String? _token;
  String? get token => _token;

  Future<void> saveCredentials(String token) async {
    await _prefs.setString('token', token);
  }

  Future<String?> getCredentials() async {
    _token = await _prefs.getString('token');
    dprint('PxLocalDb().getCredentials($_token)');
    return _token;
  }

  Future<void> clearCredentials() async {
    await _prefs.setString('token', '');
  }
}
