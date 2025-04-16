import 'package:doctopia_doctors/models/app_constants_model/_models/app_constant.dart';

class VisitType extends AppConstant {
  const VisitType({
    required super.id,
    required super.name_en,
    required super.name_ar,
  });

  factory VisitType.fromJson(Map<String, dynamic> map) {
    return VisitType(
      id: map['id'] as String,
      name_en: map['name_en'],
      name_ar: map['name_ar'],
    );
  }
}
