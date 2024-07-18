import 'package:doctopia_doctors/api/governorate_api/governorate_city.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_models/models/city.dart';
import 'package:proklinik_models/models/governorate.dart';

class PxGov extends ChangeNotifier {
  final HxGovCity govCityService;
  PxGov({required this.govCityService});

  List<Governorate>? _govs;
  List<Governorate>? get govs => _govs;

  Future<void> loadGovernorates() async {
    try {
      final governorates = await govCityService.fetchGovernorates();
      _govs = governorates.data;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Governorate? _selectedGov;
  Governorate? get selectedGov => _selectedGov;

  void selectGov(Governorate? value) {
    _selectedGov = value;
    _selectedCity = null;
    notifyListeners();
  }

  City? _selectedCity;
  City? get selectedCity => _selectedCity;

  void selectCity(City? value) {
    _selectedCity = value;
    notifyListeners();
  }
}
