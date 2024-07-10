// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';

class HxClinicVisits {
  final ENV env = ENV("dev");
  late final Server server;
  late final clientSDK.Databases client_db;

  HxClinicVisits() {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
  }

  Future<List<({String id, ClinicVisit visit})>> fetchClinicVisits({
    required String doc_id,
    // required String clinic_id,
    required int day,
    required int month,
    required int year,
  }) async {
    try {
      final response = await client_db.listDocuments(
          databaseId: env.creds.DATABASE_VISITS,
          collectionId: doc_id,
          queries: [
            // clientSDK.Query.equal('clinic_id', clinic_id),
            clientSDK.Query.equal('day', day),
            clientSDK.Query.equal('month', month),
            clientSDK.Query.equal('year', year),
          ]);

      final List<({String id, ClinicVisit visit})> _data =
          response.documents.map((e) {
        return (id: e.$id, visit: ClinicVisit.fromJson(e.data));
      }).toList();

      return _data;
    } catch (e) {
      rethrow;
    }
  }
}
