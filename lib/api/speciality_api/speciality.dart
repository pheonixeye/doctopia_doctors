import 'package:appwrite/appwrite.dart';
import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/models/speciality.dart';

class HxSpeciality {
  final ENV env;
  late final Server server;
  late final Databases db;

  HxSpeciality({
    required this.env,
  }) {
    server = Server.main(env.env);
    db = Databases(server.clientAPI);
  }

  Future<List<Speciality>> fetchSpecialities() async {
    try {
      final res = await db.listDocuments(
        databaseId: env.creds.DATABASE_CONSTANTS,
        collectionId: env.creds.COLLECTION_SPECIALITIES_CONSTANTS,
        queries: [
          Query.limit(100),
          Query.orderAsc('speciality_en'),
        ],
      );
      // print(res.documents.first.toMap().toString());

      final List<Speciality> specialities = res.documents.map((e) {
        return Speciality(
          en: e.data['speciality_en'],
          ar: e.data['speciality_ar'],
          spec_id: e.data['spec_id'],
        );
      }).toList();

      return specialities;
    } catch (e) {
      rethrow;
    }
  }
}
