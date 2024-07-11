// // ignore_for_file: library_prefixes, non_constant_identifier_names

// import 'dart:convert';

// import 'package:appwrite/appwrite.dart' as clientSDK;
// import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;
// import 'package:doctopia_doctors/api/errors/algorithm_excp.dart';
// import 'package:doctopia_doctors/api/servers/servers.dart';
// import 'package:doctopia_doctors/env/env.dart';
// import 'package:doctopia_doctors/models/clinic/clinic.dart';

// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

class HxClinic {
  Future<Clinic?> createClinic(Clinic clinic) async {
    try {
      final response = await PocketbaseHelper.pb.collection("clinics").create(
            body: clinic.toPocketbaseJson(),
          );
      final _clinic = Clinic.fromJson(response.toJson());
      return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Clinic>?> fetchDoctorClinics(String doc_id) async {
    try {
      final response = await PocketbaseHelper.pb.collection("clinics").getList(
            filter: 'doc_id = "$doc_id"',
          );

      final _clinics =
          response.items.map((e) => Clinic.fromJson(e.toJson())).toList();
      if (kDebugMode) {
        print("fetchDoctorClinics(${_clinics.length})");
      }
      return _clinics;
    } on ClientException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e.response['message']);
    }
  }

  Future<Clinic> updateClinic(
    String id,
    Map<String, dynamic> update,
  ) async {
    try {
      final response = await PocketbaseHelper.pb.collection("clinics").update(
            id,
            body: update,
          );
      final _clinic = Clinic.fromJson(response.toJson());
      return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(String id, BuildContext context) async {
    try {
      final _token = context.read<PxUserModel>().token;
      await PocketbaseHelper.pb.collection("clinics").delete(
        id,
        headers: {"Authorization": "$_token"},
      );
    } catch (e) {
      rethrow;
    }
  }
}
