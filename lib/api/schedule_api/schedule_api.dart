// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/models/schedule/schedule.dart';

class HxSchedule {
  final ENV env;
  late final Server server;
  late final clientSDK.Databases client_db;

  HxSchedule({
    required this.env,
  }) {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
  }

  Future<List<(String, Schedule)>> fetchClinicScheduleList(
      String clinic_id) async {
    try {
      final response = await client_db.listDocuments(
        databaseId: env.creds.DATABASE_SCHEDULE,
        collectionId: clinic_id,
      );

      final _scheduleList = response.documents.map((e) {
        return (e.$id, Schedule.fromJson(e.data));
      }).toList();

      return _scheduleList;
    } catch (e) {
      rethrow;
    }
  }

  Future<(String, Schedule)> addSchedule(
      String clinic_id, Schedule schedule) async {
    try {
      final response = await client_db.createDocument(
        databaseId: env.creds.DATABASE_SCHEDULE,
        collectionId: clinic_id,
        documentId: clientSDK.ID.unique(),
        data: schedule.toJson(),
      );

      final _schedule = (response.$id, Schedule.fromJson(response.data));

      return _schedule;
    } catch (e) {
      rethrow;
    }
  }

  Future<(String, Schedule)> updateSchedule(
      String clinic_id, String id, Schedule schedule) async {
    try {
      final response = await client_db.updateDocument(
        databaseId: env.creds.DATABASE_SCHEDULE,
        collectionId: clinic_id,
        documentId: id,
        data: schedule.toJson(),
      );

      final _schedule = (response.$id, Schedule.fromJson(response.data));

      return _schedule;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSchedule(String clinic_id, String id) async {
    try {
      await client_db.deleteDocument(
        databaseId: env.creds.DATABASE_SCHEDULE,
        collectionId: clinic_id,
        documentId: id,
      );
    } catch (e) {
      rethrow;
    }
  }
}
