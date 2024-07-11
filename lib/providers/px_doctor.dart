// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/doctor_api/hx_doctor.dart';
import 'package:doctopia_doctors/models/destination.dart';
import 'package:doctopia_doctors/models/doctor/doctor.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class PxDoctor extends ChangeNotifier {
  final HxDoctor doctorService;
  final String id;
  PxDoctor({
    required this.doctorService,
    required this.id,
  }) {
    fetchDoctor();
  }

  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  void setDoctor({
    int? synd_id,
    String? joined_at,
    String? name_en,
    String? name_ar,
    String? personal_phone,
    String? speciality_en,
    String? speciality_ar,
    bool? published,
    String? title_en,
    String? title_ar,
    String? about_en,
    String? about_ar,
    String? degree_en,
    String? degree_ar,
    double? rating,
    List<String>? tags,
    int? views,
    List<Destination>? destinations,
  }) {
    _doctor ??= Doctor.emptyForCreate();
    _doctor = _doctor?.copyWith(
      id: id,
      synd_id: synd_id ?? _doctor?.synd_id,
      joined_at: DateTime.now().toIso8601String(),
      name_en: name_en ?? _doctor?.name_en,
      name_ar: name_ar ?? _doctor?.name_ar,
      personal_phone: personal_phone ?? _doctor?.personal_phone,
      speciality_en: speciality_en ?? _doctor?.speciality_en,
      speciality_ar: speciality_ar ?? _doctor?.speciality_ar,
      degree_en: degree_en ?? _doctor?.degree_en,
      degree_ar: degree_ar ?? _doctor?.degree_ar,
      published: published ?? _doctor?.published,
      title_en: title_en ?? _doctor?.title_en,
      title_ar: title_ar ?? doctor?.title_ar,
      about_en: about_en ?? _doctor?.about_en,
      about_ar: about_ar ?? _doctor?.about_ar,
      tags: [],
      views: 0,
      destinations: [],
    );
    notifyListeners();
  }

  Future<Doctor?> createDoctor() async {
    try {
      final doc = await doctorService.createDoctor(doctor: doctor!);
      await fetchDoctor();
      return doc;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  void nullifyDoctor() {
    _doctor = null;
    notifyListeners();
  }

  Future<Doctor?> fetchDoctor() async {
    try {
      final serverResult = await doctorService.fetchDoctorById(id: id);

      _doctor = serverResult;

      notifyListeners();

      return serverResult;
    } on ClientException catch (e) {
      _doctor = null;
      notifyListeners();
      if (kDebugMode) {
        print("PxDoctor().fetchDoctor(${e.response["message"]})");
      }
      return null;
      // throw Exception(e.response["message"]);
    }
  }

  Future<void> updateDoctorAvatar({
    required List<int> fileBytes,
    required String? fileName,
  }) async {
    await doctorService.updateDoctorAvatar(
      id: id,
      fileBytes: fileBytes,
      fileName: fileName,
    );
    await fetchDoctor();
  }

  Map<String, dynamic> _update = {};
  Map<String, dynamic> get update => _update;

  void setUpdate(String key, dynamic value) {
    _update[key] = value;
    notifyListeners();
  }

  void revertUpdate(String key) {
    _update.remove(key);
    notifyListeners();
  }

  Future<Doctor?> updateDoctor() async {
    try {
      final doc = await doctorService.updateDoctor(
        id: id,
        update: _update,
      );
      _doctor = doc;
      _update = {};
      notifyListeners();
      return doc;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
