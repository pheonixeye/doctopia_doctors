import 'package:doctopia_doctors/models/app_constants_model/_models/app_constant.dart';

class ReviewStatus extends AppConstant {
  const ReviewStatus({
    required super.id,
    required super.name_en,
    required super.name_ar,
  });

  factory ReviewStatus.fromJson(Map<String, dynamic> map) {
    return ReviewStatus(
      id: map['id'] as String,
      name_en: map['name_en'],
      name_ar: map['name_ar'],
    );
  }
}
