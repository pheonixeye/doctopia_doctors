// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/models/translatable/translatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'documents.freezed.dart';
part 'documents.g.dart';

@freezed
class DoctorDocuments with _$DoctorDocuments {
  const factory DoctorDocuments({
    required String synd_card,
    required String permit_cert,
    required String specialist_cert,
    required String consultant_cert,
    required String avatar,
  }) = _DoctorDocuments;

  factory DoctorDocuments.fromJson(Map<String, Object?> json) =>
      _$DoctorDocumentsFromJson(json);

  static Map<String, Type> scheme = {
    'synd_card': String,
    'permit_cert': String,
    'specialist_cert': String,
    'consultant_cert': String,
    'avatar': String,
  };

  static const Map<String, ModelTranslatable> _forWidgets = {
    'synd_card':
        ModelTranslatable(en: 'Syndicate Card', ar: 'صورة كارنيه النقابة'),
    'permit_cert': ModelTranslatable(
        en: 'Medical Practice Permit', ar: 'تصريح مزاولة المهنة'),
    'specialist_cert':
        ModelTranslatable(en: 'Specialist Certificate', ar: 'شهادة الاخصائي'),
    'consultant_cert':
        ModelTranslatable(en: 'Consultant Certificate', ar: 'شهادة الاستشاري'),
    'avatar': ModelTranslatable(en: 'Doctor Photo', ar: 'صورة الطبيب'),
  };

  static String keyToWidget(String key, bool isEnglish) {
    return isEnglish ? _forWidgets[key]!.en : _forWidgets[key]!.ar;
  }
}
