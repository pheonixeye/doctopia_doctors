// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/models/documents/documents.dart';
import 'package:flutter/services.dart';
// import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;

class HxDocuments {
  final ENV env;
  late final Server server;
  late final clientSDK.Databases client_db;
  late final clientSDK.Storage client_storage;

  HxDocuments({
    required this.env,
  }) {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
    client_storage = clientSDK.Storage(server.clientAPI);
  }

  Future<String> uploadImage(String path, String fileName) async {
    try {
      final response = await client_storage.createFile(
        bucketId: env.creds.BUCKET_DOCTOR_DOCUMENTS,
        fileId: clientSDK.ID.unique(),
        file: clientSDK.InputFile.fromPath(path: path, filename: fileName),
        permissions: [
          clientSDK.Permission.write(clientSDK.Role.any()),
          clientSDK.Permission.read(clientSDK.Role.any()),
          clientSDK.Permission.update(clientSDK.Role.any()),
          // clientSDK.Permission.delete(clientSDK.Role.any()),
        ],
      );

      return response.$id;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> fetchImage(String id) async {
    try {
      final response = await client_storage.getFileDownload(
        bucketId: env.creds.BUCKET_DOCTOR_DOCUMENTS,
        fileId: id,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<DoctorDocuments> fetchDoctorDocuments(String docid) async {
    try {
      final response = await client_db.getDocument(
        databaseId: env.creds.DATABASE_DOCTORS,
        collectionId: env.creds.COLLECTION_DOCTOR_DOCUMENTS_DOCTORS,
        documentId: docid,
      );

      final docDocument = DoctorDocuments.fromJson(response.data);
      return docDocument;
    } catch (e) {
      rethrow;
    }
  }

  Future<DoctorDocuments> updateDoctorDocuments({
    required String docid,
    required Map<String, dynamic> update,
  }) async {
    try {
      final response = await client_db.updateDocument(
        databaseId: env.creds.DATABASE_DOCTORS,
        collectionId: env.creds.COLLECTION_DOCTOR_DOCUMENTS_DOCTORS,
        documentId: docid,
        data: update,
      );

      final docDocument = DoctorDocuments.fromJson(response.data);
      return docDocument;
    } catch (e) {
      rethrow;
    }
  }
}
