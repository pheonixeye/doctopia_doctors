import 'dart:convert';

import 'package:doctopia_doctors/models/city.dart';
import 'package:doctopia_doctors/models/governorate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PxGov extends ChangeNotifier {
  PxGov() {
    loadGovernorates();
  }

  List<Governorate>? _govs;
  List<Governorate>? get govs => _govs;

  Future<void> loadGovernorates() async {
    //TODO: change fetching method to that from database
    String data = await rootBundle.loadString('assets/json/gov.json');
    List<dynamic> jsonResult = json.decode(data);
    _govs = Governorate.list(jsonResult);
    notifyListeners();
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
