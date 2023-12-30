// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/models/city.dart';
import 'package:equatable/equatable.dart';

class Governorate extends Equatable {
  final String id;
  final String governorate_name_en;
  final String governorate_name_ar;
  final List<City> cities;

  const Governorate({
    required this.id,
    required this.governorate_name_en,
    required this.governorate_name_ar,
    required this.cities,
  });

  factory Governorate.fromJson(dynamic json) {
    return Governorate(
      id: json['id'] as String,
      governorate_name_en: json['governorate_name_en'] as String,
      governorate_name_ar: json['governorate_name_ar'] as String,
      cities: City.cities(json['cities']),
    );
  }

  static List<Governorate> list(List<dynamic> json) {
    return json.map((e) => Governorate.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        governorate_name_en,
        governorate_name_ar,
        cities,
      ];
}
