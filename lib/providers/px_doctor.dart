// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/doctor_api/hx_doctor.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/degree.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/speciality.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class PxDoctor extends ChangeNotifier {
  final HxDoctor service;
  final String doc_id;

  PxDoctor({
    required this.service,
    required this.doc_id,
  }) {
    fetchDoctor();
  }

  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  DoctorResponseModel _model = DoctorResponseModel.initial();
  DoctorResponseModel get model => _model;

  void setDoctor({
    String? id,
    int? synd_id,
    String? name_en,
    String? name_ar,
    String? personal_phone,
    String? title_en,
    String? title_ar,
    String? about_en,
    String? about_ar,
    Speciality? speciality,
    Degree? degree,
  }) {
    _model = _model.copyWith(
      id: id ?? model.id,
      name_en: name_en ?? _model.name_en,
      name_ar: name_ar ?? _model.name_ar,
      title_en: title_en ?? _model.title_en,
      title_ar: title_ar ?? _model.title_ar,
      about_en: about_en ?? _model.about_en,
      about_ar: about_ar ?? _model.about_ar,
      synd_id: synd_id ?? _model.synd_id,
      personal_phone: personal_phone ?? _model.personal_phone,
      speciality_id: speciality?.id ?? _model.speciality_id,
      degree_id: degree?.id ?? _model.degree_id,
    );
    _doctor = Doctor.fromResponseModel(
      model: model,
      speciality: speciality,
      degree: degree,
    );

    notifyListeners();
  }

  Future<Doctor?> createDoctor() async {
    try {
      final doc = await service.createDoctor(doctor: _model);
      await fetchDoctor();
      return doc;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  void nullifyDoctor() {
    _doctor = null;
    _model = DoctorResponseModel.initial();
    notifyListeners();
  }

  Future<Doctor?> fetchDoctor() async {
    try {
      _doctor = await service.fetchDoctorById(id: doc_id);
      notifyListeners();
      return _doctor;
    } on ClientException catch (e) {
      _doctor = null;
      notifyListeners();
      dprint("PxDoctor().fetchDoctor(${e.response["message"]})");
      return null;
    }
  }

  Future<void> updateDoctorAvatar({
    required List<int> fileBytes,
    required String? fileName,
  }) async {
    await service.updateDoctorAvatar(
      id: doc_id,
      fileBytes: fileBytes,
      fileName: fileName,
    );
    await fetchDoctor();
  }

  Future<Doctor?> updateDoctor(Map<String, dynamic> update) async {
    try {
      final doc = await service.updateDoctor(
        id: doc_id,
        update: update,
      );
      _doctor = doc;
      notifyListeners();
      return doc;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
