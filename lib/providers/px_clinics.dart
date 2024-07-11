// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PxClinics extends ChangeNotifier {
  final HxClinic clinicService;
  final String id;

  PxClinics({
    required this.clinicService,
    required this.id,
  }) {
    fetchClinics();
    if (kDebugMode) {
      print("PxClinics($id)._init()");
    }
  }

  List<Clinic> _clinics = [];
  List<Clinic> get clinics => _clinics;

  Future<List<Clinic>?> fetchClinics() async {
    try {
      final response = await clinicService.fetchDoctorClinics(id);
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

  void setClinic({
    String? name_en,
    String? name_ar,
    String? gov_en,
    String? gov_ar,
    String? city_en,
    String? city_ar,
    String? mobile,
    String? landline,
    String? address_en,
    String? address_ar,
    bool? attendance,
    bool? published,
    int? consultation_fees,
    int? followup_fees,
    int? followup_duration,
    int? discount,
    double? lon,
    double? lat,
    List<String>? off_dates,
  }) {
    // _clinic ??= Clinic.initial();
    _clinic = _clinic!.copyWith(
      doc_id: id,
      name_en: name_en ?? _clinic?.name_en,
      name_ar: name_ar ?? _clinic?.name_ar,
      mobile: mobile ?? _clinic?.mobile,
      landline: landline ?? _clinic?.landline,
      attendance: attendance ?? _clinic?.attendance,
      published: published ?? _clinic?.published,
      consultation_fees: consultation_fees ?? _clinic?.consultation_fees,
      followup_fees: followup_fees ?? _clinic?.followup_fees,
      discount: discount ?? _clinic?.discount,
      off_dates: off_dates ?? _clinic?.off_dates,
      // destination: _clinic?.destination.copyWith(
      //   addressEn: address_en,
      //   addressAr: address_ar,
      //   govEn: gov_en,
      //   govAr: gov_ar,
      //   areaEn: city_en,
      //   areaAr: city_ar,
      //   lon: lon,
      //   lat: lat,
      // ),
    );
    if (kDebugMode) {
      // print(_clinic);
    }
    notifyListeners();
  }

  void setClinicFromKeyValue(String key, String value) {
    switch (key) {
      case 'name_en':
        _clinic = _clinic?.copyWith(
          name_en: value,
        );
        notifyListeners();

        break;
      case 'name_ar':
        _clinic = _clinic?.copyWith(
          name_ar: value,
        );
        notifyListeners();

        break;
      case 'address_en':
        _clinic = _clinic?.copyWith(
          address_en: value,
        );
        break;
      case 'address_ar':
        _clinic = _clinic?.copyWith(
          address_ar: value,
        );
        break;
      case 'gov_en':
        _clinic = _clinic?.copyWith(
          gov_en: value,
        );
        break;
      case 'gov_ar':
        _clinic = _clinic?.copyWith(
          gov_ar: value,
        );
        break;
      case 'area_en':
        _clinic = _clinic?.copyWith(
          city_en: value,
        );
        break;
      case 'area_ar':
        _clinic = _clinic?.copyWith(
          city_ar: value,
        );
        break;
      case 'lon':
        _clinic = _clinic?.copyWith(
          lon: double.tryParse(value),
        );
        break;
      case 'lat':
        _clinic = _clinic?.copyWith(
          lat: double.tryParse(value),
        );
        break;

      case 'mobile':
        _clinic = _clinic?.copyWith(
          mobile: value,
        );
        break;
      case 'landline':
        _clinic = _clinic?.copyWith(
          landline: value,
        );
        break;

      case 'consultation_fees':
        _clinic = _clinic?.copyWith(
          consultation_fees: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      case 'followup_fees':
        _clinic = _clinic?.copyWith(
          followup_fees: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      case 'followup_duration':
        _clinic = _clinic?.copyWith(
          followup_duration: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      case 'discount':
        _clinic = _clinic?.copyWith(
          discount: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      default:
        return;
    }
    notifyListeners();
  }

  Future<Clinic?> createClinic(Clinic clinic) async {
    try {
      final response = await clinicService.createClinic(clinic);
      _clinic = response;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1), () async {
        await fetchClinics();
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Clinic?> updateClinic(String id, Map<String, dynamic> update) async {
    try {
      final response = await clinicService.updateClinic(id, update);
      _clinic = response;
      notifyListeners();
      await fetchClinics();
      return _clinic;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(String id, BuildContext context) async {
    try {
      await clinicService.deleteClinic(id, context);
      await fetchClinics();
    } catch (e) {
      rethrow;
    }
  }
}
