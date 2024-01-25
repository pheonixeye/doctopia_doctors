// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/clinic_visits_api/hx_clinic_visits.dart';
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:flutter/material.dart';

class PxClinicVisits extends ChangeNotifier {
  final HxClinicVisits visitsService;
  final String? doc_id;

  PxClinicVisits({
    required this.doc_id,
    required this.visitsService,
  });

  int _day = DateTime.now().day;
  int get day => _day;
  int _month = DateTime.now().month;
  int get month => _month;
  int _year = DateTime.now().year;
  int get year => _year;

  List<({String id, ClinicVisit visit})> _data = [];
  List<({String id, ClinicVisit visit})> get data => _data;

  Future<void> setDate({int? d, int? m, int? y}) async {
    _day = d ?? _day;
    _month = m ?? _month;
    _year = y ?? _year;
    notifyListeners();
    await fetchClinicVisits();
  }

  Future<void> fetchClinicVisits() async {
    try {
      if (doc_id != null) {
        final result = await visitsService.fetchClinicVisits(
          doc_id: doc_id!,
          // clinic_id: clinic_id,
          day: day,
          month: month,
          year: year,
        );
        _data = result;
        notifyListeners();
        // print('called fetch visits');
      }
    } catch (e) {
      rethrow;
    }
  }
}
