// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_response_model.dart';
import 'package:flutter/foundation.dart';

class PxClinics extends ChangeNotifier {
  final HxClinic clinicService;
  final String doc_id;

  PxClinics({
    required this.clinicService,
    required this.doc_id,
  }) {
    fetchClinics();
    if (kDebugMode) {
      print("PxClinics($doc_id)._init()");
    }
  }

  static List<Clinic>? _clinics;
  List<Clinic>? get clinics => _clinics;

  Future<List<Clinic>?> fetchClinics() async {
    try {
      final response = await clinicService.fetchDoctorClinics(doc_id);
      _clinics = response!;
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Clinic? _clinic;
  Clinic? get clinic => _clinic;

  void selectClinic(Clinic? value) {
    _clinic = value;
    notifyListeners();
  }

  Future<void> createClinic(ClinicResponseModel model) async {
    try {
      await clinicService.createClinic(model);
      await fetchClinics();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateClinic(String id, Map<String, dynamic> update) async {
    try {
      await clinicService.updateClinic(id, update);
      await fetchClinics();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(Clinic clinic, token) async {
    try {
      await clinicService.deleteClinic(clinic, token);
      await fetchClinics();
    } catch (e) {
      rethrow;
    }
  }
}
