// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final int governorate_id;
  final String city_name_en;
  final String city_name_ar;

  const City({
    required this.id,
    required this.governorate_id,
    required this.city_name_en,
    required this.city_name_ar,
  });

  factory City.fromJson(dynamic json) {
    return City(
      id: int.parse(json['id'] as String),
      governorate_id: int.parse(json['governorate_id'] as String),
      city_name_en: json['city_name_en'] as String,
      city_name_ar: json['city_name_ar'] as String,
    );
  }

  static List<City> cities(List<dynamic> json) {
    return json.map((e) => City.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        governorate_id,
        city_name_en,
        city_name_ar,
      ];
}
