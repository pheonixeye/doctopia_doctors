// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/models/publish_request/publish_request.dart';

class HxPublishRequest {
  final ENV env = ENV("dev");
  late final Server server;
  late final clientSDK.Databases client_db;

  HxPublishRequest() {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
  }

  Future<PublishRequest?> fetchPublishRequest(String doc_id) async {
    try {
      final response = await client_db.getDocument(
        databaseId: env.creds.DATABASE_DOCTORS,
        collectionId: env.creds.COLLECTION_DOCTOR_DOCTOR_PUBLISH_REQUESTS,
        documentId: doc_id,
      );

      if (response.data == {}) {
        return null;
      } else {
        return PublishRequest.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PublishRequest> createPublishRequest(
      String doc_id, PublishRequest request) async {
    try {
      final response = await client_db.createDocument(
        databaseId: env.creds.DATABASE_DOCTORS,
        collectionId: env.creds.COLLECTION_DOCTOR_DOCTOR_PUBLISH_REQUESTS,
        documentId: doc_id,
        data: request.toJson(),
      );

      final pubReq = PublishRequest.fromJson(response.data);

      return pubReq;
    } catch (e) {
      rethrow;
    }
  }
}
