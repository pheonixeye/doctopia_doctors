import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor_response_model.dart';
import 'package:flutter/material.dart';

extension DoctorWidgetsExt on DoctorResponseModel {
  Map<String, String> editableStrings(BuildContext context) {
    return {
      'name_en': context.loc.engName,
      'name_ar': context.loc.arabicName,
      'title_en': context.loc.englishTitle,
      'title_ar': context.loc.arabicTitle,
      'about_en': context.loc.englishAbout,
      'about_ar': context.loc.arabicAbout,
      'personal_phone': context.loc.personalPhone,
      'degree_id': context.loc.practicalDegree,
    };
  }
}
