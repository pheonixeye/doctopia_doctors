// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'dart:convert';

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;
import 'package:doctopia_doctors/api/errors/algorithm_excp.dart';
import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';

class HxClinic {
  final ENV env;
  late final Server server;
  late final clientSDK.Databases client_db;
  late final serverSDK.Functions server_functions;

  HxClinic({
    required this.env,
  }) {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
    server_functions = serverSDK.Functions(server.serverAPI);
  }

  Future<({Clinic clinic, String id})> createClinic(Clinic clinic) async {
    try {
      final response = await client_db.createDocument(
        databaseId: env.creds.DATABASE_CLINICS,
        collectionId: env.creds.COLLECTION_CLINICS_CLINICS,
        documentId: clientSDK.ID.unique(),
        data: clinic.toJson(),
      );

      final excutionResult = await server_functions.createExecution(
        functionId: env.creds.CREATE_DOCTOR_FUNCTION,
        path: '/create-clinic',
        body: jsonEncode({'clinic_id': response.$id}),
        method: 'POST',
      );
      //throw on wrong invokation
      final functionResponse = jsonDecode(excutionResult.responseBody);
      if (functionResponse['code'] != 0) {
        throw CreateAlgorithmException(functionResponse['code'] as int);
      }

      final _clinicRecord = Clinic.clinicRecord(response.$id, response.data);

      return _clinicRecord;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<({Clinic clinic, String id})>> fetchDoctorClinics(
      String doc_id) async {
    try {
      final response = await client_db.listDocuments(
          databaseId: env.creds.DATABASE_CLINICS,
          collectionId: env.creds.COLLECTION_CLINICS_CLINICS,
          queries: [
            clientSDK.Query.equal('doc_id', doc_id),
            clientSDK.Query.limit(5),
          ]);
      final _clinics = response.documents.map((e) {
        return Clinic.clinicRecord(e.$id, e.data);
      }).toList();

      return _clinics;
    } catch (e) {
      rethrow;
    }
  }

  Future<({Clinic clinic, String id})> updateClinic(
    String id,
    Map<String, dynamic> update,
  ) async {
    try {
      final response = await client_db.updateDocument(
        databaseId: env.creds.DATABASE_CLINICS,
        collectionId: env.creds.COLLECTION_CLINICS_CLINICS,
        documentId: id,
        data: update,
      );
      final _clinic = Clinic.clinicRecord(id, response.data);
      return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(String id) async {
    try {
      await client_db.deleteDocument(
        databaseId: env.creds.DATABASE_CLINICS,
        collectionId: env.creds.COLLECTION_CLINICS_CLINICS,
        documentId: id,
      );
    } catch (e) {
      rethrow;
    }
  }
}
