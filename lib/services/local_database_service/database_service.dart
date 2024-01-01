import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart' as p;

class DbIo extends ChangeNotifier {
  late final Future<Database> _database;

  late final StoreRef<int, Map<String, dynamic>> _store;

  DbIo() {
    _database = initDb();
    _store = StoreRef<int, Map<String, dynamic>>.main();
  }

  List<ClinicVisit> _appointments = [];
  List<ClinicVisit> get appointments => _appointments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static Future<Database> initDb() async {
    // File path to a file in the current directory
    String dbpath = 'appointments.db';

    // get the application documents directory
    var dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    var dbPath = p.join(dir.path, dbpath);
    // open the database
    final db = await databaseFactoryIo.openDatabase(dbPath);

    return db;
  }

  Future<void> saveToDb(ClinicVisit appointment) async {
    _isLoading = true;
    notifyListeners();
    await _store.add(
        await _database,
        appointment.toJson()
          ..addAll({"time": DateTime.now().toIso8601String()}));
    await fetchAppointments();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteFromDb(String date) async {
    await _store.delete(
      await _database,
      finder: Finder(
        filter: Filter.equals('date', date),
      ),
    );
    await fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    _isLoading = true;
    notifyListeners();
    final data = await _store.find(await _database,
        finder: Finder(
          sortOrders: [
            SortOrder('time', false),
          ],
        ));
    _appointments = data.map((e) {
      return ClinicVisit.fromJson(e.value);
    }).toList();
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> clearDb() async {
    await _store.delete(await _database);
    await fetchAppointments();
  }
}
