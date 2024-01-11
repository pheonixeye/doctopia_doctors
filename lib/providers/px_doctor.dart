// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/doctor_api/hx_doctor.dart';
import 'package:doctopia_doctors/functions/password_hash_fns.dart';
import 'package:doctopia_doctors/models/doctor/doctor.dart';
import 'package:flutter/material.dart';

class PxDoctor extends ChangeNotifier {
  final HxDoctor doctorService;
  PxDoctor({required this.doctorService});

  Doctor _doctor = Doctor.initial();
  Doctor get doctor => _doctor;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void setDoctor({
    int? synd_id,
    String? joined_at,
    String? name_en,
    String? name_ar,
    String? personal_phone,
    String? assistant_phone,
    String? email,
    String? salt,
    String? password,
    String? speciality_en,
    String? speciality_ar,
    bool? published,
    List<String>? titles_en,
    List<String>? titles_ar,
    String? about_en,
    String? about_ar,
    String? degree_en,
    String? degree_ar,
  }) {
    _doctor = _doctor.copyWith(
      synd_id: synd_id ?? _doctor.synd_id,
      joined_at: joined_at ?? _doctor.joined_at,
      name_en: name_en ?? _doctor.name_en,
      name_ar: name_ar ?? _doctor.name_ar,
      personal_phone: personal_phone ?? _doctor.personal_phone,
      assistant_phone: assistant_phone ?? _doctor.assistant_phone,
      email: email ?? _doctor.email,
      salt: salt ?? _doctor.salt,
      password: password ?? _doctor.password,
      speciality_en: speciality_en ?? _doctor.speciality_en,
      speciality_ar: speciality_ar ?? _doctor.speciality_ar,
      degree_en: degree_en ?? _doctor.degree_en,
      degree_ar: degree_ar ?? _doctor.degree_ar,
      published: published ?? _doctor.published,
      titles_en: titles_en ?? _doctor.titles_en,
      titles_ar: titles_ar ?? doctor.titles_ar,
      about_en: about_en ?? _doctor.about_en,
      about_ar: about_ar ?? _doctor.about_ar,
    );
    notifyListeners();
  }

  Future<Doctor> createDoctor() async {
    try {
      final doc = await doctorService.createDoctor(doctor: doctor);
      return doc;
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor> fetchDoctor({
    required int synd_id,
    required String password,
  }) async {
    try {
      final serverResult =
          await doctorService.fetchDoctorBySyndId(synd_id: synd_id);

      final digest = retrievePassword(password, serverResult.salt);

      if (digest != serverResult.password) {
        throw WrongPasswordException(
          message: 'Wrong id / password combination.',
        );
      } else {
        _doctor = serverResult;
        _isLoggedIn = true;
        notifyListeners();
        return serverResult;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor> updateDoctor() async {
    try {
      final doc = await doctorService.updateDoctor(
        update: doctor,
      );
      _doctor = doc;
      notifyListeners();
      return doc;
    } catch (e) {
      rethrow;
    }
  }

  void logout() {
    _isLoggedIn = false;
    _doctor = Doctor.initial();
    notifyListeners();
  }
}
