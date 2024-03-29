import 'package:doctopia_doctors/api/speciality_api/speciality.dart';
import 'package:doctopia_doctors/models/speciality.dart';
import 'package:flutter/material.dart';

class PxSpeciality extends ChangeNotifier {
  final HxSpeciality specialityService;

  PxSpeciality({
    required this.specialityService,
  });

  List<Speciality> _specialities = [];
  List<Speciality> get specialities => _specialities;

  Future<void> fetchSpecialities() async {
    try {
      _specialities = await specialityService.fetchSpecialities();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
