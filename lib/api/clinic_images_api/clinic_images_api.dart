// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'dart:typed_data';

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/models/clinic_images/clinic_images.dart';

class HxClinicImages {
  final ENV env = ENV("dev");
  late final Server server;
  late final clientSDK.Databases client_db;
  late final clientSDK.Storage client_storage;

  HxClinicImages() {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
    client_storage = clientSDK.Storage(server.clientAPI);
  }

  Future<String> uploadImage(String path, String fileName) async {
    try {
      final response = await client_storage.createFile(
        bucketId: env.creds.BUCKET_CLINIC_IMAGES,
        fileId: clientSDK.ID.unique(),
        file: clientSDK.InputFile.fromPath(path: path, filename: fileName),
        permissions: [
          clientSDK.Permission.write(clientSDK.Role.any()),
          clientSDK.Permission.read(clientSDK.Role.any()),
          clientSDK.Permission.update(clientSDK.Role.any()),
          clientSDK.Permission.delete(clientSDK.Role.any()),
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
        bucketId: env.creds.BUCKET_CLINIC_IMAGES,
        fileId: id,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteImage(String id) async {
    await client_storage.deleteFile(
      bucketId: env.creds.BUCKET_CLINIC_IMAGES,
      fileId: id,
    );
    return id;
  }

  Future<ClinicImages> fetchClinicImagesIds(String clinic_id) async {
    try {
      final response = await client_db.getDocument(
        databaseId: env.creds.DATABASE_CLINICS,
        collectionId: env.creds.COLLECTION_CLINIC_IMAGES_CLINICS,
        documentId: clinic_id,
      );

      final clinicImages = ClinicImages.fromJson(response.data);

      return clinicImages;
    } catch (e) {
      rethrow;
    }
  }

  Future<ClinicImages> updateClinicImageIds({
    required String clinic_id,
    required List<String> images,
  }) async {
    try {
      final response = await client_db.updateDocument(
        databaseId: env.creds.DATABASE_CLINICS,
        collectionId: env.creds.COLLECTION_CLINIC_IMAGES_CLINICS,
        documentId: clinic_id,
        data: {'images': images},
      );

      final clinicImages = ClinicImages.fromJson(response.data);
      return clinicImages;
    } catch (e) {
      rethrow;
    }
  }
}
