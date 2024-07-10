import 'dart:convert';

import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/models/speciality.dart';
import 'package:flutter/services.dart';

class HxSpeciality {
  Future<List<Speciality>> fetchSpecialities() async {
    try {
      final specData = rootBundle.loadString(Assets.specialities);

      final String specs = await specData;

      final List<dynamic> specStructure = json.decode(specs);

      final _specialities =
          specStructure.map((e) => Speciality.fromJson(e)).toList();

      return _specialities;
    } catch (e) {
      rethrow;
    }
  }
}
