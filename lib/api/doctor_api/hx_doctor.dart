import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/doctor/doctor.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart' show MediaType;

class HxDoctor {
  Future<Doctor> createDoctor({
    required Doctor doctor,
  }) async {
    try {
      final response = await PocketbaseHelper.pb.collection("doctors").create(
            body: doctor.toJson(),
          );

      final docModel = Doctor.fromJson(response.toJson());

      return docModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor> fetchDoctorById({required String id}) async {
    try {
      final response =
          await PocketbaseHelper.pb.collection("doctors").getOne(id);

      if (kDebugMode) {
        // print(response.toJson());
      }
      final doctor = Doctor.fromJson(response.toJson());

      return doctor;
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor> updateDoctorAvatar({
    required String id,
    required List<int> fileBytes,
    required String? fileName,
  }) async {
    try {
      final updateDoctorResponse =
          await PocketbaseHelper.pb.collection("doctors").update(
        id,
        files: [
          http.MultipartFile.fromBytes(
            "avatar",
            fileBytes,
            filename: fileName,
          ),
        ],
      );

      final doc = Doctor.fromJson(
        updateDoctorResponse.toJson(),
      );

      return doc;
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor> updateDoctor({
    required Map<String, dynamic> update,
    required String id,
  }) async {
    try {
      final updateDoctorResponse =
          await PocketbaseHelper.pb.collection("doctors").update(
                id,
                body: update,
              );

      final doc = Doctor.fromJson(
        updateDoctorResponse.toJson(),
      );

      return doc;
    } catch (e) {
      rethrow;
    }
  }
}
