// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/models/city.dart';
import 'package:doctopia_doctors/models/governorate.dart';
import 'package:doctopia_doctors/models/governorates.dart';

class HxGovCity {
  final ENV env;
  late final Server server;
  late final clientSDK.Databases client_db;

  HxGovCity({required this.env}) {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
  }

  Future<Governorates> fetchGovernorates() async {
    try {
      final govs = await client_db.listDocuments(
        databaseId: env.creds.DATABASE_CONSTANTS,
        collectionId: env.creds.COLLECTION_GOVERNORATES_CONSTANTS,
        queries: [
          clientSDK.Query.limit(200),
        ],
      );
      final cities = await client_db.listDocuments(
        databaseId: env.creds.DATABASE_CONSTANTS,
        collectionId: env.creds.COLLECTION_CITIES_CONSTANTS,
        queries: [
          clientSDK.Query.limit(2000),
        ],
      );

      Governorates _governorates = Governorates(
          data: govs.documents.map((e) {
        return Governorate(
          id: e.data['id'],
          governorate_name_en: e.data['governorate_name_en'],
          governorate_name_ar: e.data['governorate_name_ar'],
          cities: cities.documents.where((x) {
            return e.data['id'] == x.data['governorate_id'];
          }).map((z) {
            return City(
              id: z.data['id'],
              governorate_id: z.data['governorate_id'],
              city_name_en: z.data['city_name_en'],
              city_name_ar: z.data['city_name_ar'],
            );
          }).toList(),
        );
      }).toList());
      return _governorates;
    } catch (e) {
      rethrow;
    }
  }
}
