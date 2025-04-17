import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_response_model.dart';
import 'package:pocketbase/pocketbase.dart';
// import 'package:doctopia_doctors/functions/dprint.dart';

class HxClinic {
  const HxClinic();

  static const String _expand =
      'governorate_id, city_id, speciality_id, venue_id, attendance_type_id';

  static const String collection = 'clinics';

  Future<Clinic?> createClinic(ClinicResponseModel model) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).create(
            body: model.toJson(),
            expand: _expand,
          );

      final _clinic = Clinic.fromJson({
        ...response.toJson(),
        'governorate':
            response.get<RecordModel>('expand.governorate_id').toJson(),
        'city': response.get<RecordModel>('expand.city_id').toJson(),
        'speciality':
            response.get<RecordModel>('expand.speciality_id').toJson(),
        'venue': response.get<RecordModel?>('expand.venue_id')?.toJson(),
        'attendance_type':
            response.get<RecordModel>('expand.attendance_type_id').toJson(),
      });

      return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Clinic>?> fetchDoctorClinics(String doc_id) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).getList(
            filter: 'doc_id = "$doc_id"',
            expand: _expand,
          );
      // dprint(response);
      final _clinics = response.items.map((record) {
        final _clinic = Clinic.fromJson({
          ...record.toJson(),
          'governorate':
              record.get<RecordModel>('expand.governorate_id').toJson(),
          'city': record.get<RecordModel>('expand.city_id').toJson(),
          'speciality':
              record.get<RecordModel>('expand.speciality_id').toJson(),
          'venue': record.get<RecordModel?>('expand.venue_id')?.toJson(),
          'attendance_type':
              record.get<RecordModel>('expand.attendance_type_id').toJson(),
        });
        return _clinic;
      }).toList();

      return _clinics;
    } on ClientException catch (e) {
      print(e.toString());
      throw Exception(e.response['message']);
    }
  }

  Future<Clinic> updateClinic(
    String id,
    Map<String, dynamic> update,
  ) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).update(
            id,
            body: update,
            expand: _expand,
          );

      final _clinic = Clinic.fromJson({
        ...response.toJson(),
        'governorate':
            response.get<RecordModel>('expand.governorate_id').toJson(),
        'city': response.get<RecordModel>('expand.city_id').toJson(),
        'speciality':
            response.get<RecordModel>('expand.speciality_id').toJson(),
        'venue': response.get<RecordModel?>('expand.venue_id')?.toJson(),
        'attendance_type':
            response.get<RecordModel>('expand.attendance_type_id').toJson(),
      });

      return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(Clinic clinic, String token) async {
    try {
      await PocketbaseHelper.pb.collection(collection).delete(
        clinic.id,
        headers: {"Authorization": token},
      );
    } catch (e) {
      rethrow;
    }
  }
}
