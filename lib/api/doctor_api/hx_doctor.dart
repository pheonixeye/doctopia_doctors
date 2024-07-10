import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/doctor/doctor.dart';

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
      final fetchDoctorResponse =
          await PocketbaseHelper.pb.collection("doctors").getOne(id);

      final doctor = Doctor.fromJson(fetchDoctorResponse.toJson());

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
