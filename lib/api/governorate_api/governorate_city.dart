// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'dart:convert';
import 'package:doctopia_doctors/assets/assets.dart';
import 'package:flutter/services.dart';
import 'package:proklinik_models/proklinik_models.dart';

class HxGovCity {
  const HxGovCity();
  Future<Governorates> fetchGovernorates() async {
    final govData = rootBundle.loadString(Assets.governorates);

    final String govs = await govData;

    final List<dynamic> govStructure = json.decode(govs);

    final _governorates =
        govStructure.map((e) => Governorate.fromJson(e)).toList();

    try {
      Governorates governorates = Governorates(data: _governorates);
      return governorates;
    } catch (e) {
      rethrow;
    }
  }
}
