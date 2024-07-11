// ignore_for_file: no_leading_underscores_for_local_identifiers

// import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PxLocalDatabase extends ChangeNotifier {
  late final SharedPreferences prefs;

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

  // int? _syndId;
  // int? get syndId => _syndId;

  // String? _password;
  // String? get password => _password;

  // Future<void> saveDocIdToDb(int syndId, String password) async {
  //   final syndIdKey = _docIdStoreRef.record('synd_id');
  //   final passwordKey = _docIdStoreRef.record('password');
  //   syndIdKey.put(await _database, syndId);
  //   passwordKey.put(await _database, password);
  // }

  // Future<void> fetchDocIdFromDb() async {
  //   final syndIdKey = _docIdStoreRef.record('synd_id');
  //   final passwordKey = _docIdStoreRef.record('password');
  //   _syndId = await syndIdKey.get(await _database);
  //   _password = await passwordKey.get(await _database);
  //   notifyListeners();
  // }

  // Future<void> clearDoctorRecordRef() async {
  //   final syndIdKey = _docIdStoreRef.record('synd_id');
  //   final passwordKey = _docIdStoreRef.record('password');
  //   syndIdKey.delete(await _database);
  //   passwordKey.delete(await _database);
  //   _syndId = null;
  //   _password = null;
  //   notifyListeners();
  // }
}
