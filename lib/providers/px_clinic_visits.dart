// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/clinic_visits_api/hx_clinic_visits.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit_filter.dart';
import 'package:flutter/foundation.dart';

class PxClinicVisits extends ChangeNotifier {
  final HxClinicVisits visitsService;
  final String doc_id;

  PxClinicVisits({
    required this.doc_id,
    required this.visitsService,
  }) {
    fetchClinicVisits();
  }

  static VisitFilter _filter = VisitFilter.year_month_day;
  VisitFilter get filter => _filter;

  static int? _day = DateTime.now().day;
  int? get day => _day;
  static int? _month = DateTime.now().month;
  int? get month => _month;
  static int _year = DateTime.now().year;
  int get year => _year;

  static List<Visit> _lastFetchResult = [];

  static int _page = 1;
  int get page => _page;

  static const int _perPage = 5;

  static bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Visit>? _data;
  List<Visit>? get data => _data;

  Future<void> setDate({int? d, int? m, required int y}) async {
    _day = d;
    _month = m;
    _year = y;
    notifyListeners();
    await fetchClinicVisits();
  }

  Future<void> selectFilter(VisitFilter f) async {
    if (f != _filter) {
      switch (f) {
        case VisitFilter.year_month_day:
          _day ??= DateTime.now().day;
          _month ??= DateTime.now().month;
          break;
        case VisitFilter.year_month:
          _day = null;
          _month ??= DateTime.now().month;
          break;
        case VisitFilter.year:
          _day = null;
          _month = null;
          break;
      }
    }
    _filter = f;
    notifyListeners();
    if (_data != null) {
      _data?.clear();
    }
    notifyListeners();
    await fetchClinicVisits();
  }

  Future<void> fetchClinicVisits() async {
    try {
      _isLoading = true;
      notifyListeners();
      final result = await visitsService.fetchClinicVisits(
        doc_id: doc_id,
        day: day,
        month: month,
        year: year,
        page: _page,
        perPage: _perPage,
      );
      _isLoading = false;
      notifyListeners();
      _data ??= [];
      _data?.addAll(result!);
      notifyListeners();
      _lastFetchResult = _data ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchMoreVisits() async {
    if (_data != null && _lastFetchResult.length < _perPage) {
      return;
    }
    print('PxClinicVisits().fetchMoreVisits($_page)');
    _page++;
    await fetchClinicVisits();
  }

  Future<void> updateClinicVisit(String id, Map<String, dynamic> update) async {
    try {
      await visitsService.updateClinicVisit(
        id: id,
        update: update,
      );
      await fetchClinicVisits();
    } catch (e) {
      rethrow;
    }
  }
}
