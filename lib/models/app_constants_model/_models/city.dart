import 'package:doctopia_doctors/models/app_constants_model/_models/app_constant.dart';
import 'package:equatable/equatable.dart';

class City extends AppConstant implements Equatable {
  const City({
    required super.id,
    required super.name_en,
    required super.name_ar,
    required this.governorate_id,
  });

  final String governorate_id;

  @override
  bool get stringify => true;

  factory City.fromJson(Map<String, dynamic> map) {
    return City(
      id: map['id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      governorate_id: map['governorate_id'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': name_en,
      'name_ar': name_ar,
      'governorate_id': governorate_id,
    };
  }

  @override
  List<Object> get props => [...super.props, governorate_id];
}
