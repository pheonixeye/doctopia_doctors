// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'clinic_visit.freezed.dart';
part 'clinic_visit.g.dart';

@freezed
class ClinicVisit with _$ClinicVisit {
  const factory ClinicVisit({
    required String id,
    required String pt_name,
    required String pt_phone,
    required String doc_id,
    required String clinic_id,
    required String date,
  }) = _ClinicVisit;

  factory ClinicVisit.fromJson(Map<String, Object?> json) =>
      _$ClinicVisitFromJson(json);
}
