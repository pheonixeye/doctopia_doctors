import 'dart:convert';

import 'package:doctopia_doctors/models/governorate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PxGov extends ChangeNotifier {
  PxGov() {
    load();
  }

  List<Governorate>? _govs;
  List<Governorate>? get govs => _govs;

  Future<void> load() async {
    String data = await rootBundle.loadString('assets/json/gov.json');
    List<dynamic> jsonResult = json.decode(data);
    _govs = Governorate.list(jsonResult);
    notifyListeners();
  }
}
