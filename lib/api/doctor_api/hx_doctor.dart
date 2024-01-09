// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/constant/function_map.dart';
import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';

import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:doctopia_doctors/models/doctor.dart';
import 'package:doctopia_doctors/models/documents/documents.dart';

class HxDoctor {
  final ENV env;
  late final Server server;
  late final serverSDK.Databases server_db;
  late final clientSDK.Databases client_db;

  HxDoctor({
    required this.env,
  }) {
    server = Server.main(env.env);
    server_db = serverSDK.Databases(server.serverAPI);
    client_db = clientSDK.Databases(server.clientAPI);
  }

  Future<Doctor> createDoctor(Doctor doctor) async {
    //create doctor in doctors db / doctors collection
    final createDoctorResponse = await client_db.createDocument(
      databaseId: env.creds.DATABASE_DOCTORS,
      collectionId: env.creds.COLLECTION_DOCTORS_DOCTORS,
      documentId: clientSDK.ID.unique(),
      data: doctor.toJson(),
    );
    final doctorId = createDoctorResponse.$id;
    final doctorName = createDoctorResponse.data['name_en'];
    //create empty doctor-document ref in doctor-documents collection
    await client_db.createDocument(
      databaseId: env.creds.DATABASE_DOCTORS,
      collectionId: env.creds.COLLECTION_DOCTOR_DOCUMENTS_DOCTORS,
      documentId: clientSDK.ID.unique(),
      data: DoctorDocuments(
        docid: doctorId,
        synd_card: '',
        permit_cert: '',
        specialist_cert: '',
        consultant_cert: '',
        avatar: '',
      ).toJson(),
    );
    //create empty visits collection in visits db with id of doctor
    await server_db.createCollection(
      databaseId: env.creds.DATABASE_VISITS,
      collectionId: doctorId,
      name: doctorName,
      permissions: [],
      enabled: true,
    );
    //populate doctor-visits collection with visit attributes
    ClinicVisit.scheme.forEach((key, Type value) async {
      await createAttribute(
        type: value,
        databases: server_db,
        databaseId: env.creds.DATABASE_VISITS,
        collectionId: doctorId,
        key: key,
        size: 100,
        xrequired: true,
      );
    });
    //TODO: populate the rest of the collections
    //TODO: extract this logic in a single request to a cloud function
    //return doctor from the initial request
    final docFromServer = Doctor.fromJson(createDoctorResponse.data);
    return docFromServer;
  }
}
