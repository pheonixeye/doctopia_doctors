// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'dart:convert';

import 'package:appwrite/models.dart' as clientModels show Document;
import 'package:doctopia_doctors/api/errors/algorithm_excp.dart';
import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;
import 'package:doctopia_doctors/models/doctor/doctor.dart';

class HxDoctor {
  final ENV env;
  late final Server server;
  // late final serverSDK.Databases server_db;
  late final clientSDK.Databases client_db;
  late final serverSDK.Functions server_functions;

  HxDoctor({
    required this.env,
  }) {
    server = Server.main(env.env);
    // server_db = serverSDK.Databases(server.serverAPI);
    client_db = clientSDK.Databases(server.clientAPI);
    server_functions = serverSDK.Functions(server.serverAPI);
  }

  Future<Doctor> createDoctor({
    required Doctor doctor,
  }) async {
    //create doctor in doctors db / doctors collection
    late final clientModels.Document createDoctorResponse;

    try {
      createDoctorResponse = await client_db.createDocument(
        databaseId: env.creds.DATABASE_DOCTORS,
        collectionId: env.creds.COLLECTION_DOCTORS_DOCTORS,
        documentId: clientSDK.ID.unique(),
        data: doctor.toJson(),
      );
    } catch (e) {
      rethrow;
    }

    //populate the rest of the collections
    //extract this logic in a single request to a cloud function
    //invoke function

    final excutionResult = await server_functions.createExecution(
      functionId: env.creds.CREATE_DOCTOR_FUNCTION,
      path: '/create-doctor',
      body: jsonEncode({'syndid': doctor.synd_id}),
      method: 'POST',
    );
    //throw on wrong invokation
    final functionResponse = jsonDecode(excutionResult.responseBody);
    if (functionResponse['code'] != 0) {
      throw CreateAlgorithmException(functionResponse['code'] as int);
    }

    //return doctor from the initial request
    final docFromServer = Doctor.fromJson(
      createDoctorResponse.data,
      id: createDoctorResponse.$id,
    );
    return docFromServer;
  }

  Future<Doctor> fetchDoctorBySyndId({required int synd_id}) async {
    try {
      final fetchDoctorResponse = await client_db.listDocuments(
        databaseId: env.creds.DATABASE_DOCTORS,
        collectionId: env.creds.COLLECTION_DOCTORS_DOCTORS,
        queries: [
          clientSDK.Query.equal('synd_id', synd_id),
        ],
      );

      final doctor = Doctor.fromJson(
        fetchDoctorResponse.documents.first.data,
        id: fetchDoctorResponse.documents.first.$id,
      );

      return doctor;
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor> updateDoctor({
    required Map<String, dynamic> update,
    required String id,
  }) async {
    try {
      final updateDoctorResponse = await client_db.updateDocument(
        databaseId: env.creds.DATABASE_DOCTORS,
        collectionId: env.creds.COLLECTION_DOCTORS_DOCTORS,
        documentId: id,
        data: update,
      );

      final doc = Doctor.fromJson(
        updateDoctorResponse.data,
        id: updateDoctorResponse.$id,
      );

      return doc;
    } catch (e) {
      rethrow;
    }
  }
}
