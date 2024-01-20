// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'clinic.freezed.dart';
part 'clinic.g.dart';

@freezed
class Clinic with _$Clinic {
  const factory Clinic({
    required String doc_id,
    required String speciality_en,
    required String speciality_ar,
    required String name_en,
    required String name_ar,
    required String venue_en,
    required String venue_ar,
    required String gov_en,
    required String gov_ar,
    required String city_en,
    required String city_ar,
    required String mobile,
    required String landline,
    required String address_en,
    required String address_ar,
    required String location_link,
    required bool attendance,
    required bool published,
    required int fees,
    required int discount,
    required List<String> off_dates,
  }) = _Clinic;

  factory Clinic.fromJson(Map<String, Object?> json) => _$ClinicFromJson(json);

  static ({String id, Clinic clinic}) clinicRecord(
      String id, Map<String, Object?> json) {
    return (id: id, clinic: Clinic.fromJson(json));
  }

  factory Clinic.initial() {
    return const Clinic(
      doc_id: '',
      speciality_en: '',
      speciality_ar: '',
      name_en: '',
      name_ar: '',
      venue_en: '',
      venue_ar: '',
      gov_en: '',
      gov_ar: '',
      city_en: '',
      city_ar: '',
      mobile: '',
      landline: '',
      address_en: '',
      address_ar: '',
      location_link: '',
      attendance: false,
      published: false,
      fees: 0,
      discount: 0,
      off_dates: [],
    );
  }

  static const List<String> editableStrings = [
    "name_en",
    "name_ar",
    "venue_en",
    "venue_ar",
    "mobile",
    "landline",
    "address_en",
    "address_ar",
    "location_link",
    "fees",
    "discount",
  ];
  static const List<String> editableDropdowns = [
    "gov_en",
    "city_en",
    "attendance",
  ];

  static const List<String> editabList = [
    'off_dates',
  ];
}
