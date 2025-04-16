import 'package:doctopia_doctors/models/app_constants_model/_models/app_constant.dart';

class Degree extends AppConstant {
  const Degree({
    required super.id,
    required super.name_en,
    required super.name_ar,
  });

  factory Degree.fromJson(Map<String, dynamic> map) {
    return Degree(
      id: map['id'] as String,
      name_en: map['name_en'],
      name_ar: map['name_ar'],
    );
  }
}
