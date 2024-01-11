// ignore_for_file: no_leading_underscores_for_local_identifiers

// import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart' as p;

class PxLocalDatabase extends ChangeNotifier {
  late final Future<Database> _database;

  // late final StoreRef<int, Map<String, dynamic>> _appStoreRef;
  late final StoreRef<String, String?> _themeStoreRef;
  late final StoreRef<String, String?> _languageStoreRef;
  late final StoreRef<String, dynamic> _docIdStoreRef;

  PxLocalDatabase() {
    _database = initDb();
    // _appStoreRef = StoreRef<int, Map<String, dynamic>>('notifications');
    _themeStoreRef = StoreRef<String, String?>('theme');
    _languageStoreRef = StoreRef<String, String?>('language');
    _docIdStoreRef = StoreRef<String, dynamic>('docInfo');
  }

  // List<ClinicVisit> _appointments = [];
  // List<ClinicVisit> get appointments => _appointments;

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;

  static Future<Database> initDb() async {
    // File path to a file in the current directory
    String dbpath = 'local.db';

    // get the application documents directory
    var dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    var dbPath = p.join(dir.path, dbpath);
    // open the database
    final db = databaseFactoryIo.openDatabase(dbPath);

    return db;
  }

  // Future<void> saveAppointmentToDb(ClinicVisit appointment) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   await _appStoreRef.add(
  //       await _database,
  //       appointment.toJson()
  //         ..addAll({"time": DateTime.now().toIso8601String()}));
  //   await fetchAppointmentsFromDb();
  //   _isLoading = false;
  //   notifyListeners();
  // }

  // Future<void> deleteAppointmentFromDb(String date) async {
  //   await _appStoreRef.delete(
  //     await _database,
  //     finder: Finder(
  //       filter: Filter.equals('date', date),
  //     ),
  //   );
  //   await fetchAppointmentsFromDb();
  // }

  // Future<void> fetchAppointmentsFromDb() async {
  //   _isLoading = true;
  //   notifyListeners();
  //   final data = await _appStoreRef.find(await _database,
  //       finder: Finder(
  //         sortOrders: [
  //           SortOrder('time', false),
  //         ],
  //       ));
  //   _appointments = data.map((e) {
  //     return ClinicVisit.fromJson(e.value);
  //   }).toList();
  //   notifyListeners();
  //   _isLoading = false;
  //   notifyListeners();
  // }

  // Future<void> clearAppointmentsFromDb() async {
  //   await _appStoreRef.delete(await _database);
  //   await fetchAppointmentsFromDb();
  // }

  String? _theme;
  String get theme => _theme ?? 'light';

  Future<void> saveThemeToDb(String theme) async {
    final themeKey = _themeStoreRef.record('theme');
    themeKey.put(await _database, theme);
  }

  Future<void> fetchThemeFromDb() async {
    final themeKey = _themeStoreRef.record('theme');
    _theme = await themeKey.get(await _database);

    notifyListeners();
  }

  String? _language;
  String get language => _language ?? 'en';

  Future<void> saveLanguageToDb(String lang) async {
    final languageKey = _languageStoreRef.record('language');
    languageKey.put(await _database, lang);
  }

  Future<void> fetchLanguageFromDb() async {
    final languageKey = _languageStoreRef.record('language');
    _language = await languageKey.get(await _database);
    notifyListeners();
  }

  int? _syndId;
  int? get syndId => _syndId;

  String? _password;
  String? get password => _password;

  Future<void> saveDocIdToDb(int syndId, String password) async {
    final syndIdKey = _docIdStoreRef.record('synd_id');
    final passwordKey = _docIdStoreRef.record('password');
    syndIdKey.put(await _database, syndId);
    passwordKey.put(await _database, password);
  }

  Future<void> fetchDocIdFromDb() async {
    final syndIdKey = _docIdStoreRef.record('synd_id');
    final passwordKey = _docIdStoreRef.record('password');
    _syndId = await syndIdKey.get(await _database);
    _password = await passwordKey.get(await _database);
    notifyListeners();
  }

  Future<void> clearDoctorRecordRef() async {
    final syndIdKey = _docIdStoreRef.record('synd_id');
    final passwordKey = _docIdStoreRef.record('password');
    syndIdKey.delete(await _database);
    passwordKey.delete(await _database);
    _syndId = null;
    _password = null;
    notifyListeners();
  }
}
