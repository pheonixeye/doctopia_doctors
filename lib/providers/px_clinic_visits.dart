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

  static int? _dataTotalCount;
  int? get dataTotalCount => _dataTotalCount;

  Future<void> setDate({int? d, int? m, required int y}) async {
    // if (d != _day || m != _month || y != _year) {
    _data?.clear();
    _dataTotalCount = null;
    _page = 1;
    notifyListeners();
    // }
    _day = d;
    _month = m;
    _year = y;
    notifyListeners();
    await fetchClinicVisits();
  }

  Future<void> selectFilter(VisitFilter f) async {
    if (f == _filter) {
      return;
    }
    switch (f) {
      case VisitFilter.year_month_day:
        _day ??= DateTime.now().day;
        _month ??= DateTime.now().month;
        notifyListeners();
        break;
      case VisitFilter.year_month:
        _day = null;
        _month ??= DateTime.now().month;
        notifyListeners();
        break;
      case VisitFilter.year:
        _day = null;
        _month = null;
        notifyListeners();
        break;
    }
    if (_data != null) {
      _data!.clear();
      _dataTotalCount = null;
      _page = 1;
      notifyListeners();
    }
    _filter = f;
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
        page: 1,
        perPage: _perPage,
      );
      _isLoading = false;
      notifyListeners();
      _data = result!.$2;
      _dataTotalCount = result.$1;
      notifyListeners();
      _lastFetchResult = result.$2;
      debugPrint('PxClinicVisits().fetchClinicVisits($_page)');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchMoreVisits() async {
    if (_lastFetchResult.length < _perPage) {
      return;
    }
    _page++;
    debugPrint('PxClinicVisits().fetchMoreVisits($_page)');
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
      _data!.addAll(result!.$2);
      _dataTotalCount = result.$1;
      notifyListeners();
      _lastFetchResult = result.$2;
    } catch (e) {
      rethrow;
    }
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
