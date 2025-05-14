import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/degree.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/speciality.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

class HxDoctor {
  const HxDoctor();

  static const String collection = 'doctors';
  static const String _expand = 'speciality_id, degree_id';

  Future<Doctor> createDoctor({
    required DoctorResponseModel doctor,
  }) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).create(
            body: doctor.toJson(),
            expand: _expand,
          );

      //todo: add reference to doctor_website_info collection
      await PocketbaseHelper.pb.collection('doctor_website_info').create(
        body: {
          'doc_id': response.id,
          'views_count': 0,
          'average_rating': 0,
          'reviews_count': 0,
          'tags': const {},
        },
      );
      final _model = DoctorResponseModel.fromJson(response.toJson());
      final _speciality = Speciality.fromJson(
          response.get<RecordModel>('expand.speciality_id').toJson());
      final _degree = Degree.fromJson(
          response.get<RecordModel>('expand.degree_id').toJson());

      return Doctor.fromResponseModel(
        model: _model,
        speciality: _speciality,
        degree: _degree,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor?> fetchDoctorById({required String id}) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).getOne(
            id,
            expand: _expand,
          );

      final _model = DoctorResponseModel.fromJson(response.toJson());
      final _speciality = Speciality.fromJson(
          response.get<RecordModel>('expand.speciality_id').toJson());
      final _degree = Degree.fromJson(
          response.get<RecordModel>('expand.degree_id').toJson());

      return Doctor.fromResponseModel(
        model: _model,
        speciality: _speciality,
        degree: _degree,
      );
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
      final response = await PocketbaseHelper.pb.collection(collection).update(
            id,
            files: [
              http.MultipartFile.fromBytes(
                "avatar",
                fileBytes,
                filename: fileName,
              ),
            ],
            expand: _expand,
          );

      final _model = DoctorResponseModel.fromJson(response.toJson());
      final _speciality = Speciality.fromJson(
          response.get<RecordModel>('expand.speciality_id').toJson());
      final _degree = Degree.fromJson(
          response.get<RecordModel>('expand.degree_id').toJson());

      return Doctor.fromResponseModel(
        model: _model,
        speciality: _speciality,
        degree: _degree,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor> updateDoctor({
    required Map<String, dynamic> update,
    required String id,
  }) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).update(
            id,
            body: update,
            expand: _expand,
          );

      final _model = DoctorResponseModel.fromJson(response.toJson());
      final _speciality = Speciality.fromJson(
          response.get<RecordModel>('expand.speciality_id').toJson());
      final _degree = Degree.fromJson(
          response.get<RecordModel>('expand.degree_id').toJson());

      return Doctor.fromResponseModel(
        model: _model,
        speciality: _speciality,
        degree: _degree,
      );
    } catch (e) {
      rethrow;
    }
  }
}
