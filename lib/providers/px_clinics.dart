// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:flutter/material.dart';

class PxClinics extends ChangeNotifier {
  final HxClinic clinicService;

  PxClinics({required this.clinicService});

  List<({Clinic clinic, String id})> _clinics = [];
  List<({Clinic clinic, String id})> get clinics => _clinics;

  Future<void> fetchClinics(String doc_id) async {
    try {
      // final response = await clinicService.fetchDoctorClinics(doc_id);
      // _clinics = response;
      // notifyListeners();
      // return response;
    } catch (e) {
      rethrow;
    }
  }

  Clinic _clinic = Clinic.initial();
  Clinic get clinic => _clinic;

  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

  void selectIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

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
    int? consultation_fees,
    int? followup_fees,
    int? discount,
    List<String>? off_dates,
    int? spec_id,
    int? gov_id,
    int? city_id,
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
      consultation_fees: consultation_fees ?? _clinic.consultation_fees,
      followup_fees: followup_fees ?? _clinic.followup_fees,
      discount: discount ?? _clinic.discount,
      off_dates: off_dates ?? _clinic.off_dates,
      spec_id: spec_id ?? _clinic.spec_id,
      gov_id: gov_id ?? _clinic.gov_id,
      city_id: city_id ?? _clinic.city_id,
    );
    notifyListeners();
  }

  void setClinicFromKeyValue(String key, String value) {
    switch (key) {
      case 'name_en':
        _clinic = _clinic.copyWith(
          name_en: value,
        );
        break;
      case 'name_ar':
        _clinic = _clinic.copyWith(
          name_ar: value,
        );
        break;
      case 'venue_en':
        _clinic = _clinic.copyWith(
          venue_en: value,
        );
        break;
      case 'venue_ar':
        _clinic = _clinic.copyWith(
          venue_ar: value,
        );
        break;
      case 'mobile':
        _clinic = _clinic.copyWith(
          mobile: value,
        );
        break;
      case 'landline':
        _clinic = _clinic.copyWith(
          landline: value,
        );
        break;
      case 'address_en':
        _clinic = _clinic.copyWith(
          address_en: value,
        );
        break;
      case 'address_ar':
        _clinic = _clinic.copyWith(
          address_ar: value,
        );
        break;
      case 'location_link':
        _clinic = _clinic.copyWith(
          location_link: value,
        );
        break;
      case 'consultation_fees':
        _clinic = _clinic.copyWith(
          consultation_fees: value.isEmpty ? 0 : int.parse(value),
        );
        break;
      case 'followup_fees':
        _clinic = _clinic.copyWith(
          followup_fees: value.isEmpty ? 0 : int.parse(value),
        );
        break;
      case 'discount':
        _clinic = _clinic.copyWith(
          discount: value.isEmpty ? 0 : int.parse(value),
        );
        break;
      default:
        return;
    }
    notifyListeners();
  }

  Future<Clinic?> createClinic() async {
    try {
      // final response = await clinicService.createClinic(clinic);
      // _clinic = response.clinic;
      // notifyListeners();
      // await fetchClinics(clinic.doc_id);
      // return response.clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<Clinic?> updateClinic(String id, Map<String, dynamic> update) async {
    try {
      // final response = await clinicService.updateClinic(id, update);
      // _clinic = response.clinic;
      // notifyListeners();
      // await fetchClinics(_clinic.doc_id);
      // return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(String id, String doc_id) async {
    try {
      // await clinicService.deleteClinic(id);
      await fetchClinics(doc_id);
    } catch (e) {
      rethrow;
    }
  }
}
