// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:flutter/material.dart';

class PxClinics extends ChangeNotifier {
  final HxClinic clinicService;

  PxClinics({required this.clinicService});

  List<Clinic> _clinics = [];
  List<Clinic> get clinics => _clinics;

  Future<List<Clinic>> fetchClinics(String doc_id) async {
    try {
      final response = await clinicService.fetchDoctorClinics(doc_id);
      _clinics = response.map((e) => e.clinic).toList();
      notifyListeners();
      return _clinics;
    } catch (e) {
      rethrow;
    }
  }

  Clinic _clinic = Clinic.initial();
  Clinic get clinic => _clinic;

  void setClinic({
    String? doc_id,
    String? speciality_en,
    String? speciality_ar,
    String? name_en,
    String? name_ar,
    String? venue_en,
    String? venue_ar,
    String? gov_en,
    String? gov_ar,
    String? city_en,
    String? city_ar,
    String? mobile,
    String? landline,
    String? address_en,
    String? address_ar,
    String? location_link,
    bool? attendance,
    bool? published,
    int? fees,
    int? discount,
    List<String>? off_dates,
  }) {
    _clinic = _clinic.copyWith(
      doc_id: doc_id ?? _clinic.doc_id,
      speciality_en: speciality_en ?? _clinic.speciality_en,
      speciality_ar: speciality_ar ?? _clinic.speciality_ar,
      name_en: name_en ?? _clinic.name_en,
      name_ar: name_ar ?? _clinic.name_ar,
      venue_en: venue_en ?? _clinic.venue_en,
      venue_ar: venue_ar ?? _clinic.venue_ar,
      gov_en: gov_en ?? _clinic.gov_en,
      gov_ar: gov_ar ?? _clinic.gov_ar,
      city_en: city_en ?? _clinic.city_en,
      city_ar: city_ar ?? _clinic.city_ar,
      mobile: mobile ?? _clinic.mobile,
      landline: landline ?? _clinic.landline,
      address_en: address_en ?? _clinic.address_en,
      address_ar: address_ar ?? _clinic.address_ar,
      location_link: location_link ?? _clinic.location_link,
      attendance: attendance ?? _clinic.attendance,
      published: published ?? _clinic.published,
      fees: fees ?? _clinic.fees,
      discount: discount ?? _clinic.discount,
      off_dates: off_dates ?? _clinic.off_dates,
    );
    notifyListeners();
  }

  Future<Clinic> createClinic() async {
    try {
      final response = await clinicService.createClinic(clinic);
      _clinic = response.clinic;
      notifyListeners();
      await fetchClinics(clinic.doc_id);
      return response.clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<Clinic> updateClinic(String id, Map<String, dynamic> update) async {
    try {
      final response = await clinicService.updateClinic(id, update);
      _clinic = response.clinic;
      notifyListeners();
      await fetchClinics(_clinic.doc_id);
      return _clinic;
    } catch (e) {
      rethrow;
    }
  }
}
