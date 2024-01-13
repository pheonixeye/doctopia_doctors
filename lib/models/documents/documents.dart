// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'documents.freezed.dart';
part 'documents.g.dart';

@freezed
class DoctorDocuments with _$DoctorDocuments {
  const factory DoctorDocuments({
    required String docid,
    required String synd_card,
    required String permit_cert,
    required String specialist_cert,
    required String consultant_cert,
    required String avatar,
  }) = _DoctorDocuments;

  factory DoctorDocuments.fromJson(Map<String, Object?> json) =>
      _$DoctorDocumentsFromJson(json);

  static Map<String, Type> scheme = {
    'docid': String,
    'synd_card': String,
    'permit_cert': String,
    'specialist_cert': String,
    'consultant_cert': String,
    'avatar': String,
  };
}
