// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'clinic.freezed.dart';
part 'clinic.g.dart';

@freezed
class Clinic with _$Clinic {
  const factory Clinic({
    required String id,
    required String doc_id,
    required String speciality_en,
    required String speciality_ar,
    required String gov_en,
    required String gov_ar,
    required String city_en,
    required String city_ar,
    required String mobile,
    required String landline,
    required String address_en,
    required String address_ar,
    required String location_link,
    required String attendance,
    required List<String> schedule,
    required List<String> clinic_photos,
  }) = _Clinic;

  factory Clinic.fromJson(Map<String, Object?> json) => _$ClinicFromJson(json);
}
