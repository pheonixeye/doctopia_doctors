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
import 'package:doctopia_doctors/models/destination.dart';
import 'package:doctopia_doctors/models/doctor/doctor.dart';
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
      //#add to doctor destinations
      final doc_response =
          await PocketbaseHelper.pb.collection("doctors").getOne(clinic.doc_id);

      final doctor = Doctor.fromJson(doc_response.toJson());

      final dest = doctor.destinations;

      final newDoctorDestinations = [...dest, clinic.destination];

      await PocketbaseHelper.pb.collection("doctors").update(
        clinic.doc_id,
        body: {
          "destinations": newDoctorDestinations.map((e) => e.toJson()).toList(),
          "clinic_rel+": response.id,
        },
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

      if (update.keys.contains("destination")) {
        final doc_response = await PocketbaseHelper.pb
            .collection("doctors")
            .getOne(_clinic.doc_id);

        final doctor = Doctor.fromJson(doc_response.toJson());

        final dest = doctor.destinations;
        final updatedDestination = Destination.fromJson(update['destination']);
        dest.removeWhere((d) => d.id == updatedDestination.id);
        final newDoctorDestinations = <Destination>[
          ...dest,
          updatedDestination,
        ];
        await PocketbaseHelper.pb
            .collection("doctors")
            .update(_clinic.doc_id, body: {
          "destinations": newDoctorDestinations.map((e) => e.toJson()).toList(),
        });
      }
      return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(Clinic clinic, BuildContext context) async {
    try {
      final _token = context.read<PxUserModel>().token;
      final _doc_id = context.read<PxUserModel>().id;
      await PocketbaseHelper.pb.collection("clinics").delete(
        clinic.id,
        headers: {"Authorization": "$_token"},
      );

      final doc_res =
          await PocketbaseHelper.pb.collection("doctors").getOne(_doc_id!);

      final doctor = Doctor.fromJson(doc_res.toJson());

      final doc_des = doctor.destinations;

      doc_des.removeWhere((d) => d.id == clinic.destination.id);

      await PocketbaseHelper.pb.collection("doctors").update(
        doctor.id,
        body: {
          "clinic_rel-": clinic.id,
          "destinations": doc_des.map((d) => d.toJson()).toList(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
